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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120821122430) do

  create_table "accounts", :force => true do |t|
    t.integer  "supplier_id"
    t.datetime "expires_at"
    t.integer  "listing_limit"
    t.string   "account_type"
    t.float    "account_price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts", ["supplier_id"], :name => "index_accounts_on_supplier_id"

  create_table "alerts", :force => true do |t|
    t.integer  "user_id"
    t.string   "alert_title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "supplier_id"
  end

  create_table "categories", :force => true do |t|
    t.string   "category_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", :force => true do |t|
    t.string   "message"
    t.integer  "user_id"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subject"
  end

  add_index "contacts", ["user_id"], :name => "index_contacts_on_user_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "listing_categories", :id => false, :force => true do |t|
    t.integer  "listing_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "listing_categories", ["category_id"], :name => "index_listing_categories_on_category_id"
  add_index "listing_categories", ["listing_id"], :name => "index_listing_categories_on_listing_id"

  create_table "listings", :force => true do |t|
    t.integer  "supplier_id"
    t.string   "title"
    t.string   "description"
    t.float    "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.string   "listing_image_file_name"
    t.string   "listing_image_content_type"
    t.integer  "listing_image_file_size"
    t.datetime "listing_image_updated_at"
  end

  add_index "listings", ["supplier_id"], :name => "index_listings_on_supplier_id"

  create_table "profile_photos", :force => true do |t|
    t.integer  "user_id"
    t.integer  "supplier_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "profile_image_file_name"
    t.string   "profile_image_content_type"
    t.integer  "profile_image_file_size"
    t.datetime "profile_image_updated_at"
  end

  add_index "profile_photos", ["supplier_id"], :name => "index_profile_photos_on_supplier_id"
  add_index "profile_photos", ["user_id"], :name => "index_profile_photos_on_user_id"

  create_table "recommendations", :force => true do |t|
    t.integer  "user_id"
    t.string   "email"
    t.integer  "recommended_to_id"
    t.integer  "recommended_listing_id"
    t.string   "recommendation_token"
    t.integer  "recommendation_limit"
    t.datetime "recommendation_limit_ends_at"
    t.datetime "recommendation_accepted_at"
    t.datetime "recommendation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recommendations", ["recommended_listing_id"], :name => "index_recommendations_on_recommended_listing_id"
  add_index "recommendations", ["user_id"], :name => "index_recommendations_on_user_id"

  create_table "recommenders", :force => true do |t|
    t.integer  "user_alert_id"
    t.integer  "recommended_to_supplier_id"
    t.integer  "recommended_by_user_id"
    t.string   "recommended_by_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "blocked",                    :default => false
  end

  add_index "recommenders", ["recommended_to_supplier_id"], :name => "index_recommenders_on_recommended_to_supplier_id"
  add_index "recommenders", ["user_alert_id"], :name => "index_recommenders_on_user_alert_id"

  create_table "suppliers", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "country"
    t.string   "city"
    t.string   "phone_number"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                                      :default => "", :null => false
    t.string   "encrypted_password",          :limit => 128, :default => ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                              :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "invitation_token",            :limit => 60
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.string   "supplier_image_file_name"
    t.string   "supplier_image_content_type"
    t.integer  "supplier_image_file_size"
    t.datetime "supplier_image_updated_at"
  end

  add_index "suppliers", ["email"], :name => "index_suppliers_on_email", :unique => true
  add_index "suppliers", ["invitation_token"], :name => "index_suppliers_on_invitation_token"
  add_index "suppliers", ["invited_by_id"], :name => "index_suppliers_on_invited_by_id"
  add_index "suppliers", ["reset_password_token"], :name => "index_suppliers_on_reset_password_token", :unique => true
  add_index "suppliers", ["user_id"], :name => "index_suppliers_on_user_id"

  create_table "tellers", :force => true do |t|
    t.integer  "user_alert_id"
    t.integer  "supplier_id"
    t.integer  "no_of_recommendations"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tellers", ["user_alert_id"], :name => "index_tellers_on_user_alert_id"

  create_table "user_alerts", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.string   "target_location"
    t.string   "status"
    t.datetime "expires_at"
    t.string   "prefered_category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_alerts", ["user_id"], :name => "index_user_alerts_on_user_id"

  create_table "user_contacts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "contact_id"
    t.integer  "contact_alert_id"
    t.string   "reply_to_id"
    t.string   "contact_about_alert"
    t.text     "contact_message"
    t.datetime "contact_created_at"
    t.datetime "contact_message_sent_at"
    t.datetime "contact_message_viewed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "contact_accepted_at"
    t.boolean  "accepted",                   :default => false
    t.datetime "contact_message_expires_at"
  end

  add_index "user_contacts", ["user_id"], :name => "index_user_contacts_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                                  :default => "",    :null => false
    t.string   "encrypted_password",      :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "location"
    t.boolean  "admin",                                  :default => false
    t.boolean  "recommended_user",                       :default => false
    t.string   "user_image_file_name"
    t.string   "user_image_content_type"
    t.integer  "user_image_file_size"
    t.datetime "user_image_updated_at"
    t.string   "country"
    t.string   "city"
    t.string   "address"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
