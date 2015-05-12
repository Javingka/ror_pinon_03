class ContactMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.contact_form.subject
  #
  def contact_form(contact)
    @nombre = contact[:name]
    @correo = contact[:email]
    @asunto = contact[:asunto]
    @mensaje = contact[:message]
    @greeting = "Hola hola!"
    mail to: "contacto@tallerpinon.cl", subject: 'Nuevo mensaje desde la web Piñon' 
  end
end
