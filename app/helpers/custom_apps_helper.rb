module CustomAppsHelper

  def customapp_in(custom)
    # 8.2.1 The log_in method | https://www.railstutorial.org/book/sign_up
    session[:customapp_id] = custom.id #session method defined by Rails. (This method is separate and distinct from the Sessions controller
  end

  def current_custom # return current_custom objet, lo busca por id, si ya existe actualiza su valor simplemente
    if (custom_id = session[:customapp_id])  # If session of user id exists (while setting user id to session of user id)
      @current_custom ||= CustomApp.find_by(id: custom_id)
    end
  end

  def customapp_in?
    !current_custom.nil?
  end

  # Logs out the current user
  def customapp_out
    session.delete(:customapp_id)
    @current_custom = nil
  end


end
