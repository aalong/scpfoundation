class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.references :versionable, polymorphic: true
      t.integer :user_id
      t.hstore :values
      t.string :commit_message

      t.timestamps
    end
  end
end
