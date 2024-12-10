class CreatePatientsProfessionalsJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :patients, :professionals do |t|
      t.index :patient_id
      t.index :professional_id
    end
  end
end
