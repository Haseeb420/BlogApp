# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title, null: false, index: true
      t.text :body, null: false
      t.date :published_date, default: -> { 'CURRENT_DATE' }, null: false
      t.references :user, index: true, null: false, on_delete: :cascade
      t.references :post_category, foreign_key: true, null: false, on_delete: :cascade

      t.timestamps
    end
  end
end
