class CreateDistSessions < ActiveRecord::Migration
  def change
    create_table :dist_sessions do |t|
      t.string :session_id
      t.text :data

      t.timestamps null: false
    end
  end
end
