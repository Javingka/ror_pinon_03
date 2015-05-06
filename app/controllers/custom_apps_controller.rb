class CustomAppsController < ApplicationController

  def create
    @customapp = current_user.custom_apps.build(customapp_params)
    puts customapp_params
    if @customapp.save
      flash[:success] = "Customización guardada!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
    @customapp.destroy
    flash[:success] = "Customizacion eliminada"
    # Using request.referrer we arrange to redirect back to the page issuing the delete request in both cases
    redirect_to request.referrer || root_url
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


end
