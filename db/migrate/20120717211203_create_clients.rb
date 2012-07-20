class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :email, nil: false
      t.string :name, nil: false
      
      t.timestamps
    end
    add_index :clients, :email
  end
end
