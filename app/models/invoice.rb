class Invoice < ActiveRecord::Base
  belongs_to :client
  has_many :items, class_name: 'InvoiceItem', validate: true, autosave: true, dependent: :destroy
  
  validates :client, presence: true
  
  def total
    items.sum(:amount)
  end
end
