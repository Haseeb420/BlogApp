# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/post_mailer
class PostMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/post_mailer/create_post
  def create_post
    PostMailer.create_post
  end

  # Preview this email at http://localhost:3000/rails/mailers/post_mailer/edit_post
  def edit_post
    PostMailer.edit_post
  end
end
