require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: {user: {user_name: "", email:"user@invalid", phone: "asdasd", password:"foo",password_confirmation:"bar", area: "some invalid place"} }
    end
    assert_template 'users/new'
  end

  test "valid signup information" do 
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: {user: {user_name:"Example User", email: "test14@mail.com", phone_number: "00000000000", password:"passwordpassword1", password_confirmation: "passwordpassword1", area: "Melbourne"} }
    end
    follow_redirect!
    assert_template 'users/show'
  end
end
