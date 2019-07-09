class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    slug = self.username.gsub(" ", "-")
    slug
  end

  def self.find_by_slug(slug)
    unslug = slug.gsub("-", " ")
    user = User.find_by(username: unslug)
    user
  end
end
