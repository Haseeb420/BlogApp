# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

PostCategory.create(
  category_name: "Technology"
)
PostCategory.create(
  category_name: "Daily Life"
)
PostCategory.create(
  category_name: "Sports"
)
user = User.new(
  first_name: "admin",
  last_name: "admin",
  email: "admin@blogsite.com",
  profile_img: File.open(Rails.root.join("public/assets/images/profile_img.jpeg")),
  password: "admin123",
  password_confirmation: "admin123",
  confirmed_at: Time.now.getutc,
  user_role: "admin"
)
user.profile_img.attach(io: File.open(Rails.root.join("public/assets/images/profile_img.jpeg")),
                  filename: "profile_img.jpeg")
user.save!
user = User.new(
  first_name: "moderator",
  last_name: "moderator",
  email: "moderator@blogsite.com",
  profile_img: File.open(Rails.root.join("public/assets/images/profile_img.jpeg")),
  password: "moderator123",
  password_confirmation: "moderator123",
  confirmed_at: Time.now.getutc,
  user_role: "moderator"
)

user.profile_img.attach(io: File.open(Rails.root.join("public/assets/images/profile_img.jpeg")),
                  filename: "profile_img.jpeg")
user.save!
