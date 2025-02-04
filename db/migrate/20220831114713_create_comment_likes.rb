# frozen_string_literal: true

class CreateCommentLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :comment_likes do |t|
      t.references :comment, foreign_key: true
      t.references :user, foreign_key: true, on_delete: :cascade
      t.timestamps
    end
  end
end
