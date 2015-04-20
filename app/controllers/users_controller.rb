class UsersController < ApplicationController
  # https://www.railstutorial.org/book/updating_and_deleting_users#sec-requiring_logged_in_users 
  before_action :logged_in_user, only: [:index, :edit , :update, :destroy,
                                        :following, :followers] # Before filters use the before_action command to arrange for a particular method to be called before the given actions
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    # https://www.railstutorial.org/book/updating_and_deleting_users#code-will_paginate_index_action
    @users = User.paginate(page: params[:page]) 
  end
  
	def show
		@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page], :per_page => 10)
	end

  def new
		@user = User.new
  end

	def create
		@user = User.new(user_params)  #https://www.railstutorial.org/book/sign_up#sec-strong_parameters
		if @user.save
      @user.send_activation_email
      flash[:info] = "Por favor revisa tu correo electrónico para activar tu cuenta"
      redirect_to root_url
		else
			render 'new'
		end
	end

  def edit
    # To find the user we use correct_user method. to prevent to any user edit another user profile
  end

  def update
   # To find the user we use correct_user method. to prevent to any user edit another user profile 
    
   if @user.update_attributes(user_params) #https://www.railstutorial.org/book/sign_up#sec-strong_parameters
    flash[:success] = "Perfil actualizado"
    redirect_to @user
   else
     render 'edit'
   end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Usuario eliminado"
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

	private

		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

    # Before filters
    
    # Confirms the correct user
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # Confirms an admin user
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
