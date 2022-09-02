class AddDetailsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :username, :string
    add_column :users, :about, :text
    add_column :users, :birthday, :date
    add_column :users, :number_of_comments, :integer, default:0
  end
end
