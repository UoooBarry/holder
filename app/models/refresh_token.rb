# == Schema Information
#
# Table name: refresh_tokens
#
#  id            :bigint           not null, primary key
#  user_id       :bigint           not null
#  crypted_token :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class RefreshToken < ApplicationRecord
  belongs_to :user
  before_create :set_crypted_token

  attr_accessor :token

  def self.fetch(token)
    crypted_token = Digest::SHA256.hexdigest token
    RefreshToken.find_by(crypted_token: crypted_token)
  end

  private

  def set_crypted_token
    self.token = SecureRandom.hex
    self.crypted_token = Digest::SHA256.hexdigest(token)
  end
end
