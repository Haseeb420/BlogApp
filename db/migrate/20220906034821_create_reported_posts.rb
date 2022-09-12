# frozen_string_literal: true

class CreateReportedPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :reported_posts do |t|
      t.string :reason, null: false
      t.references :user, foreign_key: true, on_delete: :cascade
      t.references :post, foreign_key: true, on_delete: :cascade

      t.timestamps
    end
  end
end
