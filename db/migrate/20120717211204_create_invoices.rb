class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.references :client
      t.boolean :sent, default: false
      t.date :sent_at
      t.boolean :paid, default: false
      
      t.timestamps
    end
    add_index :invoices, :client_id
    add_index :invoices, :sent
    add_index :invoices, :sent_at
    add_index :invoices, :paid
  end
end
