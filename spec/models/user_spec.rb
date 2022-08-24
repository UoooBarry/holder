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
#
require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_uniqueness_of(:username) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password) }
  it { shoudld validates_length_of :username, within: 4..20 }
  it { shoudld validates_length_of :password, within: 8..30 }

  it 'is valid with valid user' do
    expect(User.new(email: 'test@test.com',
                    username: 'joey',
                    password: 'pwd123123',
                    bio: 'Hello world',
                    gender: User.genders[:male],
                    age: 22)).to be_valid
  end
end