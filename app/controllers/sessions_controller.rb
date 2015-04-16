class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      log_in user # method declared in sessions_helper
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user
    else
      #create an error message
      flash.now[:danger] = "Combinación email/password no es valida"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end