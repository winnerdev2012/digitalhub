# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_07_19_172715) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "flipper_features", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_flipper_features_on_key", unique: true
  end

  create_table "flipper_gates", force: :cascade do |t|
    t.string "feature_key", null: false
    t.string "key", null: false
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feature_key", "key", "value"], name: "index_flipper_gates_on_feature_key_and_key_and_value", unique: true
  end

  create_table "refinery_announcement_translations", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.string "locale", null: false
    t.integer "refinery_announcement_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["locale"], name: "index_refinery_announcement_translations_on_locale"
    t.index ["refinery_announcement_id", "locale"], name: "index_1e4a4b96bfcc2c70b6dced31b103aba9ca46fd70", unique: true
  end

  create_table "refinery_announcements", force: :cascade do |t|
    t.integer "image_id"
    t.string "link"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "refinery_authentication_devise_roles", id: :serial, force: :cascade do |t|
    t.string "title"
  end

  create_table "refinery_authentication_devise_roles_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["role_id", "user_id"], name: "refinery_roles_users_role_id_user_id"
    t.index ["user_id", "role_id"], name: "refinery_roles_users_user_id_role_id"
  end

  create_table "refinery_authentication_devise_user_plugins", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.integer "position"
    t.index ["name"], name: "index_refinery_authentication_devise_user_plugins_on_name"
    t.index ["user_id", "name"], name: "refinery_user_plugins_user_id_name", unique: true
  end

  create_table "refinery_authentication_devise_users", id: :serial, force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "sign_in_count"
    t.datetime "remember_created_at"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug"
    t.string "full_name"
    t.index ["id"], name: "index_refinery_authentication_devise_users_on_id"
    t.index ["slug"], name: "index_refinery_authentication_devise_users_on_slug"
  end

  create_table "refinery_event_translations", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.text "accessibility_note"
    t.text "translation_note"
    t.string "locale", null: false
    t.integer "refinery_event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["locale"], name: "index_refinery_event_translations_on_locale"
    t.index ["refinery_event_id", "locale"], name: "index_ef835b16deb790211db3f38fe084065f37a4862b", unique: true
  end

  create_table "refinery_events", force: :cascade do |t|
    t.datetime "start"
    t.datetime "end"
    t.integer "image_id"
    t.string "event_type"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zipcode"
    t.string "registration_link"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "location_name"
    t.text "description"
  end

  create_table "refinery_hero_images", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "image_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "refinery_image_translations", id: :serial, force: :cascade do |t|
    t.string "image_alt"
    t.string "image_title"
    t.string "locale", null: false
    t.integer "refinery_image_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["locale"], name: "index_refinery_image_translations_on_locale"
    t.index ["refinery_image_id", "locale"], name: "index_2f245f0c60154d35c851e1df2ffc4c86571726f0", unique: true
  end

  create_table "refinery_images", id: :serial, force: :cascade do |t|
    t.string "image_mime_type"
    t.string "image_name"
    t.integer "image_size"
    t.integer "image_width"
    t.integer "image_height"
    t.string "image_uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "parent_id"
  end

  create_table "refinery_one_box_translations", force: :cascade do |t|
    t.string "title"
    t.string "locale", null: false
    t.integer "refinery_one_box_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["locale"], name: "index_refinery_one_box_translations_on_locale"
    t.index ["refinery_one_box_id", "locale"], name: "index_95394ba315aed2cb69dea96439990984a765aa44", unique: true
  end

  create_table "refinery_one_boxes", force: :cascade do |t|
    t.boolean "visible"
    t.boolean "triangle_overlay"
    t.integer "image_id"
    t.string "link"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "refinery_page_part_translations", id: :serial, force: :cascade do |t|
    t.text "body"
    t.string "locale", null: false
    t.integer "refinery_page_part_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["locale"], name: "index_refinery_page_part_translations_on_locale"
    t.index ["refinery_page_part_id", "locale"], name: "index_93b7363baf444ecab114aab0bbdedc79d0ec4f4b", unique: true
  end

  create_table "refinery_page_parts", id: :serial, force: :cascade do |t|
    t.integer "refinery_page_id"
    t.string "slug"
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "title"
    t.index ["id"], name: "index_refinery_page_parts_on_id"
    t.index ["refinery_page_id"], name: "index_refinery_page_parts_on_refinery_page_id"
  end

  create_table "refinery_page_translations", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "custom_slug"
    t.string "menu_title"
    t.string "slug"
    t.string "locale", null: false
    t.integer "refinery_page_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["locale"], name: "index_refinery_page_translations_on_locale"
    t.index ["refinery_page_id", "locale"], name: "index_refinery_page_t10s_on_refinery_page_id_and_locale", unique: true
  end

  create_table "refinery_pages", id: :serial, force: :cascade do |t|
    t.integer "parent_id"
    t.string "path"
    t.boolean "show_in_menu", default: true
    t.string "link_url"
    t.string "menu_match"
    t.boolean "deletable", default: true
    t.boolean "draft", default: false
    t.boolean "skip_to_first_child", default: false
    t.integer "lft"
    t.integer "rgt"
    t.integer "depth"
    t.string "view_template"
    t.string "layout_template"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "children_count", default: 0, null: false
    t.index ["depth"], name: "index_refinery_pages_on_depth"
    t.index ["id"], name: "index_refinery_pages_on_id"
    t.index ["lft"], name: "index_refinery_pages_on_lft"
    t.index ["parent_id"], name: "index_refinery_pages_on_parent_id"
    t.index ["rgt"], name: "index_refinery_pages_on_rgt"
  end

  create_table "refinery_reports", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "date"
    t.integer "image_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "refinery_resource_translations", id: :serial, force: :cascade do |t|
    t.string "resource_title"
    t.string "locale", null: false
    t.integer "refinery_resource_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["locale"], name: "index_refinery_resource_translations_on_locale"
    t.index ["refinery_resource_id", "locale"], name: "index_35a57b749803d8437ea64c64da3fb2cb0fbf457a", unique: true
  end

  create_table "refinery_resources", id: :serial, force: :cascade do |t|
    t.string "file_mime_type"
    t.string "file_name"
    t.integer "file_size"
    t.string "file_uid"
    t.string "file_ext"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "refinery_stories", force: :cascade do |t|
    t.string "submitter_name"
    t.integer "question"
    t.boolean "display"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
  end

  create_table "refinery_story_translations", force: :cascade do |t|
    t.text "response"
    t.string "locale", null: false
    t.integer "refinery_story_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["locale"], name: "index_refinery_story_translations_on_locale"
    t.index ["refinery_story_id", "locale"], name: "index_845caebe798a0afcd0ff8f6d31a500cb83b87df7", unique: true
  end

  create_table "refinery_taggings", force: :cascade do |t|
    t.integer "tag_id"
    t.integer "event_id"
    t.integer "announcement_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "report_id"
  end

  create_table "refinery_tags", force: :cascade do |t|
    t.string "title"
    t.string "tag_type"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "narrative"
  end

  create_table "refinery_weigh_in_prompts", force: :cascade do |t|
    t.string "title"
    t.integer "image_id"
    t.text "body"
    t.integer "style"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "seo_meta", id: :serial, force: :cascade do |t|
    t.integer "seo_meta_id"
    t.string "seo_meta_type"
    t.string "browser_title"
    t.text "meta_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_seo_meta_on_id"
    t.index ["seo_meta_id", "seo_meta_type"], name: "id_type_index_on_seo_meta"
  end

end
