require 'test_helper'

class ContactMailerTest < ActionMailer::TestCase
  test "contact_form" do
    contacto = { :contact => { name: 'Javier', email: 'mail@mail.com', asunto: 'test', message: 'mensaje teste' }}   
    mail = ContactMailer.contact_form(contacto)
    assert_equal "Nuevo mensaje desde Piñon", mail.subject
    assert_equal ["jcruzsm@gmail.com"], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
