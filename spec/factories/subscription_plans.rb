# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subscription_plan do
    stripe_id "MyString"
    amount 1
    interval "MyString"
    name "MyString"
  end
end
