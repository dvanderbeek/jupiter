class CreateActivitiesUser < ActiveRecord::Migration
  def change
    create_table :activities_user do |t|
      t.references :user
      t.references :activity

      t.timestamps
    end
    add_index :activities_user, :user_id
    add_index :activities_user, :activity_id
  end
end
