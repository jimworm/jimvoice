class AddCurrencyToInvoice < ActiveRecord::Migration
  def change
    change_table :invoices do |t|
      t.string :currency, length: 3
    end
  end
end
