module SessionsHelper

  def log_in(user)
    # 8.2.1 The log_in method | https://www.railstutorial.org/book/sign_up
    session[:user_id] = user.id #session method defined by Rails. (This method is separate and distinct from the Sessions controller
  end

  # Remember a user in a persistent session
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  #https://www.railstutorial.org/book/sign_up ver 8.2.2  BOX 8.1
  def current_user # return current_user objet, lo busca por id, si ya existe actualiza su valor simplemente
    if (user_id = session[:user_id])  # If session of user id exists (while setting user id to session of user id)
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

  #Forgets a persistent session
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Logs out the current user
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

end

