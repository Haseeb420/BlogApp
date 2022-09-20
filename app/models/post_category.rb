# frozen_string_literal: true

class PostCategory < ApplicationRecord
  has_many :posts
  validates :category_name, presence: true
  validates :category_name, uniqueness: true
end
