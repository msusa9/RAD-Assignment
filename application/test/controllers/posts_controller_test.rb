require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @post_two = posts(:two)
  end

  test "should get index" do
    get posts_url
    assert_response :ok
  end

  test "should get new" do
    get new_post_url
    assert_response :found
  end

  test "should create post" do
    post posts_url, params: { post: { commentCount: @post.commentCount, content: @post.content, title: @post.title, topic: @post.topic, uID: @post.uID, view: @post.view , tID: @post.tID} }
    assert(@post.save)
  end

  test "should get edit" do
    get edit_post_url(@post)
    assert_response :success
  end

  test "should update post" do
    patch post_url(@post), params: { post: { commentCount: @post.commentCount, content: @post.content, title: @post.title, topic: @post.topic, uID: @post.uID, view: @post.view, tID: @post.tID} }
    assert_redirected_to post_url(@post)
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete post_url(@post)
    end

    assert_redirected_to posts_url
  end
end
