# frozen_string_literal: true

class CreatePostLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :post_likes do |t|
      t.references :user, foreign_key: true, null: false, on_delete: :cascade
      t.references :post, foreign_key: true, null: false, on_delete: :cascade

      t.timestamps
    end
  end
end
