class UsersController < ApplicationController


  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @posts = Post.where(uID: @user.id)
    @allPosts = Post.all
    @comments = Comment.where(uID: @user.id)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    if params[:user][:verification].present?
      @user.verification.purge
      @user.verification.attach(params[:user][:verification])
    end
    
    if params[:user][:avatar].present?
      @user.avatar.purge
      @user.avatar.attach(params[:user][:avatar])
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    
    respond_to do |format|
      if @user.save   
        log_in @user
        @user.login
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        if(params[:user][:password]!=nil)
          format.html { render :password_edit }
        else
          format.html { render :personal_info_edit }
        end
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def avatar_edit
    @user = current_user
  end

  def comments_to_me
    @posts = Post.where(uID: current_user.id)
    @allPosts = Post.all
    @comments = Comment.where(pID: @posts.ids)
  end

  def my_comments
    @user = current_user
    @allPosts = Post.all
    @comments = Comment.where(uID: @user.id)
  end

  def my_posts
    @user = current_user
    @posts = Post.where(uID: @user.id)
  end

  def password_edit
    @user = current_user
  end

  def personal_info_edit
    @user = current_user
  end

  def verification
    @user = current_user
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:user_name, :email, :phone_number, :password, :password_confirmation, :area, :verification, :avatar, :bio)
    end
end
