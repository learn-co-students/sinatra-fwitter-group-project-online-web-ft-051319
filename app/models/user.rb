class User < ActiveRecord::Base
  include Slugged::InstanceMethods
  extend Slugged::ClassMethods
  
  has_secure_password
  has_many :tweets
end
