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
FactoryBot.define do
  factory :user do
    username { 'test' }
    password { '1234567a' }
    email { 'test@gmail.com' }
    gender { 1 }
    bio { 'MyText' }
  end
end
