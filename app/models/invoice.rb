class Invoice < ActiveRecord::Base
  belongs_to :client
  has_many :items, class_name: 'InvoiceItem', validate: true, autosave: true, dependent: :destroy
  
  validates :client, :currency, presence: true
  
  def total
    items.sum(:amount)
  end
  
  def reference
    format 'JM%06d', id
  end
  
  def send!
    transaction do
      self.lock!
      InvoiceMailer.issue(self).deliver
      self.update_attributes sent: true, sent_at: Date.today unless sent?
    end
  end
end
