class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:show, :create, :new]

  # GET /posts
  # GET /posts.json
  def index
    #get all posts from past 30 days (1 month)
    @posts = Post.all.where('created_at > ?', 30.days.ago)
    
    #seeing if filters have been pressed and adding to a post array topics of posts within the filter
    @postsFilter = Array.new
    @postsFilter += Post.where(topic: params[:Games]).where('created_at > ?', 30.days.ago) if params[:Games].present?
    @postsFilter += Post.where(topic: params[:VR]).where('created_at > ?', 30.days.ago) if params[:VR].present?
    @postsFilter += Post.where(topic: params[:AI]).where('created_at > ?', 30.days.ago) if params[:AI].present?
    @postsFilter += Post.where(topic: params[:Stuff]).where('created_at > ?', 30.days.ago) if params[:Stuff].present?
    @postsFilter += Post.where(topic: params[:World]).where('created_at > ?', 30.days.ago) if params[:World].present?
    @postsFilter += Post.where(topic: params[:COVID19]).where('created_at > ?', 30.days.ago) if params[:COVID19].present?

    #seeing if the post index is filtered, searched, or normal
    if !params[:Games].present? && !params[:VR].present? && !params[:AI].present? && !params[:Stuff].present? && !params[:World].present? && !params[:COVID19].present? && !params[:search].present?
      @posts = @posts.order(created_at: :desc)
    elsif params[:search].present?
      @search = params[:search].downcase
      @posts = Post.where("lower(title) LIKE :search", search: "%#{@search}%").order(created_at: :desc)
    else
      @posts = @postsFilter
      @posts = @posts.sort {|vn1, vn2| vn2[:created_at] <=> vn1[:created_at]}
    end

    @comments = Comment.all
    @topics = Topic.all
    
    #getting 5 most viewed posts
    @mostViewed = Post.all.order(view: :desc).limit(5)

    @users = User.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    #increasing post count by 1
    @post.view += 1
    @post.save

    #finding post topic
    @topic = Topic.where(name: @post.topic)
    @topic.each do |topic|
      topic.views += 1
      topic.save
    end
    @topics = Topic.all

    #getting 5 most viewed posts
    @mostViewed = Post.all.order(view: :desc).limit(5)

    #getting users
    @user_post = User.find(@post.uID)
    @users = User.all
    
    #getting comments
    @comment_new = Comment.new
    @comments = Comment.all
    @comments = Comment.order("created_at desc")
  end

  # GET /posts/new
  def new
    @post = Post.new
    @topics = Topic.all
  end

  # GET /posts/1/edit
  def edit
    @topics = Topic.all
  end

  # POST /posts
  # POST /posts.json
  def create
    if params[:post][:topic] == ''
      params[:post][:topic] = "News"
    end
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        @post = Post.new(:uID => params[:post][:uID], 
        :content => params[:post][:content], 
        :view => params[:post][:view], 
        :date => Time.now, 
        :commentCount => params[:post][:commentCount], 
        :title => params[:post][:title],
        :topic => params[:post][:topic])
        format.html { redirect_to posts_url}
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:topic, :uID, :content, :view, :date, :commentCount, :title)
    end

    def logged_in_user
      unless logged_in?
        redirect_to(root_url)
        flash[:danger] = "Please login"  
      end
    end
end
