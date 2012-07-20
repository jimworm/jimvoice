class CreateInvoiceItems < ActiveRecord::Migration
  def change
    create_table :invoice_items do |t|
      t.references :invoice
      t.string :name
      t.text :description
      t.decimal :amount, precision: 10, scale: 2
    end
    add_index :invoice_items, :invoice_id
  end
end
