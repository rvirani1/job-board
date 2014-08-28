# == Schema Information
#
# Table name: reads
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  job_id     :integer
#  created_at :datetime
#  updated_at :datetime
#

class Read < ActiveRecord::Base
  validates_presence_of :user, :job

  belongs_to :user # defines favorite.user
  belongs_to :job  # defines favorite.job
end
