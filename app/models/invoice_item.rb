class InvoiceItem < ActiveRecord::Base
  attr_accessible :amount, :name, :description
  belongs_to :invoice
  
  validates :amount, :name, :invoice, presence: true
  validates :amount, numericality: true
  
  validate :invoice_issued, :if => lambda{ invoice }
  
  before_destroy :invoice_issued
  
  private
  def invoice_issued
    errors.add(:base, 'Invoice has already been issued') and return false if invoice.issued?
  end
end
