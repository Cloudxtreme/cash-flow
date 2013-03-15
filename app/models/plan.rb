# == Schema Information
#
# Table name: plans
#
#  id                :integer          not null, primary key
#  stripe_id         :string(255)
#  amount            :integer
#  interval          :string(255)
#  name              :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  trial_period_days :integer          default(0)
#

class Plan < ActiveRecord::Base

  has_many :subscriptions, :dependent => :destroy
  
  attr_accessible :amount, :interval, :name, :stripe_id, :trial_period_days

  validates :name, :presence => true
  validates :amount, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }

  monetize :amount, :as => :amount_in_dollars

  def save_with_stripe
    begin
      self.save
      Stripe::Plan.create :id => self.id, :amount => self.amount, :trial_period_days => self.trial_period_days, :interval => 'month', :name => self.name, :currency => 'usd'
    rescue Stripe::StripeError => e
      self.destroy
      logger.error "Stripe Error: " + e.message
      errors.add :base, "#{e.message}."
      false
    end
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
      sp = Stripe::Plan.retrieve(self.id.to_s)
      sp.delete
      self.destroy
    rescue Stripe::StripeError => e
      logger.error "Stripe Error: " + e.message
      errors.add :base, "#{e.message}."
      false
    end
  end

end
