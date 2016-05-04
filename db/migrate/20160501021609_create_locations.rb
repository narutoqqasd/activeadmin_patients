class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :code, default: ""
      t.string :name, default: ""
      t.timestamps null: false
    end
  end
end
