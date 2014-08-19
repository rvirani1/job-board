class JobsController < ApplicationController
  def show
    @job = Job.find params[:id]
  end

  def new
    @job = Job.new(
      start_date: Time.now,
      end_date:   Time.now + 1.week
    )
  end

  def create
    # This does not set user_id to correspond to current user
    #   @job = Job.new create_params
    # This sets user_id for the newly created job
    @job = current_user.jobs.new create_params
    if @job.save
      # Saved the record, now show it?
      # By redirecting to the show action
      redirect_to @job, notice: "Your listing was created"
    else
      # Validation errors, redisplay form
      render :new
    end
  end

  def create_params
    params.require(:job).permit(:title, :description,
                                :start_date, :end_date)
  end
end
