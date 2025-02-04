# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

PostCategory.create(category_name: 'Technology')
PostCategory.create(category_name: 'Daily Life')
PostCategory.create(category_name: 'Sports')
user = User.new(
  first_name: 'admin',
  last_name: 'admin',
  email: 'admin@blogsite.com',
  password: 'admin123',
  password_confirmation: 'admin123',
  confirmed_at: Time.zone.now.getutc,
  user_role: 'admin'
)
user.profile_img.attach(io: File.open(Rails.root.join('public/assets/profile_img-9f7db6fe66a347566157a80fad374979fca61f81dfef6250c43f69fb87385aa6.jpg')),
                        filename: 'profile_img.jpeg')
user.save!
user = User.new(
  first_name: 'moderator',
  last_name: 'moderator',
  email: 'moderator@blogsite.com',
  password: 'moderator123',
  password_confirmation: 'moderator123',
  confirmed_at: Time.zone.now.getutc,
  user_role: 'moderator'
)

user.profile_img.attach(io: File.open(Rails.root.join('public/assets/profile_img-9f7db6fe66a347566157a80fad374979fca61f81dfef6250c43f69fb87385aa6.jpg')),
                        filename: 'profile_img.jpeg')
user.save!
