# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20130724142946) do

  create_table "ads", :force => true do |t|
    t.integer  "advertiser_id"
    t.string   "name"
    t.datetime "start"
    t.datetime "end"
    t.string   "size"
    t.string   "destination"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_uploaded_at"
    t.text     "notes"
    t.string   "locations"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "on_homepage"
    t.string   "page_wrap_file_name"
    t.string   "page_wrap_file_size"
    t.integer  "page_wrap_content_type"
    t.datetime "page_wrap_updated_at"
    t.string   "background_color"
    t.boolean  "on_global_homepage",     :default => false
  end

  add_index "ads", ["advertiser_id"], :name => "index_ads_on_advertiser_id"

  create_table "ads_categories", :id => false, :force => true do |t|
    t.integer "ad_id",       :null => false
    t.integer "category_id", :null => false
  end

  add_index "ads_categories", ["ad_id", "category_id"], :name => "index_ads_categories_on_ad_id_and_category_id", :unique => true

  create_table "ads_cities", :id => false, :force => true do |t|
    t.integer "ad_id"
    t.integer "city_id"
  end

  create_table "advertisers", :force => true do |t|
    t.string   "name"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "website"
    t.string   "contact_name"
    t.string   "contact_phone"
    t.string   "contact_email"
    t.string   "budget_amount"
    t.string   "period"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attachments", :force => true do |t|
    t.integer  "venue_id"
    t.string   "attachment_file_name"
    t.string   "attachment_file_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "calendar_events", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.integer  "users_on_calendar_id"
    t.integer  "events_on_calendar_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "has_reminder"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "slug"
  end

  add_index "categories", ["slug"], :name => "index_categories_on_slug", :unique => true

  create_table "categories_events", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "event_id"
  end

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.float    "longitude"
    t.float    "latitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "zip"
    t.string   "state"
    t.boolean  "approved"
    t.string   "slug"
  end

  add_index "cities", ["slug"], :name => "index_cities_on_slug", :unique => true

  create_table "city101s", :force => true do |t|
    t.text     "description"
    t.text     "links"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "city_id"
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

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

  create_table "events", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "start_time"
    t.datetime "end_time"
    t.boolean  "all_day"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "price"
    t.string   "website"
    t.string   "event_host"
    t.string   "event_contact"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "venue_id"
    t.boolean  "approved"
    t.string   "buy_tickets"
    t.integer  "city_id"
    t.string   "slug"
  end

  add_index "events", ["slug"], :name => "index_events_on_slug", :unique => true
  add_index "events", ["user_id"], :name => "index_events_on_user_id"

  create_table "events_labels", :id => false, :force => true do |t|
    t.integer "label_id"
    t.integer "event_id"
  end

  create_table "frontpage_sliders", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "url"
    t.integer  "weight",             :default => 0
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "city_id"
  end

  create_table "labels", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "pages", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "content"
    t.string   "meta_keywords"
    t.string   "meta_description"
    t.string   "url"
    t.string   "slug"
  end

  add_index "pages", ["slug"], :name => "index_pages_on_slug", :unique => true

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "city_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "venue_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
  end

  create_table "venue_categories_venues", :id => false, :force => true do |t|
    t.integer "venue_id",          :null => false
    t.integer "venue_category_id", :null => false
  end

  add_index "venue_categories_venues", ["venue_id", "venue_category_id"], :name => "index_venue_categories_venues_on_venue_id_and_venue_category_id", :unique => true

  create_table "venues", :force => true do |t|
    t.string   "name"
    t.string   "street_address"
    t.string   "city_name"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "website"
    t.string   "phone_alt"
    t.text     "description"
    t.string   "holidays"
    t.string   "monday"
    t.string   "tuesday"
    t.string   "wednesday"
    t.string   "thursday"
    t.string   "friday"
    t.string   "saturday"
    t.string   "sundays"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "staff_name"
    t.string   "staff_phone"
    t.string   "staff_email"
    t.string   "staff_address"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_venue"
    t.integer  "user_id"
    t.string   "yelp"
    t.string   "foursquare"
    t.text     "hours_override"
    t.integer  "city_id"
    t.string   "slug"
  end

  add_index "venues", ["slug"], :name => "index_venues_on_slug", :unique => true

  create_table "wifi_hotspots", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "longitude"
    t.string   "latitude"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wifi_hotspots", ["city_id"], :name => "index_wifi_hotspots_on_city_id"

end
