require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:javier)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name) # use full_title thanks to include ApplicationHelper
    assert_select 'h1', text: @user.name
    assert_select 'h1>img.gravatar'
    # response.body contains the full HTML source of the page (and not just the page’s body)
    assert_match @user.microposts.count.to_s, response.body 
    assert_select 'div.pagination' # This checks for an img tag with class gravatar inside a top-level heading tag (h1)
    @user.microposts.paginate(page: 1).each do |micropost|
      assert_match micropost.content, response.body
    end
  end

end
