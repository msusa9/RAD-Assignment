require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
  end

  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {session: {email:"",password:""} }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
    assert session[:user_id].nil?
  end

  test "login with valid email but invalid password" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {session: {email: @user.email, password: "invalidpassword"} }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
    assert session[:user_id].nil?
  end

  test "login with valid password but invalid email" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {session: {email: "invalid@email.com", password: "password"} }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
    assert session[:user_id].nil?
  end

  test "login with valid information" do
    get login_path
    post login_path, params: {session: {email: @user.email,password: 'password'} }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert session[:user_id] = @user.id
  end

  test "valid signup information instantly login" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: {user: {user_name:"Example User", email: "test14@mail.com", phone_number: "00000000000", password:"passwordpassword1", password_confirmation: "passwordpassword1", area: "Melbourne"} }
    end
    follow_redirect!
    assert_template 'users/show'
    assert session[:user_id] = @user.id
  end

  test "login with valid information followed by logout" do
    get login_path
    post login_path, params: {session: {email: @user.email, password:'password'} }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert session[:user_id] = @user.id
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert session[:user_id].nil?
  end

  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_not_empty cookies[:remember_token]
  end
  
  test "login without remembering" do
    # Log in to set the cookie.
    log_in_as(@user, remember_me: '1')
    # Log in again and verify that the cookie is deleted.
    log_in_as(@user, remember_me: '0')
    assert_empty cookies[:remember_token]
  end

  test "user forgotten upon logout" do
    log_in_as(@user, remember_me: '1')
    assert_not_empty cookies[:user_id]
    assert_not_empty cookies[:remember_token]
    delete logout_path
    assert_empty cookies[:user_id]
    assert_empty cookies[:remember_token]
  end

  test "user email is remembered" do 
    log_in_as(@user, remember_me: '1')
    assert_not_empty cookies[:email]
  end

  test "user email is forgotten" do 
    log_in_as(@user, remember_me: '0')
    assert cookies[:email].nil?
  end

  test "user email is remembered even after logout" do 
    log_in_as(@user, remember_me: '1')
    assert_not_empty cookies[:email]
    delete logout_path
    assert_not_empty cookies[:email]
  end
  
end
