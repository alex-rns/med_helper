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

ActiveRecord::Schema.define(version: 2021_02_22_203646) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "events", force: :cascade do |t|
    t.integer "user_id"
    t.integer "expert_id"
    t.string "name"
    t.integer "phone"
    t.string "email"
    t.datetime "time"
    t.string "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "experts", force: :cascade do |t|
    t.string "full_name"
    t.text "description"
    t.integer "experience"
    t.text "additional_education"
    t.text "procedure"
    t.string "address"
    t.string "medical_center"
    t.string "email"
    t.string "phone"
    t.string "image"
    t.string "hw_start_monday"
    t.string "hw_end_monday"
    t.string "hw_start_tuesday"
    t.string "hw_end_tuesday"
    t.string "hw_start_wednesday"
    t.string "hw_end_wednesday"
    t.string "hw_start_thursday"
    t.string "hw_end_thursday"
    t.string "hw_start_friday"
    t.string "hw_end_friday"
    t.string "hw_start_saturday"
    t.string "hw_end_saturday"
    t.string "hw_start_sunday"
    t.string "hw_end_sunday"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "category_id"
    t.text "education"
    t.integer "level_id"
  end

  create_table "levels", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "level_status"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "address"
    t.integer "phone"
    t.datetime "birthday"
    t.string "access_token"
    t.datetime "expires_at"
    t.string "refresh_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vaccines", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "hepatitis_a_1w"
    t.datetime "hepatitis_a_2w"
    t.datetime "hepatitis_b_1w"
    t.datetime "hepatitis_b_2w"
    t.datetime "hepatitis_b_3w"
    t.datetime "tuberculosis"
    t.datetime "pneumococcus_1w"
    t.datetime "pneumococcus_2w"
    t.datetime "pneumococcus_3w"
    t.datetime "meningococcus_1w"
    t.datetime "meningococcus_2w"
    t.datetime "varicella_1w"
    t.datetime "varicella_2w"
    t.datetime "morbilli_mumps_rubella_1w"
    t.datetime "morbilli_mumps_rubella_2w"
    t.datetime "diphtheria_tetanus_pertussis_1w"
    t.datetime "diphtheria_tetanus_pertussis_2w"
    t.datetime "diphtheria_tetanus_pertussis_3w"
    t.datetime "diphtheria_tetanus_pertussis_1rw"
    t.datetime "diphtheria_tetanus_pertussis_2rw"
    t.datetime "diphtheria_tetanus_pertussis_3rw"
    t.datetime "hib_desease_1w"
    t.datetime "hib_desease_2w"
    t.datetime "hib_desease_3w"
    t.datetime "hib_desease_4w"
    t.datetime "rota_1w"
    t.datetime "rota_2w"
    t.datetime "covid19_1w"
    t.datetime "covid19_2w"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
