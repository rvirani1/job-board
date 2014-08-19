# == Schema Information
#
# Table name: jobs
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  start_date  :date
#  end_date    :date
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require 'test_helper'

class JobTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
