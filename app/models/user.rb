class User < ActiveRecord::Base
  attr_accessible :name, :password
  has_secure_password
  validates :name, presence: true, length: {minimum: 4}
end
