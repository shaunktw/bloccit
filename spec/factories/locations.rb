# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    address "MyText"
    place_id "MyString"
    postal_code "MyString"
    country "MyString"
  end
end
