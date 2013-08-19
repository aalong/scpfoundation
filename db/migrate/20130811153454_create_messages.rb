class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :content
      t.string :message_type
      t.integer :user_id
      t.integer :room_id

      t.timestamps
    end
  end
end
