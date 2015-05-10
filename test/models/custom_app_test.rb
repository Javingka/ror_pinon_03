require 'test_helper'

class CustomAppTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:javier)
    @customapp = @user.custom_apps.build(est_per_file: 'custom_app/area_transparente.png', est_lat_file:'custom_app/area_transparente.png', est_sup_file:'custom_app/area_transparente.png', apl_per_file:'custom_app/area_transparente.png', apl_lat_file:'custom_app/area_transparente.png', apl_sup_file:'custom_app/area_transparente.png', asi_per_file:'custom_app/area_transparente.png', asi_lat_file:'custom_app/area_transparente.png', asi_sup_file:'custom_app/area_transparente.png', man_per_file:'custom_app/area_transparente.png', man_lat_file:'custom_app/area_transparente.png', man_sup_file:'custom_app/area_transparente.png', lla_per_file:'custom_app/area_transparente.png', lla_lat_file:'custom_app/area_transparente.png', lla_sup_file:'custom_app/area_transparente.png', foc_per_file:'custom_app/area_transparente.png', foc_lat_file:'custom_app/area_transparente.png', foc_sup_file:'custom_app/area_transparente.png', modelo:'ax4')
  end
  
  test "should be valid" do
    assert @customapp.valid?
  end


end
