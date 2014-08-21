class Read < ActiveRecord::Base
  validates_presence_of :user, :job

  belongs_to :user # defines favorite.user
  belongs_to :job  # defines favorite.job
end
