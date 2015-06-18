require 'test_helper'

class Dnd5eArchetypesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
