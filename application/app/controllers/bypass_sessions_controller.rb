class BypassSessionsController < ApplicationController
    def new
        
    end
  
    def create
        user = User.find_by(email: params[:bypass_session][:email].downcase)
        if user
            UserMailer.forgot_password(user).deliver_now
            flash[:info] = "Please check your email to activate your account."
            redirect_to root_url
        else
            flash[:danger] = "Error invalid email."
            redirect_to root_url
        end
    end
  
    def edit
        user = User.find_by(email: params[:email].downcase)
        log_in user
        flash[:success] = "able to login to account, welcome back"
        redirect_to root_url
    end
end
