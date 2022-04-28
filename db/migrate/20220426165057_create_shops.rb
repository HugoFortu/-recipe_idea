class CreateShops < ActiveRecord::Migration[7.0]
  def change
    create_table :shops do |t|
      t.string :name
      t.string :address
      t.float :long
      t.float :lat

      t.timestamps
    end
  end
end
