# frozen_string_literal: true

class CommentLike < ApplicationRecord
  belongs_to :comment
  belongs_to :user
end
