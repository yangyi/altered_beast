# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090417080755) do

  create_table "boards", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "description_html"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "site_id"
    t.integer  "position",         :default => 0
  end

  create_table "card_generators", :force => true do |t|
    t.integer "province_id"
    t.string  "card_type"
    t.integer "count"
  end

  create_table "cards", :force => true do |t|
    t.string   "number"
    t.string   "password"
    t.string   "card_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "query_points", :default => 0, :null => false
    t.integer  "province_id"
    t.integer  "order_id"
  end

  add_index "cards", ["number"], :name => "index_cards_on_number", :unique => true
  add_index "cards", ["province_id", "created_at"], :name => "index_cards_on_province_id_and_created_at"
  add_index "cards", ["user_id", "number", "password"], :name => "index_cards_on_user_id_and_number_and_password"

  create_table "college_priorities", :force => true do |t|
    t.integer  "college_id"
    t.integer  "province_id"
    t.integer  "recruit_priority_id"
    t.integer  "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "college_priorities", ["college_id", "province_id", "category"], :name => "duplex_unique", :unique => true

  create_table "college_scores", :force => true do |t|
    t.integer  "province_id"
    t.integer  "college_id"
    t.integer  "year"
    t.integer  "category"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "college_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "colleges", :force => true do |t|
    t.string   "name"
    t.integer  "province_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
    t.integer  "college_type_id"
    t.string   "pinyin"
  end

  add_index "colleges", ["province_id", "pinyin"], :name => "index_colleges_on_province_id_and_pinyin"

  create_table "favorites", :force => true do |t|
    t.integer  "user_id"
    t.integer  "favoritable_id"
    t.string   "favoritable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorites", ["user_id", "created_at"], :name => "index_favorites_on_user_id_and_created_at"

  create_table "forums", :force => true do |t|
    t.integer "site_id"
    t.string  "name"
    t.string  "description"
    t.integer "topics_count",     :default => 0
    t.integer "posts_count",      :default => 0
    t.integer "position",         :default => 0
    t.text    "description_html"
    t.string  "state",            :default => "public"
    t.string  "permalink"
    t.integer "board_id"
  end

  add_index "forums", ["position", "site_id"], :name => "index_forums_on_position_and_site_id"
  add_index "forums", ["site_id", "permalink"], :name => "index_forums_on_site_id_and_permalink"

  create_table "majors", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pinyin"
  end

  add_index "majors", ["pinyin"], :name => "index_majors_on_pinyin"

  create_table "moderatorships", :force => true do |t|
    t.integer  "forum_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "monitorships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",     :default => true
  end

  create_table "orders", :force => true do |t|
    t.string   "card_type"
    t.string   "buyer_email"
    t.string   "buyer_phone"
    t.decimal  "amount",      :precision => 10, :scale => 2
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["state", "created_at"], :name => "index_orders_on_state_and_created_at"

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "filter"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "possibility_queries", :force => true do |t|
    t.integer  "user_id"
    t.integer  "college_id"
    t.integer  "recruit_priority_id"
    t.integer  "possibility"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "possibility_queries", ["user_id", "created_at"], :name => "index_possibility_queries_on_user_id_and_created_at"

  create_table "posts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "forum_id"
    t.text     "body_html"
    t.integer  "site_id"
  end

  add_index "posts", ["created_at", "forum_id"], :name => "index_posts_on_forum_id"
  add_index "posts", ["created_at", "topic_id"], :name => "index_posts_on_topic_id"
  add_index "posts", ["created_at", "user_id"], :name => "index_posts_on_user_id"

  create_table "province_scores", :force => true do |t|
    t.integer  "province_id"
    t.integer  "year"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "min"
    t.integer  "category"
  end

  create_table "provinces", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "card_serial_no", :default => 0,     :null => false
    t.string   "pinyin"
    t.boolean  "universal",      :default => false, :null => false
    t.boolean  "has_agent",      :default => false, :null => false
    t.boolean  "score_known",    :default => true,  :null => false
  end

  add_index "provinces", ["pinyin"], :name => "index_provinces_on_pinyin"

  create_table "recruit_priorities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "recruitments", :force => true do |t|
    t.integer "college_id"
    t.integer "recruit_priority_id"
    t.integer "major_id"
    t.integer "province_id"
    t.integer "students_quota"
    t.integer "score"
    t.integer "year"
    t.integer "college_province_id"
    t.integer "college_type_id"
    t.integer "category"
    t.integer "max"
    t.integer "min"
    t.integer "avg"
    t.integer "recruitment_number"
  end

  add_index "recruitments", ["avg", "province_id", "year", "category"], :name => "index_recruitments_on_avg_and_province_id_and_year_and_category"
  add_index "recruitments", ["avg"], :name => "index_recruitments_on_avg"
  add_index "recruitments", ["college_id", "recruit_priority_id", "major_id", "province_id", "year", "category"], :name => "unique_duplex", :unique => true
  add_index "recruitments", ["college_id", "year"], :name => "index_recruitments_on_college_id_and_year"
  add_index "recruitments", ["year", "major_id", "province_id", "college_province_id", "college_type_id"], :name => "index_recruitments"
  add_index "recruitments", ["year"], :name => "index_recruitments_on_year"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "sites", :force => true do |t|
    t.string   "name"
    t.string   "host"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "topics_count", :default => 0
    t.integer  "users_count",  :default => 0
    t.integer  "posts_count",  :default => 0
    t.text     "description"
    t.text     "tagline"
  end

  create_table "topics", :force => true do |t|
    t.integer  "forum_id"
    t.integer  "user_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hits",            :default => 0
    t.integer  "sticky",          :default => 0
    t.integer  "posts_count",     :default => 0
    t.boolean  "locked",          :default => false
    t.integer  "last_post_id"
    t.datetime "last_updated_at"
    t.integer  "last_user_id"
    t.integer  "site_id"
    t.string   "permalink"
  end

  add_index "topics", ["forum_id", "permalink"], :name => "index_topics_on_forum_id_and_permalink"
  add_index "topics", ["last_updated_at", "forum_id"], :name => "index_topics_on_forum_id_and_last_updated_at"
  add_index "topics", ["sticky", "last_updated_at", "forum_id"], :name => "index_topics_on_sticky_and_last_updated_at"

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "state",                                    :default => "passive"
    t.datetime "deleted_at"
    t.string   "gender"
    t.integer  "province_id"
    t.string   "student_type"
    t.string   "mobile_phone"
    t.string   "address"
    t.string   "school"
    t.string   "identity"
    t.string   "passcard"
    t.text     "roles"
    t.integer  "query_points",                             :default => 0,         :null => false
    t.integer  "score"
    t.integer  "addition_score"
    t.integer  "total_score",                              :default => 0,         :null => false
    t.text     "wish_table"
    t.integer  "score_updated_count",                      :default => 0,         :null => false
    t.boolean  "admin",                                    :default => false
    t.integer  "site_id"
    t.datetime "last_login_at"
    t.text     "bio_html"
    t.string   "openid_url"
    t.datetime "last_seen_at"
    t.string   "website"
    t.integer  "posts_count",                              :default => 0
    t.string   "bio"
    t.string   "permalink"
    t.string   "display_name"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["identity"], :name => "index_users_on_identity", :unique => true
  add_index "users", ["last_seen_at"], :name => "index_users_on_last_seen_at"
  add_index "users", ["login"], :name => "index_users_on_login", :unique => true
  add_index "users", ["site_id", "permalink"], :name => "index_site_users_on_permalink"
  add_index "users", ["site_id", "posts_count"], :name => "index_site_users_on_posts_count"

  create_table "wishes", :force => true do |t|
    t.integer  "recruitment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "college_position"
    t.integer  "major_position"
  end

  add_index "wishes", ["user_id", "created_at"], :name => "index_wishes_on_user_id_and_created_at"

end
