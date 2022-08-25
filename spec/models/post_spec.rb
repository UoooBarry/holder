# == Schema Information
#
# Table name: posts
#
#  id           :bigint           not null, primary key
#  user_id      :bigint           not null
#  community_id :bigint           not null
#  post_id      :bigint
#  title        :string           not null
#  content      :text             not null
#  status       :integer          default("draft"), not null
#  pin          :boolean          default(FALSE), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:community_id) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
  end
end
