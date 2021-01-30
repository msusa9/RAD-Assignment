require 'test_helper'

include SessionsHelper
include UsersHelper

class RecentUsersTest < ActionDispatch::IntegrationTest
  
  def setup
    @user_first = users(:one)
    @user_last = users(:thirteen)
  end

  test "logged in member is most recent user" do
    assert @user_first.id == recent_users.first.id
    @user_last.login
    assert @user_last.id == recent_users.first.id
  end

  test "logged in member should make first member not most recent member" do
    assert @user_first.id == recent_users.first.id
    @user_last.login
    assert @user_first.id == recent_users[1].id
  end

end
