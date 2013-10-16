class CreateNamespaces < ActiveRecord::Migration
  def change
    create_table :namespaces do |t|
      t.string :name, null: false
      t.string :title, null: false, default: 'SCP Foundation'
      t.string :access, null: false, default: 'community'
      t.references :user

      t.timestamps
    end

    add_index :namespaces, :name, unique: true
  end
end
