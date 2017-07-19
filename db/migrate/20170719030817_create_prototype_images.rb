class CreatePrototypeImages < ActiveRecord::Migration[5.0]
  def change
    create_table :prototype_images do |t|

      t.timestamps
    end
  end
end
