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

  def help
  end

	def about
	end

	def contact
	end
end
