require 'test_helper'

class PostShowTest < ActionDispatch::IntegrationTest
  
  def setup
    @post = posts(:two)
    @user = users(:one)
    @user_two = users(:two)
    log_in_as(@user)

    @comment = comments(:one)
    @comment_two = comments(:two)
    @comment_three = comments(:three)

    @comment.pID = @post.id
    @comment.uID = @user.id
    @comment.save

    @comment_three.pID = @post.id
    @comment_three.uID = @user_two.id
    @comment_three.save
  end

  test "post layout and information" do
    @post.uID = @user.id
    @post.save

    get post_url(@post)
    assert_response :ok
    assert_template "posts/show"

    assert_select 'h1', @post.title
    assert_select 'div#topic', @post.topic
    assert_select "a##{@user.id}", @user.user_name
    assert_select 'div#content', @comment.content
  end

  test "post views" do
    @post.uID = @user.id
    @post.save

    #ensuring post has no views
    assert_equal(@post.view, 0)
    get post_url(@post)

    #ensuring post views has gone up by 1
    assert_select 'span#postView', 1
  end

  test "post comments" do
    @post.uID = @user.id
    @post.save

    #ensuring post has no comments
    assert_equal(@post.commentCount, 0)

    #creating comment on post
    @comment_two.pID = @post.id
    @comment_two.uID = @user.id
    @comment_two.save
    get post_url(@post)

    #ensuring post commentCount has increased by 1
    assert_select 'span#commentCount', 1
  end

  test "ability to comment" do

    #creating comment
    @post.uID = @user.id
    @post.save
    @comment_two.pID = @post.id
    @comment_two.uID = @user.id
    @comment_two.save
    get post_url(@post)

    #seeing if comment is present on page
    assert_select 'div#content', @comment_two.content
  end

  test "ability to edit own comment" do

    #creating comment for user
    @post.uID = @user.id
    @post.save
    @comment_two.pID = @post.id
    @comment_two.uID = @user.id
    @comment_two.save
    get post_url(@post)

    #seeing if edit button is present for user created comment
    assert_select "a#editComment#{@comment.id}", "Edit"
  end

  test "cannot edit not own comment" do

    #creating comment for user two
    @post.uID = @user.id
    @post.save
    @comment_two.pID = @post.id
    @comment_two.uID = @user_two.id
    @comment_two.save
    get post_url(@post)

    #ensuring user cannot edit someone elses comment
    assert_select "a#editComment#{@comment.id}", "Edit", count: 0
  end

  test "ability to edit own post" do
    @post.uID = @user.id
    @post.save
    get post_url(@post)

    #edit button present
    assert_select 'a', "Edit"
  end

  test "cannot edit not own post" do
    @post.uID = @user_two.id
    @post.save
    get post_url(@post)

    #edit button not present
    assert_select 'a', "Edit", count:0
  end
end
