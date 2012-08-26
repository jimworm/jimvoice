FactoryGirl.define do
  factory :invoice do
    currency 'usd'
    association :client
  end
end