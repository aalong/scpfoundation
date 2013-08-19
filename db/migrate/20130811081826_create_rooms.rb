class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :title
      t.string :description
      t.string :topic
      t.string :access
      t.references :user

      t.timestamps
    end
  end
end
