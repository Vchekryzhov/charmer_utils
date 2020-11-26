class CreateAdmin < ActiveRecord::Migration[5.1]
  def change
    create_table "admins", force: :cascade do |t|
      t.string "email", default: "", null: false
      t.string "password_digest"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.bigint "team_role_id"
      t.string "timezone"
      t.index ["team_role_id"], name: "index_admins_on_team_role_id"
    end
  end
end
