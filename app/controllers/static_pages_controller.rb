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
          crea_gon_object(current_custom.est_per_file, current_custom.apl_per_file, current_custom.asi_per_file, current_custom.man_per_file, current_custom.lla_per_file, "custom_app/#{current_custom.modelo}/perspectiva/per_plantilla.png", @modelo) # crea objeto gon, con los datos de color de las partes de la moto => gon.archivos
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

    def crea_gon_object(est, apl, asi, man, lla, base, modelo)
      color_est = get_color_from_path est
      color_apl = get_color_from_path apl
      color_asi = get_color_from_path asi
      color_man = get_color_from_path man
      color_lla = get_color_from_path lla
      
      #archivos del estanque
          @est_pf = ActionController::Base.helpers.asset_path "custom_app/"+modelo.to_s+"/perspectiva/per_estanque_"+color_est.to_s+".png" 
          @est_lf = ActionController::Base.helpers.asset_path "custom_app/"+modelo.to_s+"/lateral/lat_estanque_"+color_est.to_s+".png"
          @est_sf = ActionController::Base.helpers.asset_path "custom_app/"+modelo.to_s+"/superior/sup_estanque_"+color_est.to_s+".png"
      #archivos de la aplicacion del estanque
          @apl_pf = ActionController::Base.helpers.asset_path "custom_app/"+modelo.to_s+"/perspectiva/per_aplicacion_"+color_apl.to_s+".png"
          @apl_lf = ActionController::Base.helpers.asset_path "custom_app/"+modelo.to_s+"/lateral/lat_aplicacion_"+color_apl.to_s+".png"
          @apl_sf = ActionController::Base.helpers.asset_path "custom_app/"+modelo.to_s+"/superior/sup_aplicacion_"+color_apl.to_s+".png"
      #archivos del asiento 
          @asi_pf = ActionController::Base.helpers.asset_path "custom_app/"+modelo.to_s+"/perspectiva/per_asiento_"+color_asi.to_s+".png"
          @asi_lf = ActionController::Base.helpers.asset_path "custom_app/"+modelo.to_s+"/lateral/lat_asiento_"+color_asi.to_s+".png"
          @asi_sf = ActionController::Base.helpers.asset_path "custom_app/"+modelo.to_s+"/superior/sup_asiento_"+color_asi.to_s+".png"
      #manillar
          @man_pf = ActionController::Base.helpers.asset_path "custom_app/"+modelo.to_s+"/perspectiva/per_manilla_"+color_man.to_s+".png" 
          @man_lf = ActionController::Base.helpers.asset_path "custom_app/"+modelo.to_s+"/lateral/lat_manilla_"+color_man.to_s+".png"
          @man_sf = ActionController::Base.helpers.asset_path "custom_app/"+modelo.to_s+"/superior/sup_manilla_"+color_man.to_s+".png"
      # llantas
          @lla_pf = ActionController::Base.helpers.asset_path "custom_app/"+modelo.to_s+"/perspectiva/per_llanta_"+color_lla.to_s+".png" 
          @lla_lf = ActionController::Base.helpers.asset_path "custom_app/"+modelo.to_s+"/lateral/lat_llanta_"+color_lla.to_s+".png"
          @lla_sf = ActionController::Base.helpers.asset_path "custom_app/"+modelo.to_s+"/superior/sup_llanta_"+color_lla.to_s+".png"
          
          gon.archivos = { est_pf: @est_pf, est_lf: @est_lf, est_sf: @est_sf,
                           apl_pf: @apl_pf, apl_lf: @apl_lf, apl_sf: @apl_sf,
                           asi_pf: @asi_pf, asi_lf: @asi_lf, asi_sf: @asi_sf,
                           man_pf: @man_pf, man_lf: @man_lf, man_sf: @man_sf, 
                           lla_pf: @lla_pf, lla_lf: @lla_lf, lla_sf: @lla_sf} 
                          # Falta colocar la info de llantay foco
   end

end

