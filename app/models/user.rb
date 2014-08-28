# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  company_id             :integer
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile

  # This defines user.jobs to be the relation of all of this
  #   user's jobs
  has_many :jobs

  # Defines user.favorites
  has_many :favorites
  has_many :favorited_jobs, through: :favorites,
    source: :job
  # ^- we want this to describe jobs that the user
  #   has favorited, but there is a name collision
  belongs_to :company

  has_many :reads
  has_many :read_jobs, through: :reads, source: :job

  def unread_jobs
    Job.all.where.not(:id => self.read_jobs)
  end

  def has_favorited?(job)
    # favorited_jobs.to_a.any? { |fav| fav.job == job }
    favorites.where(job: job).exists?
  end

  def self.no_company
    User.where(company: nil)
  end

  def unread_jobs
    Job.all.where.not(:id => self.read_jobs)
  end

  def has_read?(job)
    reads.where(job: job).exists?
  end
end
