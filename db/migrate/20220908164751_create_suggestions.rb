# frozen_string_literal: true

class CreateSuggestions < ActiveRecord::Migration[5.2]
  def change
    create_table :suggestions do |t|
      t.text :body
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
