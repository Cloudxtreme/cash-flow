FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name 'Smith'
    email 'example@example.com'
    password 'changeme'
    role 'customer'
  end
end
