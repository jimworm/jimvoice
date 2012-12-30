class InvoiceItem < ActiveRecord::Base
  attr_accessible :amount, :name, :description
  belongs_to :invoice
  
  validates :amount, :name, :invoice, presence: true
  validates :amount, numericality: true
  
  validate :invoice_sent_or_paid, :if => lambda{ invoice }
  
  before_destroy :invoice_sent_or_paid
  
  private
  def invoice_sent_or_paid
    errors.add(:base, 'Invoice has already been issued') and return false if invoice.paid? or invoice.sent?
  end
end
