class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :first_name, default: ""
      t.string :middle_name, default: ""
      t.string :last_name, default: ""
      t.date :birthday
      t.string :gender, default: ""
      t.string :status, default: ""
      t.integer :location_id
      t.integer :viewed_count, default: 0
      t.boolean :is_deleted, default: false, null: false
      t.timestamps null: false
    end
  end
end
