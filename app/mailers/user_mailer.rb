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

end