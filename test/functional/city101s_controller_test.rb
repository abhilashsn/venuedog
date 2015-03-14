require 'test_helper'

class City101sControllerTest < ActionController::TestCase
  setup do
    @city101 = city101s(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:city101s)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create city101" do
    assert_difference('City101.count') do
      post :create, city101: @city101.attributes
    end

    assert_redirected_to city101_path(assigns(:city101))
  end

  test "should show city101" do
    get :show, id: @city101.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @city101.to_param
    assert_response :success
  end

  test "should update city101" do
    put :update, id: @city101.to_param, city101: @city101.attributes
    assert_redirected_to city101_path(assigns(:city101))
  end

  test "should destroy city101" do
    assert_difference('City101.count', -1) do
      delete :destroy, id: @city101.to_param
    end

    assert_redirected_to city101s_path
  end
end
