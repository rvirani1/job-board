class ProfilesController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def show
    @profile = Profile.find params[:id]
  end

  def edit
    @profile = Profile.find params[:id]#current_user.profile
  end

  def update
    @profile = Profile.find params[:id]#current_user.profile
    if @profile.update update_params
      redirect_to @profile, notice: "Your profile was updated"
    else
      render :edit
    end
  end

  private

  def create_params
    params.require(:profile).permit(:username, :first_name,
                                :last_name, :timezone)
  end

  def update_params
    # For now, reuse
    create_params
  end



end
