# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subscription do
    monthly_amount 1
    stripe_customer_id 1
  end
end
