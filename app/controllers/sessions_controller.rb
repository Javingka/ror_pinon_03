class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user #root_url
      else
        message  = "Cuenta no activada. "
        message += "Revisa tu correo electrónico para encontrar el link de activación. "
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Combinación errada de email/password'
      render 'new'
    end
  end

  def destroy
    customapp_out if customapp_in?
    log_out if logged_in?
    redirect_to root_url
  end

end
