# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { Faker::Lorem.characters(number: 20) }
    association :post_category
    body { Faker::Lorem.characters(number: 60) }
    header_img do
      Rack::Test::UploadedFile.new Rails.root.join('public/assets/profile_img-9f7db6fe66a347566157a80fad374979fca61f81dfef6250c43f69fb87385aa6.jpg'),
                                   'image/jpg'
    end
    association :user
  end
end
