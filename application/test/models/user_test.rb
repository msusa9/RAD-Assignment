require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(user_name: "Example User", email: "user@example.com", phone_number: "1111111111", password: "foobarfoobar", password_confirmation: "foobarfoobar", area: "Melbourne")
  end
  
  test "should be valid" do
    assert @user.valid?
  end

  test "password size should be valid" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
    @user.password = @user.password_confirmation = "a" * 21
    assert_not @user.valid?
    @user.password = @user.password_confirmation = "a" * 15
    assert @user.valid?
    @user.password = @user.password_confirmation = "a" * 8
    assert @user.valid?
    @user.password = @user.password_confirmation = "a" * 20
    assert @user.valid?
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email format should be valid" do
    @user.email = "email"
    assert_not @user.valid?
    @user.email = "email@mail"
    assert_not @user.valid?
    @user.email = "email.com"
    assert_not @user.valid?
    @user.email = "email@mail.com"
    assert @user.valid?
  end

  test "phone number characters should be valid" do
    @user.phone_number = "ppppppppppppp"
    assert_not @user.valid?
    @user.phone_number = "000000000000p0"
    assert_not @user.valid?
    @user.phone_number = "123456789123"
    assert @user.valid?
  end

  test "phone number length should be valid" do
    @user.phone_number = "0" * 5
    assert_not @user.valid?
    @user.phone_number = "0" * 15
    assert_not @user.valid?
    @user.phone_number = "0" * 10
    assert @user.valid?
    @user.phone_number = "0" * 13
    assert @user.valid?
    @user.phone_number = "0" * 12
    assert @user.valid?
  end
  
end
