require 'spec_helper'

describe Ability do
  describe 'as guest' do
    let (:ability) { Ability.new nil }
    subject { ability }

    it { should be_able_to :read, User }
  end
end
