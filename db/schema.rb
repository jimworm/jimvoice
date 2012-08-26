# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120826074401) do

  create_table "clients", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "clients", ["email"], :name => "index_clients_on_email"

  create_table "invoice_items", :force => true do |t|
    t.integer "invoice_id"
    t.string  "name"
    t.text    "description"
    t.decimal "amount",      :precision => 10, :scale => 2
  end

  add_index "invoice_items", ["invoice_id"], :name => "index_invoice_items_on_invoice_id"

  create_table "invoices", :force => true do |t|
    t.integer  "client_id"
    t.boolean  "sent",       :default => false
    t.date     "sent_at"
    t.boolean  "paid",       :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "currency"
  end

  add_index "invoices", ["client_id"], :name => "index_invoices_on_client_id"
  add_index "invoices", ["paid"], :name => "index_invoices_on_paid"
  add_index "invoices", ["sent"], :name => "index_invoices_on_sent"
  add_index "invoices", ["sent_at"], :name => "index_invoices_on_sent_at"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
