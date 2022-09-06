class CreateReportedPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :reported_posts do |t|
      t.string :reason, null:false
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
