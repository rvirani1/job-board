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

class Job < ActiveRecord::Base
  validates_presence_of :title, :description
end
