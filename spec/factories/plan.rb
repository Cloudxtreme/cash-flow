FactoryGirl.define do
  factory :plan do
    amount 2000
    interval 'month'
    name 'Sample Plan'
    stripe_id 1
    trial_period_days 4
  end
end