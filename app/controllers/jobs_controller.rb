class JobsController < ApplicationController
  # Provided by Devise
  # Redirects to login if not logged in already
  before_action :authenticate_user!, except: [:index, :show]
  # before_action :authenticate_user!, only: [:new, :create]

  def index
    if params[:search]
      @jobs = Job.search_for_jobs( params[:search])
    else
      @jobs = Job.all
    end
  end

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

  def edit
    # @job = Job.find params[:id]
    # raise "NOPE" if @job.user != current_user

    # only find jobs for current_user
    @job = current_user.jobs.find params[:id]
  end

  def update
    @job = current_user.jobs.find params[:id]
    # update sets all the attributes from this hash
    # and then calls save (so returns true iff the
    # object saved without validation errors)
    #   @job.title = params[:job][:title]
    #   @job.description = params[:job][:description]
    #   ...
    #   @job.save
    if @job.update update_params
      # Job was updated with new params
      redirect_to @job, notice: "Your notice was updated"
    else
      # Validation errors, redisplay
      render :edit
    end
  end

  def create_params
    params.require(:job).permit(:title, :description,
                                :start_date, :end_date)
  end

  def update_params
    # For now, reuse
    create_params
  end
end
