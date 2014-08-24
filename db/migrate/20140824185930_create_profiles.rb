class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id, null: false
      t.string :username, limit: 15
      t.string :first_name
      t.string :last_name
      t.string :timezone

      t.timestamps
    end
  end
end
