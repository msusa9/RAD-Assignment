require 'test_helper'

class PostIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:one)
    @posts = Post.all
    @topics = Topic.all
    @post = posts(:one)
    @comment = comments(:one)
  end

  test "index when not logged in" do
    get posts_path
    assert_response :ok
    assert_template 'posts/index'
    posts = Post.all
    posts.each do |post|
      assert_select 'a', post.title
    end

    #making sure links for non logged in user are present
    assert_select "a[href='/posts/new']", true
    assert_select "a[href='/login']"
    assert_select "a[href='/users/personal_info_edit']", false
  end

  test "index when logged in" do
    log_in_as(@user)
    get posts_path
    assert_response :ok
    assert_template 'posts/index'

    #ensuring links for logged in user are present
    assert_select "a[href='/logout']"
    assert_select "a[href='/posts/new']"
    assert_select "a[href='/users/personal_info_edit']"

    #checking all posts are present on page
    @posts.each do |post|
      assert_select 'a', post.title
    end
  end

  test "post filtering" do
    get posts_path
    assert_response :ok
    assert_template 'posts/index'

    @topics.each do |topic|
      #seeing if all topic filter buttons are present
      assert_select 'span#filterSpan', topic.name

      #sending filter request
      get posts_path(topic.name => topic.name)
      assert_response :ok

      #getting post name with relevant topic
      postName = "blank"
      @posts.each do |post|
        if(post.topic == topic.name)
          postName=post.title
        end
      end

      if(postName != "blank")
        #checking if post is now present after filtering
        assert_select 'a#mostViewed', postName
      end
    end
  end

  test "additonal links" do

    #ensuring links are present
    get posts_path
    assert_select 'a', "RMIT"
    assert_select 'a', "Google"
    assert_select 'a', "Rails"
    assert_select 'a', "Github"
  end

  test "most viewed posts" do
    get posts_path
    @post.view += 1
    @post.save

    #ensuring post is now present in most viewed
    assert_select 'a#mostViewed', @post.title
  end
  
end
