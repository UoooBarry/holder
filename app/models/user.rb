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
class User < ApplicationRecord
  has_secure_password
  validates :email, :username, :password, presence: true
  validates :password, length: { minimum: 8 }
  validates :email, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/

  has_many :refresh_tokens, dependent: :destroy

  enum gender: {
    secret: 0,
    male: 1,
    female: 2
  }

  def to_token
    Jwt::IssueService.call(self)
  end

  def to_payload
    {
      id: id,
      email: email,
      gender: gender,
      username: username
    }
  end

  def authenticated?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end
end
