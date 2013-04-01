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

require 'spec_helper'

describe VictoryPurchase do
  pending "add some examples to (or delete) #{__FILE__}"
end
