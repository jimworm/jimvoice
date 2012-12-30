class Invoice < ActiveRecord::Base
  belongs_to :client
  has_many :items, class_name: 'InvoiceItem', validate: true, autosave: true, dependent: :destroy
  
  validates :client, :currency, presence: true
  validates :currency, length: {is: 3}
  
  def issued?
    sent? or paid?
  end
  
  def total
    items.sum(:amount)
  end
  
  def reference
    format 'JM%06d', id
  end
  
  def send!
    fail 'Only saved invoices can be issued' unless persisted?
    fail 'Invoices must have items to be issued' if items.empty?
    
    transaction do
      self.lock!
      InvoiceMailer.issue(self).deliver
      unless sent?
        self.sent = true
        self.sent_at = Date.today
      end
      self.save!
    end
  end
end
