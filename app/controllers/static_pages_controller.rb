class StaticPagesController < ApplicationController
  before_action :logged_in_user, only: [:share, :save_changes]

  def home
    if logged_in?
      @micropost = current_user.microposts.build 
      @feed_items = current_user.feed.paginate(page: params[:page],:per_page => 10) # feed declared in user model.
    end
    @userPinon = User.find_by(email: 'admin@pinon.cl') #userPinon para mostrar las motos piñon
#    if !@userPinon.nil?  # I had to put this in order to pass the test 
#    @motos = @userPinon.motos.paginate(page: params[:page],  :per_page => 2) 
#    end
  end

  def customapp 
    if logged_in?
      if current_user.custom_apps.any?
        @customapp = current_user.custom_apps.first
#        puts @customapp.est_lat_file
      end

      # Se muestra la moto del usuatio actual
    end

   # @userPinon = User.find_by(email: 'admin@pinon.cl') 
   # if !@userPinon.nil?  # I had to put this in order to pass the test 
    #  @motos = @userPinon.motos.paginate(page: params[:page],  :per_page => 2) 
   # end
  end

  def share

    # To implement for record the data inside CustomApp
  end

  def save_changes

    if logged_in?
     redirect_to customapp_path
     # if current_user.customapps.count  >= 10
     #   flash[:info] = "Has llegado al maximo de customizaciones, edita una de ellas para nuevas combinaciones"
     #   redirect_to root_url #Cambiar para la url de edicion de customizaciones
     # else
     #   @customapp = current_user.customapps.build()
     # end
    end

  end

  def fetch_estanque
    color =  params[:selected_value]
    parte = params[:parte]
    color = color.upcase
    @per_file = "custom_app/perspectiva/per_"+parte+"_"+color+".png"
    @lat_file = "custom_app/lateral/lat_"+parte+"_"+color+".png"
    @sup_file = "custom_app/superior/sup_"+parte+"_"+color+".png"
    per_r = ActionController::Base.helpers.asset_path @per_file
    lat_r = ActionController::Base.helpers.asset_path @lat_file
    sup_r = ActionController::Base.helpers.asset_path @sup_file
    render :json => { :per => per_r, :lat => lat_r , :sup => sup_r } 
  end

  def fetch_aplicacion
    color =  params[:selected_value]
    color = color.upcase
    @per_file = "custom_app/perspectiva/per_aplicacion_"+color+".png"
    @lat_file = "custom_app/lateral/lat_aplicacion_"+color+".png"
    @sup_file = "custom_app/superior/sup_aplicacion_"+color+".png"
    per_r = ActionController::Base.helpers.asset_path @per_file
    lat_r = ActionController::Base.helpers.asset_path @lat_file
    sup_r = ActionController::Base.helpers.asset_path @sup_file
    render :json => { :per => per_r, :lat => lat_r , :sup => sup_r } 
  end

  def fetch_asiento
    color =  params[:selected_value]
    color = color.upcase
    @per_file = "custom_app/perspectiva/per_asiento_"+color+".png"
    @lat_file = "custom_app/lateral/lat_asiento_"+color+".png"
    @sup_file = "custom_app/superior/sup_asiento_"+color+".png"
    per_r = ActionController::Base.helpers.asset_path @per_file
    lat_r = ActionController::Base.helpers.asset_path @lat_file
    sup_r = ActionController::Base.helpers.asset_path @sup_file
    render :json => { :per => per_r, :lat => lat_r , :sup => sup_r } 
  end

  def fetch_manilla
    color =  params[:selected_value]
    color = color.upcase
    @per_file = "custom_app/perspectiva/per_manilla_"+color+".png"
    @lat_file = "custom_app/lateral/lat_manilla_"+color+".png"
    @sup_file = "custom_app/superior/sup_manilla_"+color+".png"
    per_r = ActionController::Base.helpers.asset_path @per_file
    lat_r = ActionController::Base.helpers.asset_path @lat_file
    sup_r = ActionController::Base.helpers.asset_path @sup_file
    render :json => { :per => per_r, :lat => lat_r , :sup => sup_r } 
  end


  def help
  end

	def about
	end

	def contact
	end

  def contact_create
    @contacto = params[:contact]
    ContactMailer.contact_form(@contacto).deliver
    flash[:info] = "Tu mensaje ha sido enviado!"
    redirect_to root_url
  end

end

