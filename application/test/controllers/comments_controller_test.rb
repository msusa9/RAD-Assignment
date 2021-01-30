require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comment = comments(:one)
    @post = posts(:one)
  end

  test "should get new" do
    get new_comment_url
    assert_response :found
  end

  test "should create comment" do
    post comments_url, params: { comment: { content: @comment.content, pID: @comment.pID, uID: @comment.uID } }
    assert(@comment.save)
  end

  test "should get edit" do
    get edit_comment_url(@comment)
    assert_response :success
  end

  test "should update comment" do
    patch comment_url(@comment), params: { comment: { content: @comment.content, pID: @comment.pID, username: @comment.uID } }
  end

  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      @comment.pID = @post.id
      @comment.save
      delete comment_url(@comment)
    end

    assert_redirected_to @post
  end
end
