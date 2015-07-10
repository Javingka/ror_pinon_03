class UserMailer < ApplicationMailer

  def account_activation (user)
    @user = user 
    mail to: user.email, subject: "Activación de cuenta Piñon"
  end

  def account_activation_fb (user, fb_key)
    @user = user
    @fb_key = fb_key 
    mail to: user.email, subject: "Activación de cuenta Piñon con facebook"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Nuevo password "
  end
end
