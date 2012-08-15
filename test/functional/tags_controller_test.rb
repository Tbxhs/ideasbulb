require 'test_helper'

class TagsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @tag_design = tags(:design)
  end

  test "everybody show user" do
    get :show, id: @tag_design.name
    assert_response :success
    assert_not_nil assigns(:tag)
    assert_not_nil assigns(:ideas)
  end
end
