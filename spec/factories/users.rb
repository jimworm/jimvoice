FactoryGirl.define do
  factory :user do
    sequence(:name)   {|n| "user"}
    password          "password"
    password_confirmation "password"
  end
end