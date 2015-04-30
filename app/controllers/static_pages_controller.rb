class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @micropost = current_user.microposts.build 
      @feed_items = current_user.feed.paginate(page: params[:page],:per_page => 10) # feed declared in user model.
    end
    @userPinon = User.find_by(email: 'admin@pinon.cl') 
    if !@userPinon.nil?  # I had to put this in order to pass the test 
    @motos = @userPinon.motos.paginate(page: params[:page],  :per_page => 2) 
    end
  end

  def customapp 
    @userPinon = User.find_by(email: 'admin@pinon.cl') 
    if !@userPinon.nil?  # I had to put this in order to pass the test 
    @motos = @userPinon.motos.paginate(page: params[:page],  :per_page => 2) 
    end
  end

  def fetch_estanque
    color =  params[:selected_value]
    color = color.upcase
    @per_file = "custom_app/perspectiva/per_estanque_"+color+".png"
    @lat_file = "custom_app/lateral/lat_estanque_"+color+".png"
    @sup_file = "custom_app/superior/sup_estanque_"+color+".png"
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

