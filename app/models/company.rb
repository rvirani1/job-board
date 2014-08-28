# == Schema Information
#
# Table name: companies
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  employee    :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Company < ActiveRecord::Base
  validates_uniqueness_of :name
  has_many :users
  has_many :jobs
  include PgSearch
  multisearchable :against => [:name, :description]

  def update_users selected_users
    self.users = selected_users.map { |useremail| User.find_by_email(useremail)}
  end
end
