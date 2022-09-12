# frozen_string_literal: true

class AddUserRoleToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_role, :integer, default: 0
  end
end
