FactoryGirl.define do
  factory :invoice_item do
    association :invoice
    sequence(:name) {|n| "Item #{n}"}
    description 'Boring description'
    amount 100.0
  end
end