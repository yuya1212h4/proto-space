class AddColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :member, :text
    add_column :users, :profile, :text
    add_column :users, :works, :text
    add_column :users, :user_image, :string
  end
end
