class CreatePostCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :post_categories do |t|
      t.string :category_name,unique:true

      t.timestamps
    end
  end
end
