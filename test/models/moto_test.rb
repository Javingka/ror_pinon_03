require 'test_helper'

class MotoTest < ActiveSupport::TestCase

  def setup
    @user = users(:javier)
    @moto = @user.motos.build(modelo: "caferacer", name: "piñogenita", description: "Lorem ipsum", user_id: @user.id)
  end

  test "should be valid" do
    assert @moto.valid?
  end

  test "user it should be present" do
    @moto.user_id = nil
    assert_not @moto.valid?
  end

  test "modelo and description should be present" do
    @moto.modelo = "  "
    @moto.description = "  "
    assert_not @moto.valid?
  end
  
end
