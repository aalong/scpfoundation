class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.string :name, null: false
      t.string :slug, null: false
      t.string :commit_message, default: '', null: false
      t.string :access
      t.integer :namespace_id, null: false
      t.integer :user_id, null: false
      t.integer :editor_id

      t.timestamps
    end

    add_index :pages, :slug, unique: true
  end
end
