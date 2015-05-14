class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "Cuenta activada!"
      redirect_to user_url.sub('pinon.herokuapp.com', 'www.tallerpinon.cl')# user(subdomain: 'www.tallerdinamo.cl') # redirect_back_or user
    else
      flash[:danger] = "Link de activación invalido"
      redirect_to root_url.sub('pinon.herokuapp.com', 'www.tallerpinon.cl') #(subdomain: 'www.tallerdinamo.cl')
    end
  end

end
