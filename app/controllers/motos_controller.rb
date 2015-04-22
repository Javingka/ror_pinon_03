class MotosController < ApplicationController
  before_action :logged_in_user, only: [:indexPinon, :index, :new, :create, :destroy, :show]
  before_action :correct_user, only: :destroy

  def index
    @motos = Moto.paginate(page: params[:page],  :per_page => 30)
  end
  
  def indexPinon
    @userPinon = User.find_by(email: 'admin@pinon.cl') 
    @motosPinon = @userPinon.motos.paginate(page: params[:page],  :per_page => 30) 
  end

  def new
    @moto = Moto.new
  end

  def create
    @moto = current_user.motos.build(moto_params)
    if @moto.save
      flash[:success] = "Nueva moto creada!"
      redirect_to root_url #change this to the moto page
    else
      render new_moto_path
    end
  end

  def show
		@moto = Moto.find(params[:id])
  end

  def destroy
    @moto.destroy
    flash[:success] = "Moto eliminada"
    redirect_to request.referrer || root_url
  end

  def edit
  end

  private

    def moto_params
      params.require(:moto).permit(:modelo, :name, :description, :picture)
    end

    def correct_user
      @moto = current_user.motos.find_by(id: params[:id])
      redirect_to root_url if @moto.nil?
    end
end
