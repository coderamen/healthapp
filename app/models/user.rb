class User < ApplicationRecord
  include Clearance::User

  has_many :pendings
  has_many :confirmed_activities

  def self.create_with_auth_and_hash(authentication, auth_hash)
    user = User.create!(name: auth_hash["name"], email: auth_hash["extra"]["raw_info"]["email"])
    user.authentications << (authentication)
    return user
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end
end
