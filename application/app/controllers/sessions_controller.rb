class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      log_in user
      if params[:session][:remember_me] == '1'
         remember(user)
      else
        forget(user, true)
      end
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def forgot
    user = User.find_by(email: params[:session][:email].downcase)
    if user
      UserMailer.forgot_password(user).deliver_now
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      flash[:danger] = "Error invalid email."
      redirect_to root_url
    end
  end

  def loginemail user
    log_in user
    flash[:success] = "able to login to account, welcome back"
    redirect_to root_url
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  

end
