class ChangeDateFormatInJobs < ActiveRecord::Migration
def up
    change_column :jobs, :company_id, 'integer USING CAST(company_id AS integer)'
  end

  def down
    change_column :jobs, :company_id, :string
  end
end
