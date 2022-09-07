class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true
      t.text :body, null: false
      t.date :commented_on, default: -> { 'CURRENT_DATE' }
      t.timestamps
    end
  end
end
