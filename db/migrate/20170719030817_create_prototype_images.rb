class CreatePrototypeImages < ActiveRecord::Migration[5.0]
  def change
    create_table :prototype_images do |t|
      t.string :image, null: false
      t.integer :image_type, null: false
      t.references :prototype, foreign_key: true

      t.timestamps
    end
  end
end
