class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.string :notification_type
      t.boolean :read, null: false, default: false
      t.string :target_type
      t.integer :target_place
      t.integer :target_id
      t.integer :originator_id
      t.string :description

      t.timestamps
    end
  end
end
