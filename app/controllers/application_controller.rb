class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def home
    if current_user && !current_user.profile
      new_profile = Profile.new
      new_profile.user_id = current_user.id
      new_profile.save!
      redirect_to edit_profile_path new_profile 
    else  
      redirect_to jobs_path
    end
  end
end
