# Blog App

# Introduction
This is a blog site creating in rails 5.
  



## Demo

click here to see demo
https://blog-site-h.herokuapp.com/

## Authors

- [@MalikHaseeb420](https://www.github.com/MalikHaseeb420)


## Acknowledgements

 - Font-awsome Icon
 - Bootstrap 5
 - Heroku 
 - Cloudinary


## Dependencies
- *rvm* 1.29.12
- *ruby* 2.7.2
- *Rails Version* 5.2.0
- *Cloudinary Storage cloud*
- postgresql
## Installation
- install all dependencies mentioned above. then
- clone project on system
```bash
    git clone "https://github.com/MalikHaseeb420/BlogApp.git"
```
- run bundle command
```bash
    bundle install
```
- edit database.yml file for testing and developement
```bash
    default: &default
    adapter: postgresql
    encoding: unicode
    # For details on connection pooling, see Rails configuration guide
    # http://guides.rubyonrails.org/configuring.html#database-pooling
    pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>

    development:
    <<: *default
    username: "your hostname"
    password: "password"
    host: localhost
    database: blog_app_development

    # Warning: The database defined as "test" will be erased and
    # re-generated from your development database when you run "rake".
    # Do not set this db to the same as development or production.
    test:
    <<: *default
    username: "your hostname"
    password: "password"
    host: localhost
    database: blog_app_test
```
- run these command to create setup database
```bash
    rake db:create
    rake db:migrate
    rake db:seed
```
- run this command to run server
```bash
    bin/rails server
    or
    rails s
```
## Features

1. ### Authentication
    - User should be able to Register, confirm email, Login, modify profile information
    - On 5 incorrect attempts login should be disabled for 5 minutes-
    - On changing email user should re-confirm new email
  2. ### User Roles
    - Admin
    - Moderators
    - Users
  3. ### Dashboard Page
    - A dashboard should show most recent Posts, most recent Comments, most recent Likes
  4. ### Posts Page
    - Listing of Posts
    - Show a Post
    - Create new post
    - Text content with styling(Editor can be used)
    - Inline Attachments (Editors support this but attachments should be uploaded to S3 or any other cloud)
    - Post can be liked, commented or reported
  5. ### Comments
    - Will have attachments
    - Can be Liked
    - Can be replied
    - Can be reported
  6. ### Suggestions
    - User should be able to check suggestions
    - User should be able to modify and replace a suggestion text in his blog Post
    - User should be able to reject a suggestion
    - User should be able to reply a suggestion
    - User should be able to view his Suggestions submitted on others posts
  7. ### For Moderators:
    - A section where they can Approve Posts submitted by Users
    - A section where they can delete or un-publish posts reported by Users
  8. ### Admin Section:
    - Use RailsAdmin and create a complete admin section
    - Admin should be able to manage Users, Posts, Comments, Likes, Reports and Suggestions

