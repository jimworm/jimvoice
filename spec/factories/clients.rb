FactoryGirl.define do
  factory :client do
    sequence(:name)   {|n| "client"}
    sequence(:email)  {|n| "email_#{n}@example.com"}
  end
end