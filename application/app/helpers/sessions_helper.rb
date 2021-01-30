module SessionsHelper

    # Logs in the given user.
    def log_in(user)
        session[:user_id] = user.id
        user.login
    end

    def current_user
        if (user_id=session[:user_id])
            @current_user ||= User.find_by(id: user_id)
        elsif (user_id = cookies.signed[:user_id])
            user = User.find_by(id: user_id)
            if user && user.authenticated?(cookies[:remember_token])
                log_in user
                @current_user = user
            end
        end
    end

    def logged_in?
        !current_user.nil?
    end

    # Logs out the current user.
    def log_out
        forget(current_user, false)
        session.delete(:user_id)
        @current_user = nil
    end

    def remember(user)
        user.remember 
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
        cookies.permanent.signed[:email] = user.email
    end


    def forget(user, forget_email)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
        if forget_email
            cookies.delete(:email)
        end
    end

end
