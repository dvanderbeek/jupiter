class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.references :user
      t.string :calendar_id

      t.timestamps
    end
    add_index :calendars, :user_id
  end
end
