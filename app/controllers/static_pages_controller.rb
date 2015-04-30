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

  def fetch
    color =  params[:selected_value]
    color = color.upcase
    @est_file = "custom_app/perspectiva/per_estanque_"+color+".png"
    puts @est_file
    resp = ActionController::Base.helpers.asset_path @est_file
    puts resp
    render :text => resp
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
