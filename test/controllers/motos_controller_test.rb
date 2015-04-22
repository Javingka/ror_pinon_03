require 'test_helper'

class MotosControllerTest < ActionController::TestCase

  def setup 
    @moto = motos(:moto_one)
  end

  test "should redirect create when not logged in" do
    assert_no_difference "Moto.count" do
      post :create, moto: { modelo:"caferacer", name:"mi moto", description:"Lorem ipsum" }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference "Moto.count" do
      delete :destroy, id: @moto
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong moto" do
    log_in_as(users(:javier))
    moto = motos(:moto_two)
    assert_no_difference "Moto.count" do
      delete :destroy, id: moto
    end
    assert_redirected_to root_url
  end

end
