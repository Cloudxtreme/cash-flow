# == Schema Information
#
# Table name: victory_purchases
#
#  id               :integer          not null, primary key
#  stripe_charge_id :string(255)
#  last_4           :integer
#  license_key      :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  token            :string(255)
#  first_name       :string(255)
#  last_name        :string(255)
#  email            :string(255)
#  stripe_token     :string(255)
#

class VictoryPurchase < ActiveRecord::Base
  attr_accessible :last_4, :license_key, :stripe_charge_id, :stripe_token, :email, :first_name, :last_name

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true
  validates :stripe_token, :presence => true

  monetize :price_in_cents, :as => :price_in_dollars

  def price_in_cents
    return VICTORY_PRICE
  end

  def complete

    # Create the charge on Stripe's servers - this will charge the user's card
    begin
      charge = Stripe::Charge.create(
        :amount => VICTORY_PRICE, # amount in cents, again
        :currency => "usd",
        :card => self.stripe_token,
        :description => "Victory payment from #{self.first_name} #{self.last_name}, #{self.email}"
      )

      logger.debug '=== Charge'
      logger.debug charge.inspect

      self.last_4 = charge[:card][:last4]
      self.generate_license_key
      self.generate_token

      if self.save
        self.register_victory_license_key
        UserMailer.notify_victory_customer(self).deliver
        UserMailer.notify_admin_of_victory_signup(self).deliver
        return true
      else
        # didn't save right
        return false
      end

    rescue Stripe::CardError => e
      # The card has been declined
      logger.debug '============'
      logger.debug 'Victory Purchase Errors'
      logger.debug e.inspect
      return false
    end
  end

  def register_victory_license_key
    require 'net/http'
    result = Net::HTTP.get(URI.parse("http://validate.victoryframework.com/activation/registration.php?activation_code=#{self.license_key}&api_key=ams0d0amd90smads"))
  end

  def generate_license_key
    # generate a license key like so: JOHN-SMITH-39LT-XMS2-0PHO-7V6R  
    license_key_string = Array.new
    license_key_string.push self.first_name.upcase
    license_key_string.push self.last_name.upcase

    4.times do
      charset = %w{ 2 3 4 6 7 9 A C D E F G H J K M N P Q R T V W X Y Z}
      license_key_string.push (0...4).map{ charset.to_a[rand(charset.size)] }.join
    end

    self.license_key = license_key_string.join('-')
  end

  def generate_token
    require 'securerandom'
    self.token = SecureRandom.hex(13)
  end
end
