# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  customer_id            :string(255)
#  last_4_digits          :string(255)
#  role                   :string(255)
#  first_name             :string(255)
#  last_name              :string(255)
#

class User < ActiveRecord::Base

  has_many :subscriptions, :dependent => :destroy

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :remember_me, :stripe_token, :coupon, :role, :first_name, :last_name, :last_4_digits, :customer_id
  attr_accessor :stripe_token, :coupon

  attr_accessible :roles_attributes

  # before_save :update_stripe
  # before_destroy :cancel_subscription

  # only called when the user finally puts in a card
  def save_with_stripe
    begin
      self.save
      Stripe::Customer.create :id => self.id, :amount => self.amount, :interval => 'month', :name => self.name, :currency => 'usd'
    rescue Stripe::StripeError => e
      self.destroy
      logger.error "Stripe Error: " + e.message
      errors.add :base, "#{e.message}."
      false
    end
  end

  def name
    "#{first_name} #{last_name}"
  end

  def update_with_stripe attributes
    begin
      self.update_attributes attributes
      sp = Stripe::Plan.retrieve(self.id.to_s)
      sp.delete
      Stripe::Plan.create :id => self.id, :amount => self.amount, :interval => 'month', :name => self.name, :currency => 'usd'
    rescue Stripe::StripeError => e
      logger.error "Stripe Error: " + e.message
      errors.add :base, "#{e.message}."
      false
    end
  end

  def destroy_with_stripe
    begin
      c = Stripe::Customer.retrieve(self.id.to_s)
      c.delete
      self.destroy
    rescue Stripe::StripeError => e
      logger.error "Stripe Error: " + e.message
      errors.add :base, "#{e.message}."
      false
    end
  end

  def update_plan(role)
    self.role_ids = []
    self.add_role(role.name)
    unless customer_id.nil?
      customer = Stripe::Customer.retrieve(customer_id)
      customer.update_subscription(:plan => role.name)
    end
    true
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "Unable to update your subscription. #{e.message}."
    false
  end
  
  def update_with_stripe(subscription, attributes)
    return if email.include?(ENV['ADMIN_EMAIL'])

    if attributes[:password].nil? or attributes[:password] == ''
      attributes[:password] = Devise.friendly_token[0,20]
    end

    self.update_attributes attributes

    if customer_id.nil?
      if !stripe_token.present?
        raise "Stripe token not present. Can't create account."
      end

      customer = Stripe::Customer.create(
        :email => email,
        :description => name,
        :card => stripe_token,
        :plan => subscription.plan.id
      )

    else
      customer = Stripe::Customer.retrieve(customer_id)
      if stripe_token.present?
        customer.card = stripe_token
      end
      customer.email = email
      customer.description = name
      customer.save
    end
    self.last_4_digits = customer.active_card.last4
    self.customer_id = customer.id
    self.stripe_token = nil

    logger.debug '================'
    logger.debug 'Stripe customer created'
    return true
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "#{e.message}."
    self.stripe_token = nil
    return false
  end
  
  def cancel_subscription
    unless customer_id.nil?
      customer = Stripe::Customer.retrieve(customer_id)
      unless customer.nil? or customer.respond_to?('deleted')
        if customer.subscription.status == 'active'
          customer.cancel_subscription
        end
      end
    end
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "Unable to cancel your subscription. #{e.message}."
    false
  end
  
  def expire
    UserMailer.expire_email(self).deliver
    destroy
  end

  def is?(role)
    self.role == role || self.role.to_sym == role
  end
  
end
