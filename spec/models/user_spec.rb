require 'spec_helper'

describe User do
  let(:attr) do
    {
      username: 'Test User',
      email: 'test@example.com',
      password: 'foobarfoobar',
      password_confirmation: 'foobarfoobar'
    }
  end

  it 'should correctly save display_name' do
    user = User.create attr
    expect(user.username).to eq 'test-user'
    expect(user.display_name).to eq 'Test User'
  end

  it 'should check username for uniqueness' do
    user1 = User.create attr
    user2 = User.new attr.merge(email: 'test2@example.com', username: 'Test-User')
    user2.should_not be_valid
  end

  it 'should return username when calling to_param' do
    user = User.create attr
    user.to_param.should eq user.username
  end

  it 'should replace some chars like wikidot' do
    user = Fabricate.build(:user, username: 'Test - 001')
    user.should be_valid
    user.username.should eq 'test-001'
  end

  it 'should replace few spaces in display_name with one' do
    user = Fabricate.build(:user, username: '    Test     -    001     ')
    user.should be_valid
    user.username.should eq 'test-001'
    user.display_name.should eq 'Test - 001'
  end

  it 'should validate email' do
    user1 = Fabricate.build(:user, email: 'foo')
    user1.should_not be_valid
    user2 = Fabricate(:user)
    user3 = Fabricate.build(:user, email: user2.email)
    user3.should_not be_valid
  end

  it 'should generate authentication token after create' do
    Fabricate(:user).authentication_token.should_not be_blank
  end

  describe 'roleable' do
    let(:user) { Fabricate(:user) }

    it 'should has 1 point of reputation after sign up' do
      user.reputation.should eq 1
    end

    it 'should be simple user after registration' do
      user.should_not be_member
    end

    it 'with 500 reputation should be member' do
      user.reputation = 500
      user.should be_member
    end

    it 'with 2000 reputation should be established member' do
      user.reputation = 2000
      user.should be_established
    end

    it 'with 5000 reputation should be trusted member' do
      user.reputation = 5000
      user.should be_trusted
    end

    it 'with 15000 reputation should be moderator' do
      user.reputation = 15000
      user.should be_moderator
    end

    it 'with 30000 reputation should be administrator' do
      user.reputation = 30000
      user.should be_admin
    end

    it 'should get reputation points from granting permissions' do
      user.role.should eq :registered_user
      user.reputation.should eq 1

      user.set_role :member
      user.reputation.should eq 500

      user.set_role :established_member
      user.reputation.should eq 2000

      user.set_role :trusted_member
      user.reputation.should eq 5000

      user.set_role :moderator
      user.reputation.should eq 15000

      user.set_role :admin
      user.reputation.should eq 30000

      user.set_role :registered_user
      user.reputation.should eq 1
    end

    it 'only moderators and admins are staf' do
      user = Fabricate(:user)
      moderator = Fabricate(:user)
      admin = Fabricate(:user)

      moderator.set_role :moderator
      admin.set_role :admin

      user.should_not be_staff
      user.should be_regular

      moderator.should be_staff
      moderator.should_not be_regular
      admin.should be_staff

      admin.should_not be_regular
    end

    it 'role= method set reputation, but does not save the model' do
      user.role = :moderator
      user.reputation.should eq 15000
      user.reload
      user.reputation.should eq 1
    end
  end

  describe 'bio & properties' do
    let (:user) { Fabricate(:user) }
    subject { user }

    its(:real_name) { should_not be_blank }
    its(:timezone) { should eq ENV['default_timezone'] }

    it 'should return correct birthday date' do
      user.birthday = '1993-02-03'
      user.birthdate.strftime("%Y-%m-%d").should eq user.birthday
    end
  end
end
