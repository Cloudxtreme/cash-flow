# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :victory_purchase do
    user_id 1
    stripe_charge_id "MyString"
    last_4 1
    license_key "MyString"
  end
end
