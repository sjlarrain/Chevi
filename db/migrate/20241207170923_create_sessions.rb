class CreateSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :sessions do |t|
      t.references :professional, null: false, foreign_key: true
      t.references :patient, null: false, foreign_key: true
      t.date :date
      t.decimal :amount
      t.boolean :payment

      t.timestamps
    end
  end
end
