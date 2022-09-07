require 'cloudinary'

Cloudinary.config_from_url("cloudinary://735146786352999:yK74dJRJd9savEn2RT4FyeLnR-U@blog-site-h")
Cloudinary.config do |config|
  config.secure = true
end
