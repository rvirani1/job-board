module CompaniesHelper
  def users_select_list(company)
    no_company_users = User.no_company.map { |user| user.email }
    company_users = company.users.map { |user| user.email }
    options_for_select(no_company_users + company_users, company_users + [current_user.email])
  end
end

#New want to show all users that are not in a company
#Edit want to show all users that are not in a company + users in this company, highlight users in current company