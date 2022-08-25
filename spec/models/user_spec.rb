# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  email           :string           not null
#  gender          :integer          default("secret")
#  age             :integer
#  bio             :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  is_deleted      :boolean          default(FALSE), not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }
  let!(:community) { create(:community) }

  describe 'validations' do
    subject { User.new(username: 'uooobarry', password: 'noexceptions:)', email: 'test@test.com') }
    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:username) }
    it { should validate_length_of(:password) }
  end

  it 'is valid with valid user' do
    expect(User.new(email: 'test@test.com',
                    username: 'joey',
                    password: 'pwd123123',
                    bio: 'Hello world',
                    gender: User.genders[:male],
                    age: 22)).to be_valid
  end

  context 'when subsribing to a community' do
    it 'can subscribe to a community' do
      user.subscribe!(community.id)
      subscribed = user.subscribe?(community.id)
      expect(subscribed).to be_truthy
    end

    it 'cannot subscribe to a community twice' do
      expect do
        user.subscribe!(community.id)
        user.subscribe!(community.id)
      end.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'can unsubscribe from a community' do
      expect do
        user.subscribe!(community.id)
        user.unsubscribe!(community.id)
      end.not_to raise_error
    end
  end
end
