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
  let!(:community) { create(:community) }

  describe 'validations' do
    subject { Community.new(name: 'TestHere') }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:name) }
  end

  it 'is valid with valid community' do
    expect(Community.new(name: 'TestTest')).to be_valid
  end

  context 'when creating a community' do
    it 'should auto set the creator to subscribed' do
      community = user.created_communities.create(name: 'TestTest')
      expect(user.subscribe?(community)).to be_truthy
    end

    it 'should auto set the creator to an admin' do
      community = user.created_communities.create(name: 'TestTest')
      expect(user.admin_of?(community)).to be_truthy
    end
  end

  context 'when adding an admin to this community' do
    it 'should add the user to the community admins' do
      community.admin!(user)
      expect(user.admin_of?(community)).to be_truthy
    end

    it 'should raise an error if the user is already an admin' do
      community.admin!(user)

      expect { community.admin!(user) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
