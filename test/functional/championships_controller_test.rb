require 'test_helper'

class ChampionshipsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:championships)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create championship" do
    assert_difference('Championship.count') do
      post :create, :championship => { }
    end

    assert_redirected_to championship_path(assigns(:championship))
  end

  test "should show championship" do
    get :show, :id => championships(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => championships(:one).id
    assert_response :success
  end

  test "should update championship" do
    put :update, :id => championships(:one).id, :championship => { }
    assert_redirected_to championship_path(assigns(:championship))
  end

  test "should destroy championship" do
    assert_difference('Championship.count', -1) do
      delete :destroy, :id => championships(:one).id
    end

    assert_redirected_to championships_path
  end
end
