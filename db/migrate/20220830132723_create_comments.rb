class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      # t.text :edit_history, default: ''
      # t.integer :commentable_id
      # t.string :commentable_type
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true
      # t.boolean :reply, default:true
      # # t.integer :comment
      t.text :body
      t.date :commented_on, default: -> { 'CURRENT_DATE' }
      t.timestamps
    end
  end
end
