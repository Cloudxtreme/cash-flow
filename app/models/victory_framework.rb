# == Schema Information
#
# Table name: victory_frameworks
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  price      :integer
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class VictoryFramework < ActiveRecord::Base
  attr_accessible :name, :price, :title

  monetize :price_in_cents, :as => :price_monetized

  validates :price, :numericality => { :only_integer => true }
  validates :name, format: { with: /\A[a-z0-9]+\z/ }, :uniqueness => true

  def price_in_cents
    self.price
  end

end
