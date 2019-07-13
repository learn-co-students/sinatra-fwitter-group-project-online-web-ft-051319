class User < ActiveRecord::Base
  has_secure_password

  has_many :tweets
  attr_accessor :slug

  def slug
    @username=self.username.parameterize

  end

  def self.find_by_slug(slug)
    uname = slug.gsub(/-/,' ')
    self.find_by(username: "#{uname}")
  end

end
