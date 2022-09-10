require 'test_helper'

class PostMailerTest < ActionMailer::TestCase
  test 'create_post' do
    mail = PostMailer.create_post
    assert_equal 'Create post', mail.subject
    assert_equal ['to@example.org'], mail.to
    assert_equal ['from@example.com'], mail.from
    assert_match 'Hi', mail.body.encoded
  end

  test 'edit_post' do
    mail = PostMailer.edit_post
    assert_equal 'Edit post', mail.subject
    assert_equal ['to@example.org'], mail.to
    assert_equal ['from@example.com'], mail.from
    assert_match 'Hi', mail.body.encoded
  end
end
