# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  post_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Like, type: :model do
  let!(:article) { create(:post) }

  context 'when user likes a post' do
    it 'create a like when like once' do
      expect(article.liked_by(article.user)).to be_truthy
    end

    it 'destroy a like when like twice' do
      article.liked_by(article.user)
      expect(article.liked_by(article.user)).to be_falsy
    end
  end
end
