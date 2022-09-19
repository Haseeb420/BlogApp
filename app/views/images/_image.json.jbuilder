# frozen_string_literal: true

json.extract! image, :id, :image_data, :created_at, :updated_at
json.url image_url(image, format: :json)
json.attachment_url rails_blob_url(image.attachment)
