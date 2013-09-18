require 'spec_helper'

describe Ability do
  describe 'as guest' do
    let (:ability) { Ability.new nil }
    subject { ability }

    it { should be_able_to :read, User }
    it { should be_able_to :read, Fabricate(:room) }
  end

  describe 'as user' do
    let (:user) { Fabricate(:user) }
    let (:ability) { Ability.new user }
    subject { ability }
  end

  describe 'as member' do
    let (:user) { Fabricate(:member) }
    let (:ability) { Ability.new user }
    subject { ability }

    it { should be_able_to :read, Fabricate(:protected_room) }
  end

  describe 'as established member' do
    let (:user) { Fabricate(:established_member) }
    let (:ability) { Ability.new user }
    subject { ability }
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
  end

  describe 'as admin' do
    let (:user) { Fabricate(:admin) }
    let (:ability) { Ability.new user }
    subject { ability }
  end
end
