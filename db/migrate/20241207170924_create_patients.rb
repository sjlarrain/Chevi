class CreatePatients < ActiveRecord::Migration[6.1]
  def change
    create_table :patients do |t|
      t.string :rut
      t.string :name
      t.string :mother_name
      t.string :phone_number
      t.string :email
      t.string :address

      t.timestamps
    end
  end
end
