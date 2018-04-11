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

ActiveRecord::Schema.define(version: 20180411001814) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "questions", force: :cascade do |t|
    t.string "question", null: false
    t.string "answer", null: false
    t.string "answer_description"
    t.string "more_info"
    t.bigint "topic_id"
    t.index ["topic_id"], name: "index_questions_on_topic_id"
  end

  create_table "scores", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "question_id", null: false
    t.integer "point"
    t.index ["question_id"], name: "index_scores_on_question_id"
    t.index ["user_id"], name: "index_scores_on_user_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string "keyword", null: false
    t.string "description", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "number"
    t.datetime "join_date", default: "2018-04-08 00:48:25", null: false
    t.boolean "stop", default: false
    t.datetime "updated_at", default: "2018-04-08 00:48:25", null: false
  end

end
