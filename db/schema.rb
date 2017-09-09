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

ActiveRecord::Schema.define(version: 20170909202158) do

  create_table "comments", force: :cascade do |t|
    t.text "text"
    t.integer "commentable_id"
    t.string "commentable_type"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "communities", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "title"
    t.index ["slug"], name: "index_communities_on_slug", unique: true
  end

  create_table "moderations", force: :cascade do |t|
    t.integer "moderator_id"
    t.integer "moderated_id"
    t.index ["moderated_id"], name: "index_moderations_on_moderated_id"
    t.index ["moderated_id"], name: "index_moderations_on_moderated_id_and_moderated_id", unique: true
    t.index ["moderator_id"], name: "index_moderations_on_moderator_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "type", null: false
    t.string "title"
    t.string "link"
    t.text "text"
    t.integer "user_id"
    t.integer "community_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "savings", force: :cascade do |t|
    t.integer "saver_id"
    t.string "saved_type"
    t.integer "saved_post_id"
    t.integer "saved_comment_id"
    t.index ["saver_id"], name: "index_savings_on_saver_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.text "about_me"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "slug"
    t.integer "post_karma", default: 0
    t.integer "comment_karma", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.string "votable_type"
    t.integer "votable_id"
    t.string "voter_type"
    t.integer "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["votable_type", "votable_id"], name: "index_votes_on_votable_type_and_votable_id"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
    t.index ["voter_type", "voter_id"], name: "index_votes_on_voter_type_and_voter_id"
  end

end
