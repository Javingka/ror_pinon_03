class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user # method declared in sessions_helper
      redirect_to user
    else
      #create an error message
      flash.now[:danger] = "Combinación email/password no es valida"
      render 'new'
    end
  end

  def destroy
  end

end
