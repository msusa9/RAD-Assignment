require 'test_helper'

class UserSettingsTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:one)
    log_in_as(@user)
    @comment = comments(:one)
    @comment_to_me = comments(:two)
    @post = posts(:one)
    @topic = topics(:Games)
  end

  test "edit user info" do
    get personal_info_edit_users_path

    #checking layout and correct info is present
    assert_select "form input", 7
    assert_select "input#user_user_name[value='#{@user.user_name}']"
    assert_select "input#user_email[value='#{@user.email}']"
    assert_select "input#user_phone_number[value='#{@user.phone_number}']"
    assert_select "input#user_area[value='#{@user.area}']"

    #checking if edits work on user
    name = "Foo"
    patch user_path(@user), params: { user: {name: name, email: @user.email, password: "password", password_confirmation: "password"}}
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
  end

  test "change avatar" do
    get avatar_edit_users_path

    #checking layout and correct info is present
    assert_select "form input", 4
    assert_select "input#user_avatar"

    #ensuring user has no avatar before creating one
    assert_select "div#avatar_settings", false

    #adding avatar to user
    patch user_path(@user), params: {user: {avatar: fixture_file_upload('files/clock.png', 'image/png')}}
    assert_redirected_to @user
    @user.reload
    get avatar_edit_users_path

    #ensuring user has avatar
    assert_select "div#avatar_settings"
    
  end

  test "change password" do
    get password_edit_users_path

    #checking layout
    assert_select "form input", 5
    assert_select "input#user_password"
    assert_select "input#user_password_confirmation"

  end

  test "add verification" do
    get verification_users_path

    #checking layout
    assert_select "form input", 4
    assert_select "input#user_verification"

    #ensuring user does not have verification photo before creating one
    assert_select "div#verification_photo", false

    #adding verification photo to user
    patch user_path(@user), params: {user: {verification: fixture_file_upload('files/clock.png', 'image/png')}}
    assert_redirected_to @user
    @user.reload
    get verification_users_path

    #ensuring user has verification photo
    assert_select "div#verification_photo"
  end

  test "show my comments" do

    get my_comments_users_path
    
    #ensuring no comments before making comment
    assert_select "span#commentIntro", false

    #make comment for user
    post comments_url, params: { comment: { content: @comment.content, pID: @post.id, uID: @user.id } }
    
    get my_comments_users_path

    #ensuring comment of user has been made
    assert_select "span#commentIntro"
  end

  test "show comments to me" do
    get comments_to_me_users_path

    #ensuring no comments have been made to user
    assert_select "span#commentIntro", false

    #making comment to user
    patch post_url(@post), params: { post: { commentCount: @post.commentCount, content: @post.content, title: @post.title, topic: @post.topic, uID: @user.id, view: @post.view , tID: @topic.id} }
    post comments_url, params: { comment: { content: @comment.content, pID: @post.id, uID: @user.id } }

    get comments_to_me_users_path

    #ensuring comment has been made to user
    assert_select "span#commentIntro"

  end

  test "show my posts" do
    post posts_url, params: { post: { commentCount: @post.commentCount, content: @post.content, title: @post.title, topic: @post.topic, uID: @user.id, view: @post.view , tID: @topic.id} }
    get my_posts_users_path
    assert_select "a", @post.title
  end
end
