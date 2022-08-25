# == Schema Information
#
# Table name: communities
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  creator_id  :bigint
#
require 'rails_helper'

RSpec.describe Community, type: :model do
  let!(:user) { create(:user) }

  describe 'validations' do
    subject { Community.new(name: 'TestHere') }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:name) }
  end

  it 'is valid with valid community' do
    expect(Community.new(name: 'TestTest')).to be_valid
  end

  context 'when creating a community' do
    it 'should auto set creator to subscribed' do
      community = user.created_communities.create(name: 'TestTest')
      expect(user.subscribe?(community)).to be_truthy
    end
  end
end
