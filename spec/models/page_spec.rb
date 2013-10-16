require 'spec_helper'

describe Page do
  describe 'Versionable' do
    let (:namespace) { Fabricate(:namespace) }
    let (:user) { Fabricate(:member) }
    let (:page) { Fabricate(:page, user: user, namespace: namespace) }
    subject { page }

    it 'should have blank versions array' do
      page.versions.should eq []
    end

    it 'should create new version after page change' do
      current_content = page.content
      page.editor_id = user.id
      page.content = 'hello'
      page.commit_message = 'test update'
      page.save
      page.versions.length.should eq 1
      version = page.versions.last
      version.content.should eq current_content
      page.content = 'hello again'
      page.commit_message = 'another'
      page.save
      page.versions.length.should eq 2
      version = page.versions.last
      version.content.should eq 'hello'
      version.commit_message.should eq 'test update'
    end

    it 'should rollback corectly' do
      current_content = page.content
      page.editor_id = user.id
      page.content = 'hello'
      page.commit_message = 'test update'
      page.save
      page.rollback page.versions.last
      page.content.should eq current_content
    end
  end
end
