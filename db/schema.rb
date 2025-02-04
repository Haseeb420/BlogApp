# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_220_913_164_946) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.bigint 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id],
            name: 'index_active_storage_attachments_uniqueness', unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.bigint 'byte_size', null: false
    t.string 'checksum', null: false
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'comment_likes', force: :cascade do |t|
    t.bigint 'comment_id'
    t.bigint 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['comment_id'], name: 'index_comment_likes_on_comment_id'
    t.index ['user_id'], name: 'index_comment_likes_on_user_id'
  end

  create_table 'comments', force: :cascade do |t|
    t.bigint 'user_id'
    t.bigint 'post_id'
    t.text 'body', null: false
    t.date 'commented_on', default: -> { 'CURRENT_DATE' }
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'parent_id'
    t.index ['post_id'], name: 'index_comments_on_post_id'
    t.index ['user_id'], name: 'index_comments_on_user_id'
  end

  create_table 'images', force: :cascade do |t|
    t.text 'image_data'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'post_categories', force: :cascade do |t|
    t.string 'category_name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'post_likes', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'post_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['post_id'], name: 'index_post_likes_on_post_id'
    t.index ['user_id'], name: 'index_post_likes_on_user_id'
  end

  create_table 'posts', force: :cascade do |t|
    t.string 'title', null: false
    t.text 'body', null: false
    t.date 'published_date', default: -> { 'CURRENT_DATE' }, null: false
    t.bigint 'user_id', null: false
    t.bigint 'post_category_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'status', default: 0
    t.index ['post_category_id'], name: 'index_posts_on_post_category_id'
    t.index ['title'], name: 'index_posts_on_title'
    t.index ['user_id'], name: 'index_posts_on_user_id'
  end

  create_table 'reported_posts', force: :cascade do |t|
    t.string 'reason', null: false
    t.bigint 'user_id'
    t.bigint 'post_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['post_id'], name: 'index_reported_posts_on_post_id'
    t.index ['user_id'], name: 'index_reported_posts_on_user_id'
  end

  create_table 'suggestions', force: :cascade do |t|
    t.text 'body'
    t.bigint 'post_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['post_id'], name: 'index_suggestions_on_post_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.string 'confirmation_token'
    t.datetime 'confirmed_at'
    t.datetime 'confirmation_sent_at'
    t.string 'unconfirmed_email'
    t.integer 'failed_attempts', default: 0, null: false
    t.string 'unlock_token'
    t.datetime 'locked_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'first_name', null: false
    t.string 'last_name', null: false
    t.integer 'user_role', default: 0
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'comment_likes', 'comments'
  add_foreign_key 'comment_likes', 'users'
  add_foreign_key 'comments', 'posts'
  add_foreign_key 'comments', 'users'
  add_foreign_key 'post_likes', 'posts'
  add_foreign_key 'post_likes', 'users'
  add_foreign_key 'posts', 'post_categories'
  add_foreign_key 'reported_posts', 'posts'
  add_foreign_key 'reported_posts', 'users'
  add_foreign_key 'suggestions', 'posts'
end
