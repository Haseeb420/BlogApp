# frozen_string_literal: true

class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :published_date, :header_img
  has_many :comments
  belongs_to :user
  belongs_to :post_category
  def header_img
    object.header_img.service_url if object.header_img.attached?
  end
end
