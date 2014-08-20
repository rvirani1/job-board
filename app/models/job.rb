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
  validates_presence_of :title, :description, :user_id

  def self.active
    now   = Time.now
    query = %{
      ( start_date IS NULL OR start_date < ? ) AND
      ( end_date   IS NULL OR end_date  >= ? )
    }.squish

    where [query, now, now]
  end

  # belongs_to :user
  # ^- would define job.user
  def author
    User.find self.user_id
  end
end
