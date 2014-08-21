class Company < ActiveRecord::Base
  validates_uniqueness_of :name

  has_many :users
  has_many :jobs

  def update_users selected_users
    self.users = selected_users.map { |useremail| User.find_by_email(useremail)}
  end
end
