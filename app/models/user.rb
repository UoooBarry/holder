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
class User < ApplicationRecord
  include SubscribeCommunityConcern
  include SoftDeleteable

  has_secure_password
  validates :email, :username, presence: true
  validates :username, length: { minimum: 4, maximum: 20 }
  validates :email, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/
  validates :username, uniqueness: true

  # only validate when password is provided
  validates :password, presence: true, length: { minimum: 8, maximum: 20 }, if: :password

  has_many :refresh_tokens, dependent: :destroy
  has_many :communities_users, class_name: 'CommunitiesUser', dependent: :destroy
  has_many :communities, through: :communities_users
  has_many :posts, dependent: :destroy
  has_many :created_communities, class_name: 'Community', foreign_key: 'creator_id', dependent: :nullify,
                                 inverse_of: :creator
  has_many :liked_posts, through: :likes

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

  def created_communities
    Community.where(creator_id: id)
  end

  def like(post)
    post.liked_by(self)
  end
end
