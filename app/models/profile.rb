# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  username   :string(15)
#  first_name :string(255)
#  last_name  :string(255)
#  timezone   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Profile < ActiveRecord::Base
  validates :username, uniqueness: true, allow_nil: true
  belongs_to :user
end
