# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

PostCategory.create(
  category_name: 'Technology'
)
PostCategory.create(
  category_name: 'Daily Life'
)
PostCategory.create(
  category_name: 'Sports'
)

User.create(
  first_name:'admin',
  last_name: 'admin',
  birthday:"2000-08-01",
  user_role:"admin",
  email: 'admin@gmail.com',
  :encrypted_password => 'password'
)

User.create(
  first_name:'moderator',
  last_name: 'moderator',
  birthday:"2000-08-01",
  user_role:"moderator",
  email: 'moderator@gmail.com',
  :encrypted_password => 'password'
)
