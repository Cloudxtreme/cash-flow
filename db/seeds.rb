puts 'REMOVING OLD DATA'
User.destroy_all
Subscription.destroy_all
Plan.destroy_all


puts 'DEFAULT USERS'
user = User.find_or_create_by_email :role => 'admin', :first_name => ENV['ADMIN_FIRST_NAME'].dup, :last_name => ENV['ADMIN_LAST_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup
puts 'user: ' << user.name

puts 'SUBSCRIPTIONS'
