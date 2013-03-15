# == Schema Information
#
# Table name: subscriptions
#
#  id         :integer          not null, primary key
#  plan_name  :string(255)
#  user_id    :integer
#  plan_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  token      :string(255)
#  active     :boolean
#

class Subscription < ActiveRecord::Base
  attr_accessible :monthly_amount, :stripe_customer_id, :user_attributes, :plan_attributes, :user_id, :plan_id, :token

  belongs_to :user
  belongs_to :plan

  after_save :notify

  accepts_nested_attributes_for :user, :allow_destroy => true
  accepts_nested_attributes_for :plan, :allow_destroy => true

  def notify
    UserMailer.subscription_signup(self.user, self).deliver
  end

  def generate_token
    self.token = (0...20).map{(65+rand(26)).chr}.join
  end

  def complete_signup(attributes)
    self.user.update_with_stripe self, attributes[:user_attributes]

    self.active = true
    self.save

    UserMailer.notify_customer_of_signup(self.user, self).deliver
    UserMailer.notify_admin_of_signup(self.user, self).deliver
  end

  def save_with_stripe
    begin
      self.save
      # cu = Stripe::Customer.retrieve(self.user.customer_id)
      # cu.update_subscription(:plan => {PLAN_ID})
      # Stripe::Plan.create :id => self.id, :amount => self.amount, :interval => 'month', :name => self.name, :currency => 'usd'
    rescue Stripe::StripeError => e
      self.destroy
      logger.error "Stripe Error: " + e.message
      errors.add :base, "#{e.message}."
      false
    end
  end

  def destroy_with_stripe
    begin
      # sp = Stripe::Plan.retrieve(self.id.to_s)
      # sp.delete
      self.destroy
    rescue Stripe::StripeError => e
      logger.error "Stripe Error: " + e.message
      errors.add :base, "#{e.message}."
      false
    end
  end

end
