module SessionsHelper

  def log_in(user)
    # 8.2.1 The log_in method | https://www.railstutorial.org/book/sign_up
    session[:user_id] = user.id #session method defined by Rails. (This method is separate and distinct from the Sessions controller
  end

  #https://www.railstutorial.org/book/sign_up ver 8.2.2  BOX 8.1
  def current_user # return current_user objet, lo busca por id, si ya existe actualiza su valor simplemente
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end
end

