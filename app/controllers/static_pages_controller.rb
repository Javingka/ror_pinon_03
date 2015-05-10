class StaticPagesController < ApplicationController
  before_action :logged_in_user, only: [:share, :save_changes]

  def home
    if logged_in?
      @micropost = current_user.microposts.build 
      @feed_items = current_user.feed.paginate(page: params[:page],:per_page => 10) # feed declared in user model.
    end
    @userPinon = User.find_by(email: 'admin@pinon.cl') #userPinon para mostrar las motos piñon
    if !@userPinon.nil?  # I had to put this in order to pass the test 
      @motos = @userPinon.motos.paginate(page: params[:page],  :per_page => 2) 
    end
  end

  def customapp 
    @modelo = params[:modelo]
    gon.archivos 
    gon.update_path
    if logged_in?
      if current_user.custom_apps.any?
        @customapp = current_user.custom_apps
        
        if customapp_in?
          crea_gon_object() # crea objeto gon, con los datos de color de las partes de la moto => gon.archivos
          gon.update_path = custom_app_path(@customapp)  
        end
#        puts @customapp.est_lat_file
      end
    end
  end

  def share
    # To implement for record the data inside CustomApp
  end 
 

  def save_changes

    if logged_in?
     redirect_to customapp_path
    end

  end

  def fetch_pieza
    color =  params[:color]
    parte = params[:parte]
    modelo = params[:modelo]
    color = color.upcase
    @per_file = "custom_app/"+modelo+"/perspectiva/per_"+parte+"_"+color+".png"
    @lat_file = "custom_app/"+modelo+"/lateral/lat_"+parte+"_"+color+".png"
    @sup_file = "custom_app/"+modelo+"/superior/sup_"+parte+"_"+color+".png"
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
    ContactMailer.delay.contact_form(@contacto)
    flash[:info] = "Tu mensaje ha sido enviado!"
    redirect_to root_url
  end

  private

    def crea_gon_object
          @est_pf = current_custom.est_per_file #archivos del estanque
          @est_lf = current_custom.est_lat_file
          @est_sf = current_custom.est_sup_file
          @apl_pf = current_custom.apl_per_file #archivos de la aplicacion del estanque
          @apl_lf = current_custom.apl_lat_file
          @apl_sf = current_custom.apl_sup_file
          @asi_pf = current_custom.asi_per_file #archivos del asiento 
          @asi_lf = current_custom.asi_lat_file
          @asi_sf = current_custom.asi_sup_file
          @man_pf = current_custom.man_per_file #manillar
          @man_lf = current_custom.man_lat_file
          @man_sf = current_custom.man_sup_file
          @lla_pf = current_custom.lla_per_file # llantas
          @lla_lf = current_custom.lla_lat_file
          @lla_sf = current_custom.lla_sup_file
          @foc_pf = current_custom.foc_per_file # foco
          @foc_lf = current_custom.foc_lat_file
          @foc_sf = current_custom.foc_sup_file
          
          gon.archivos = { est_pf: @est_pf, est_lf: @est_lf, est_sf: @est_sf,
                           apl_pf: @apl_pf, apl_lf: @apl_lf, apl_sf: @apl_sf,
                           asi_pf: @asi_pf, asi_lf: @asi_lf, asi_sf: @asi_sf,
                           man_pf: @man_pf, man_lf: @man_lf, man_sf: @man_sf} 
                          # Falta colocar la indo de llantay foco
   end

end

