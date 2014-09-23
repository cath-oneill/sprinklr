require 'test_helper'

class YardsControllerTest < ActionController::TestCase
  setup do
    @yard = yards(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:yards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create yard" do
    assert_difference('Yard.count') do
      post :create, yard: {  }
    end

    assert_redirected_to yard_path(assigns(:yard))
  end

  test "should show yard" do
    get :show, id: @yard
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @yard
    assert_response :success
  end

  test "should update yard" do
    patch :update, id: @yard, yard: {  }
    assert_redirected_to yard_path(assigns(:yard))
  end

  test "should destroy yard" do
    assert_difference('Yard.count', -1) do
      delete :destroy, id: @yard
    end

    assert_redirected_to yards_path
  end
end
