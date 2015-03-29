require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success # The response :success is an abstract representation of the underlying HTTP status code (in this case, 200 OK).
		assert_select "title", "Home | Piñon"
  end

  test "should get help" do
    get :help
    assert_response :success
		assert_select "title", "Help | Piñon"
  end

	test "should get about" do
		get :about
		assert_response :success
		assert_select "title", "About | Piñon"
	end
end
