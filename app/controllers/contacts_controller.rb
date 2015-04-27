class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request

    if @contact.deliver
      flash[:info] = "Gracias por contactar a Taller Piñon."
    else
      flash[:error] = "El mensaje no pudo ser enviado"
      render :new
    end
  end
  
end
