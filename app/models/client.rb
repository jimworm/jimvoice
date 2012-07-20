class Client < ActiveRecord::Base
  attr_accessible :email, :name
  
  has_many :invoices
  
  validates :email, :name, presence: true
  validates :email, uniqueness: true, format: { with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }  
end
