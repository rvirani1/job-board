class JobsController < ApplicationController
  # Provided by Devise
  # Redirects to login if not logged in already
  before_action :authenticate_user!, except: [:index, :show]
  # before_action :authenticate_user!, only: [:new, :create]

  before_action :check_job_author, only: [:edit, :update, :destroy]

  def index
    if params[:search]
       @jobs = Job.search_for_jobs(params[:search])
    elsif params[:status] == "read" && current_user
      @jobs = current_user.read_jobs
    elsif current_user
      @jobs = current_user.unread_jobs
    else
      @jobs = Job.all
    end
    @jobs = @jobs.includes(:company).paginate(page: params[:page], per_page: 5)
  end

  def show
    @job = Job.find params[:id]
    if (current_user) && (!current_user.has_read? @job)
      r = Read.new
      r.job_id = @job.id
      r.user_id = current_user.id
      r.save!
    end
  end

  def new
    unless current_user.company
      redirect_to new_company_path, notice: "You must join a company before posting a job"
    end
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
    @job.company = current_user.company
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

  ##TODO Create destroy action that destroys if user is part of the same company
  def destroy
    redirect_to root_path
  end

  def mark_unread
    r = current_user.reads.find_by_job_id params[:id]
    r.destroy!
    redirect_to jobs_path
  end

  private

  def create_params
    params.require(:job).permit(:title, :description,
                                :start_date, :end_date, :company)
  end

  def update_params
    # For now, reuse
    create_params
  end

end
