FactoryGirl.define do
  factory :invoice do
    association :client
  end
end