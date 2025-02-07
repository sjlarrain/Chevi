# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2024_12_10_003606) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "patients", force: :cascade do |t|
    t.string "rut"
    t.string "name"
    t.string "mother_name"
    t.string "phone_number"
    t.string "email"
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "active", default: true
  end

  create_table "patients_professionals", id: false, force: :cascade do |t|
    t.integer "patient_id", null: false
    t.integer "professional_id", null: false
    t.index ["patient_id"], name: "index_patients_professionals_on_patient_id"
    t.index ["professional_id"], name: "index_patients_professionals_on_professional_id"
  end

  create_table "professionals", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_professionals_on_email", unique: true
    t.index ["reset_password_token"], name: "index_professionals_on_reset_password_token", unique: true
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "professional_id", null: false
    t.integer "patient_id", null: false
    t.date "date"
    t.decimal "amount"
    t.boolean "payment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["patient_id"], name: "index_sessions_on_patient_id"
    t.index ["professional_id"], name: "index_sessions_on_professional_id"
  end

  add_foreign_key "sessions", "patients"
  add_foreign_key "sessions", "professionals"
end
