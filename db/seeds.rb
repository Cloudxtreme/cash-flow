puts 'REMOVING OLD DATA'
User.destroy_all
VictoryFramework.destroy_all
VictoryPurchase.destroy_all


puts 'DEFAULT USERS'
user = User.find_or_create_by_email :role => 'admin', :first_name => 'Connor' , :last_name => 'Warnock', :email => 'connorwarnock@gmail.com', :password => 'randompass'
puts 'user: ' << user.name

puts 'VICTORY FRAMEWORKS'
main = VictoryFramework.create :name => 'main', :title => 'Victory Framework', :price => 19900
second = VictoryFramework.create :name => 'second', :title => 'Victory Framework (discounted)', :price => 9900
