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

require 'spec_helper'

describe Subscription do
  pending "add some examples to (or delete) #{__FILE__}"
end