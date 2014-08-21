class AddCompanyToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :company_id, :string
  end
end
