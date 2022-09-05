class PostMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.post_mailer.create_post.subject
  #
  def create_post
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.post_mailer.edit_post.subject
  #
  def edit_post
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
