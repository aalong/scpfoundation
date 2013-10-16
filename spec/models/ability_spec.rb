require 'spec_helper'

describe Ability do
  describe 'as guest' do
    let (:ability) { Ability.new nil }
    subject { ability }

    it { should be_able_to :read, User }
    it { should be_able_to :read, Fabricate(:room) }
    it { should be_able_to :read, Namespace.find_by_name('main') }
  end

  describe 'as user' do
    let (:user) { Fabricate(:user) }
    let (:ability) { Ability.new user }
    subject { ability }

    it 'should be able to access some private rooms' do
      private_room = Fabricate(:private_room)
      private_room.users << user
      should be_able_to :read, private_room
      should be_able_to :use, private_room
    end

    it 'should be able to access some private pages' do
      private_namespace = Fabricate(:private_namespace)
      private_page = Fabricate(:page, namespace: private_namespace)
      private_page.users << user
      should be_able_to :read, private_page
    end

    it 'should be able to manage his notifications' do
      notification = Fabricate(:notification, user: user)
      should be_able_to :read, notification
      should be_able_to :destroy, notification
    end

    it { should be_able_to :read, Namespace.find_by_name('drafts') }
  end

  describe 'as member' do
    let (:user) { Fabricate(:member) }
    let (:ability) { Ability.new user }
    subject { ability }

    it { should be_able_to :read, Fabricate(:community_room) }
    it { should be_able_to :use, Fabricate(:community_room) }
    it { should be_able_to :use, Fabricate(:community_room) }
    it { should be_able_to :create, Room }
    it { should be_able_to :read, Namespace.find_by_name('meta') }
    it { should be_able_to :use, Namespace.find_by_name('meta') }
  end

  describe 'as established member' do
    let (:user) { Fabricate(:established_member) }
    let (:ability) { Ability.new user }
    subject { ability }
    it { should be_able_to :use, Namespace.find_by_name('main') }
  end

  describe 'as trusted member' do
    let (:user) { Fabricate(:trusted_member) }
    let (:ability) { Ability.new user }
    subject { ability }
  end

  describe 'as moderator' do
    let (:user) { Fabricate(:moderator) }
    let (:ability) { Ability.new user }
    subject { ability }

    it 'should be able to edit some private rooms' do
      private_room = Fabricate(:private_room)
      private_room.users << user
      should be_able_to :read, private_room
      should be_able_to :use, private_room
      should be_able_to :edit, private_room
      should be_able_to :update, private_room
    end
  end

  describe 'as admin' do
    let (:user) { Fabricate(:admin) }
    let (:ability) { Ability.new user }
    subject { ability }
  end
end
