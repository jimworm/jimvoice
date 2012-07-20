class InvoiceItem < ActiveRecord::Base
  attr_accessible :amount, :name, :description
  belongs_to :invoice
  
  validates :amount, :name, :invoice, presence: true
  validates :amount, numericality: true
  validates :amount, :name, :description, change: false, on: :update, :if => lambda{invoice.paid?}
  validates :amount, :name, :description, change: false, on: :update, :if => lambda{invoice.sent?}
  
end
