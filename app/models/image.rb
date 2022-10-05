# frozen_string_literal: true

class Image < ApplicationRecord
  has_one_attached :attachment
  validates :attachment, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'],
                                 size_range: 1..(5.megabytes) }
end
