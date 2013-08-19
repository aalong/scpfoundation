class CreateSharings < ActiveRecord::Migration
  def change
    create_table :sharings do |t|
      t.references :shareable, polymorphic: true
      t.references :user
    end

    add_index :sharings, [:shareable_id, :user_id]
  end
end
