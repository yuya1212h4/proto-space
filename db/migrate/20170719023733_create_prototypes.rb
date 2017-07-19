class CreatePrototypes < ActiveRecord::Migration[5.0]
  def change
    create_table :prototypes do |t|
      t.string :title, null: false
      t.string :catch_copy
      t.string :text
      t.references :user, foreign_key: true
      t.integer :likes_count, default: 0

      t.timestamps
    end
  end
end
