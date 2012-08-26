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
      unless sent?
        self.sent = true
        self.sent_at = Date.today
      end
      self.save!
    end
  end
end
