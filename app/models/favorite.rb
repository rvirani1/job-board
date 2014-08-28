# == Schema Information
#
# Table name: favorites
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  job_id     :integer
#  created_at :datetime
#  updated_at :datetime
#

class Favorite < ActiveRecord::Base
  validates_presence_of :user, :job
  validates_uniqueness_of :user, :scope => [:job]

  belongs_to :user # defines favorite.user
  belongs_to :job  # defines favorite.job
  # def job
  #   Job.find_by_id(self.job_id)
  # end
end
