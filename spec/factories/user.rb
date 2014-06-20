FactoryGirl.define do
  factory :user do
    name "Shaun Koo"
    email "shaun@example.com"
    password "helloworld"
    password_confirmation "helloworld"
    confirmed_at Time.now
  end
end