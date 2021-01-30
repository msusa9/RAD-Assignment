require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  test "forgot_password" do
    user = users(:one)
    mail = UserMailer.forgot_password(user)
  end

end
