class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :content, null: false
      t.references :user, foreign_key: true
      t.references :prototype, foreign_key: true

      t.timestamps
    end
  end
end
