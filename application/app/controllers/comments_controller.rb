class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:create, :new]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
    @pID = params[:pID]
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        @comment = Comment.new(:content => params[:comment][:content], 
        :pID => params[:comment][:pID], 
        :uID => params[:comment][:uID],
        :date => Time.now)

        @post = Post.find(@comment.pID)
        @post.commentCount += 1
        @post.save
        format.html { redirect_to @post}
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    @posts = Post.all
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to post_path(:id => @comment.pID)}
        #format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @post = Post.find(@comment.pID)
    @post.commentCount -= 1
    @post.save
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @post, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:content, :uID, :pID, :cID)
    end

    def logged_in_user
      unless logged_in?
        redirect_to(root_url)
        flash[:danger] = "Please login"  
      end
    end

end
