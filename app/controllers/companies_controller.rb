class CompaniesController < ApplicationController
  before_action :check_user_authorization, :except => [:index, :new]
  before_action :set_companies

  def index
    #TODO Build page to show all companies
    #TODO make sure that navigation has a way to get here
  end

  def show
    @company = Company.find(params[:id])
    @jobs = @company.jobs
  end


  def new
    #TODO should be able to get to here from the user profile page if they don't have a company
    @company = Company.new
  end

  def create
    unless params[:selectedusers].include? current_user.email
      redirect_to 'new', alert: "You must be a part of any company you create"
    end

    company = Company.new company_params

    if company.save
      current_user.company = company
      current_user.save!
      redirect_to company_path(company), :notice => "Company Created!"
    else
      redirect_to companies_path, :alert => "Unable to Create Company!"
    end
  end

  def edit
    @company = Company.find params[:id]
  end

  def update


    #TODO make a way to update a company's data
    company = Company.find params[:id]
    unless params[:selectedusers]
      redirect_to edit_company_path(company), alert: "Company must have at least one user"
    end
    company.name = params[:name]
    company.description = params[:description]
    company.update_users params[:selectedusers]

    if company.save
      redirect_to company_path(company), notice: "Company was updated!"
    else
      redirect_to edit_company_path(company), alert: "Company was not updated!"
    end
  end

  def destroy
    #TODO make a way to get rid of a company
  end

  private

  def company_params
    params.permit(:name, :description)
  end

  def check_user_authorization
    #TODO check if user is part of company
  end

  def set_companies
    @companies = Company.all
  end
end
