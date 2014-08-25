class Profile < ActiveRecord::Base
  validates :username, uniqueness: true, allow_nil: true
  belongs_to :user
end
