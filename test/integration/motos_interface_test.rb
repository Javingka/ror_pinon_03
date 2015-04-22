require 'test_helper'

class MotosInterfaceTest < ActionDispatch::IntegrationTest

  def setup 
    @user = users(:javier)
  end

  test "moto interface" do
    log_in_as(@user)
    get root_path
    #invalid new moto
    assert_no_difference 'Moto.count' do
      post motos_path, moto: { modelo: "", description: ""}
    end
    assert_select 'div#error_explanation'
    
    # valid new moto
    modelo = "modeloA"
    description = "descriptionA"
    assert_difference 'Moto.count', 1 do
      post motos_path, moto: { modelo: modelo, description: description }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match modelo, response.body

    # Delete a moto
    assert_select 'a', text: 'eliminar moto'
    first_moto = @user.motos.first
    assert_difference 'Moto.count', -1 do
      delete moto_path(first_moto)
    end

    # Don´t see eliminate in other user
    get user_path(users(:archer))
    assert_select 'a', text: 'eliminar moto', count: 0
  end

end
