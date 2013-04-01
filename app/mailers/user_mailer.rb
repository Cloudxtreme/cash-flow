class UserMailer < ActionMailer::Base
  default :from => "\"Warnock and Polivka Inc\" <hello@victoryframework.com>"
  
  def expire_email(user)
    mail(:to => user.email, :subject => "Subscription Cancelled")
  end

  def subscription_signup(user, subscription)
    @user = user
    @subscription = subscription
    mail(:to => "\"#{user.name}\" <#{user.email}>", :subject => "Subscription to Warnock and Polivka, Inc")
  end

  def notify_customer_of_signup(user, subscription)
    @user = user
    @subscription = subscription
    mail(:to => "\"#{user.name}\" <#{user.email}>", :subject => "Receipt of subscription")
  end

  def notify_admin_of_signup(user, subscription)
    @user = user
    @subscription = subscription
    mail(:to => "\"#{user.name}\" <#{user.email}>", :subject => "#{user.name} has signed up for a subscription")
  end

  def notify_admin_of_victory_signup(victory_purchase)
    @victory_purchase = victory_purchase
    mail(:to => "\"Victory Team\" <hello@victoryframework.com>", :subject => "#{victory_purchase.first_name} #{victory_purchase.last_name} has purchased a license")
  end

  def notify_victory_customer(victory_purchase)
    @victory_purchase = victory_purchase
    mail(:to => "\"#{victory_purchase.first_name} #{victory_purchase.last_name}\" <#{victory_purchase.email}>", :subject => "Victory Framework license")    
  end

end