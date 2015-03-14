# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :wifi_hotspot do
    name "MyString"
    address "MyString"
    longitude "MyString"
    latitude "MyString"
    city nil
  end
end
