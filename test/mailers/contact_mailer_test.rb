require 'test_helper'

class ContactMailerTest < ActionMailer::TestCase
  test "contact_form" do
    contacto = { :contact => { name: 'Javier', email: 'mail@mail.com', asunto: 'test', message: 'mensaje teste' }}   
    mail = ContactMailer.contact_form(contacto)
    assert_equal "Nuevo mensaje desde la web Piñon", mail.subject
    assert_equal ["contacto@tallerpinon.cl"], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match "Hola hola!", mail.body.encoded
  end

end
