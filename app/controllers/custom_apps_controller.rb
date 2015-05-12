class CustomAppsController < ApplicationController
  include CarrierWave::RMagick
  before_action :correct_user, only: :destroy
  before_action :evalua_maximo, only: :create

  def index
    @customapps = CustomApp.paginate(page: params[:page], :per_page => 30)
 
  end

  def show
    @customapp = CustomApp.find(params[:id])
  end

  def create
    @customapp = current_user.custom_apps.build(customapp_params)
 #   puts customapp_params
    if @customapp.save
      customapp_in(@customapp) # CustomApp helper para definir una customización actual.
      crea_imagen(@customapp.est_per_file.to_s, @customapp.apl_per_file.to_s, @customapp.asi_per_file.to_s, @customapp.man_per_file.to_s, @customapp.lla_per_file.to_s, "custom_app/#{@customapp.modelo}/perspectiva/per_plantilla.png", @customapp.modelo)
      flash[:success] = "Customización guardada!"
      respond_to do |format|
       format.html { redirect_to customapp_path }
       format.json { render :json => {
          :location => url_for(:controller => 'static_pages', :action => 'customapp', :method => 'get')
        }}
      end
    else
      redirect_to customapp_path
    end
  end

  def recarga
    @customapp = current_user.custom_apps.find_by(id: params[:id])
    customapp_in(@customapp) # CustomApp helper para definir una customización actual.
    respond_to do |format|
      format.html { redirect_to customapp_path(:modelo => @customapp.modelo) }
      format.json { render :json => {:location => url_for(:controller => 'static_pages', :action => 'customapp',:modelo => @customapp.modelo) }}
    end
  end

  def update
    respond_to do |format|
      if current_custom.update(customapp_params)
        crea_imagen(current_custom.est_per_file, current_custom.apl_per_file, current_custom.asi_per_file, current_custom.man_per_file,  current_custom.lla_per_file, "custom_app/#{@customapp.modelo}/perspectiva/per_plantilla.png", @customapp.modelo)
        flash[:success] = "Customización guardada!"
        flash[:success] = "Cambios guardados!"
        format.html { redirect_to customapp_path }
        format.json { render :json => {:location => url_for(:controller => 'static_pages', :action => 'customapp') }}
      else
        format.html { redirect_to customapp_path }
        format.json { render :json => {:location => url_for(:controller => 'static_pages', :action => 'customapp') }}
      end
    end
  end

  def destroy
    @customapp.destroy
    flash[:success] = "Customizacion eliminada"
    # Using request.referrer we arrange to redirect back to the page issuing the delete request in both cases
    redirect_to customapp_path
  end

  private
    
    def customapp_params
      params.require(:custom_app).permit(:est_per_file,:est_lat_file,:est_sup_file,
                                        :apl_per_file,:apl_lat_file,:apl_sup_file,
                                        :asi_per_file,:asi_lat_file,:asi_sup_file,
                                        :man_per_file,:man_lat_file,:man_sup_file,
                                        :lla_per_file,:lla_lat_file,:lla_sup_file,
                                        :foc_per_file,:foc_lat_file,:foc_sup_file,
                                        :picture, :modelo)
    end

    def correct_user
      @customapp = current_user.custom_apps.find_by(id: params[:id])
      redirect_to root_url if @customapp.nil?
    end

    def evalua_maximo
      puts  "cantidad: "+current_user.custom_apps.count.to_s
      if current_user.custom_apps.count  >= 6
        flash[:info] = "Lo siento, has llegado al máximo de customizaciones. Elimina una de tu lista para guardar una nueva."
        respond_to do |format|
        format.html { redirect_to customapp_path }
        format.json { render :json => {
            :location => url_for(:controller => 'static_pages', :action => 'customapp')
          }}
        end
      end
    end

    def crea_imagen_byn(est, apl, asi, man, base)
      path_img_est = est# "perspectiva/per_estanque_E1FFC6.png"
      path_img_apl = apl# "perspectiva/per_aplicacion_ABA8FF.png"
      path_img_asi = asi# "perspectiva/per_asiento_45291C.png"
      path_img_man = man# "perspectiva/per_manilla_9C6543.png"
      path_img_base = base# "perspectiva/per_plantilla.png"
      capa_1 = Magick::Image.read( path_img_est ).first
      capa_2 = Magick::Image.read( path_img_apl ).first
      capa_3 = Magick::Image.read( path_img_asi ).first
      capa_4 = Magick::Image.read( path_img_man ).first
      capa_5 = Magick::Image.read( path_img_base ).first
      capa_1.composite!(capa_2.composite!(capa_3.composite!( capa_4.composite!( capa_5,0,0, Magick::OverCompositeOp), 0,0, Magick::OverCompositeOp ), 0,0, Magick::OverCompositeOp ), 0,0, Magick::OverCompositeOp ) 
      capa_1 = capa_1.quantize(256, Magick::GRAYColorspace).contrast(true)
      capa_1.write("imagem_temporal_moto_byn.jpg")
    end
  
    def crea_imagen(est, apl, asi, man, lla, base, modelo)
      color_est = get_color_from_path est
      color_apl = get_color_from_path apl
      color_asi = get_color_from_path asi
      color_man = get_color_from_path man
      color_lla = get_color_from_path lla
      est = "#{Rails.root}"+"/app/assets/images/custom_app/"+modelo+"/perspectiva/per_estanque_"+color_est.to_s+".png"
      apl = "#{Rails.root}"+"/app/assets/images/custom_app/"+modelo+"/perspectiva/per_aplicacion_"+color_apl.to_s+".png"
      asi = "#{Rails.root}"+"/app/assets/images/custom_app/"+modelo+"/perspectiva/per_asiento_"+color_asi.to_s+".png"
      man = "#{Rails.root}"+"/app/assets/images/custom_app/"+modelo+"/perspectiva/per_manilla_"+color_man.to_s+".png"
      lla = "#{Rails.root}"+"/app/assets/images/custom_app/"+modelo+"/perspectiva/per_llanta_"+color_lla.to_s+".png"
      logo = "#{Rails.root}"+"/app/assets/images/custom_app/"+modelo+"/area_logo_transparente.png"
      base =  "#{Rails.root}"+"/app/assets/images/custom_app/"+modelo+"/perspectiva/per_plantilla.png"
      capa_1 = Magick::Image.read( est ).first
      capa_2 = Magick::Image.read( apl ).first
      capa_3 = Magick::Image.read( asi ).first
      capa_4 = Magick::Image.read( man ).first
      capa_5 = Magick::Image.read( lla ).first
      capa_6 = Magick::Image.read( logo ).first
      capa_7 = Magick::Image.read( base ).first
      capa_1.composite!(capa_2.composite!(capa_3.composite!( capa_4.composite!( capa_5.composite!(capa_6.composite!(capa_7, 0,0, Magick::OverCompositeOp ), 0,0, Magick::OverCompositeOp ),0,0, Magick::OverCompositeOp), 0,0, Magick::OverCompositeOp ), 0,0, Magick::OverCompositeOp ), 0,0, Magick::OverCompositeOp ) 
      capa_1 = capa_1.scale(840, 630)
      capa_1.write("app/assets/images/imagem_temporal_moto.jpg")

      File.open(File.join(Rails.root,"/app/assets/images/imagem_temporal_moto.jpg")) do |f|
         current_custom.picture = f
      end
      current_custom.save!
    end

end
