# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { "Haseeb" }
    last_name { "Malik" }
    email { "email@gmail.com" }
    password { "123456" }
    password_confirmation { "123456" }
    profile_img { Rack::Test::UploadedFile.new Rails.root.join("public/assets/profile_img-9f7db6fe66a347566157a80fad374979fca61f81dfef6250c43f69fb87385aa6.jpg"), "image/jpg" }
  end
end
