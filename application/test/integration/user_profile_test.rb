require 'test_helper'

class UserProfileTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:one)
    @post = posts(:one)
    @topic = topics(:Games)
    @comment = comments(:one)
  end

  test "show my posts" do
    #editing post to make it users posts
    patch post_url(@post), params: { post: { commentCount: @post.commentCount, content: @post.content, title: @post.title, topic: @post.topic, uID: @user.id, view: @post.view , tID: @topic.id} }
    
    get user_path(@user)

    #seeing if link to post title of user is present
    assert_select "a", @post.title
  end

  test "show my comments" do
    #editing comment to make it users comment
    patch comment_url(@comment), params: { comment: { content: @comment.content, pID: @post.id, uID: @user.id } }

    get user_path(@user)

    #seeing if span with comment content is present
    assert_select "span", @comment.content
  end

  test "show user info" do
    get user_path(@user)

    assert_select "div#username", @user.user_name
    assert_select "div#city", @user.area
    assert_select "div#bio", @user.bio
  end
end
