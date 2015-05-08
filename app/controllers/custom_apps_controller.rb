class CustomAppsController < ApplicationController
  before_action :correct_user, only: :destroy
  before_action :evalua_maximo, only: :create

  def show
    @customapp = CustomApp.find(params[:id])
  end

  def create
    @customapp = current_user.custom_apps.build(customapp_params)
 #   puts customapp_params
    if @customapp.save
      customapp_in(@customapp) # CustomApp helper para definir una customización actual.
      flash[:success] = "Customización guardada!"
      respond_to do |format|
       format.html { redirect_to customapp_path }
       format.json { render :json => {
          :location => url_for(:controller => 'static_pages', :action => 'customapp', :method => 'get')
        }}
      end
#      render js: "window.location.pathname='#{customapp_path}'"
#      render :js => "window.location = '/static_pages/customapp'"
#      render :json => { :redirec_to => customapp_path } 
#      redirect_to customapp_path
    else
      render 'static_pages/home'
    end
  end

  def recarga
    @customapp = current_user.custom_apps.find_by(id: params[:id])
    customapp_in(@customapp) # CustomApp helper para definir una customización actual.
    respond_to do |format|
      format.html { redirect_to customapp_path }
      format.json { render :json => {:location => url_for(:controller => 'static_pages', :action => 'customapp') }}
    end
  end

  def update
    respond_to do |format|
      if current_custom.update(customapp_params)
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
                                        :foc_per_file,:foc_lat_file,:foc_sup_file)
    end

    def correct_user
      @customapp = current_user.custom_apps.find_by(id: params[:id])
      redirect_to root_url if @customapp.nil?
    end

    def evalua_maximo
      puts  "cantidad: "+current_user.custom_apps.count.to_s
      if current_user.custom_apps.count  >= 6
        flash[:info] = "Lo siento, has llegado al máximo de customizaciones. Edita o elimina una de tu lista."
        respond_to do |format|
        format.html { redirect_to customapp_path }
        format.json { render :json => {
            :location => url_for(:controller => 'static_pages', :action => 'customapp')
          }}
        end
      end
    end

  def crea_imagen_byn (est, apl, asi, man, base)
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
    capa_1.write("test1byb.png")
  end

end
