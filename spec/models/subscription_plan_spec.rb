# == Schema Information
#
# Table name: plans
#
#  id         :integer          not null, primary key
#  stripe_id  :string(255)
#  amount     :integer
#  interval   :string(255)
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe SubscriptionPlan do
  pending "add some examples to (or delete) #{__FILE__}"
end
