class FavoritesController < ApplicationController
  def create
    # Because of the routing / url I have
    #   params[:job_id]
    @job = Job.find params[:job_id]
    current_user.favorites.create! job: @job
    redirect_to :back, notice: "Favorite stored"
  end

  def destroy
    @job = Job.find params[:job_id]
    # This assumes there is exactly one matching
    #   favorite
    @favorite = current_user.favorites.where(job: @job).first
    @favorite.delete
    redirect_to :back, alert: "Favorite removed"
  end
end
