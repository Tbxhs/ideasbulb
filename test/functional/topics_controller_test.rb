require 'test_helper'

class TopicsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @topic_iPhone = topics(:topic_iPhone)
    @topic_website = topics(:topic_website)
    @admin_jack = users(:admin_jack)
    @user_tom = users(:user_tom)
  end

  test "everybody get show" do
    get :show,{:id => @topic_website.name}
    assert_response :success
    assert_not_nil assigns(:topic)
    assert_not_nil assigns(:ideas)
  end

  test "normal user not get index" do
    sign_in @user_tom
    get :index
    assert_redirected_to root_path
    assert_equal I18n.t('unauthorized.manage.all'),flash[:alert]
  end

  test "admin get index" do
    sign_in @admin_jack
    get :index
    assert_response :success
    assert_not_nil assigns(:topics)
  end

  test "normal user not new" do
    sign_in @user_tom
    get :new
    assert_redirected_to root_path
    assert_equal I18n.t('unauthorized.manage.all'),flash[:alert]
  end

  test "admin get new" do
    sign_in @admin_jack
    get :new
    assert_response :success
    assert_template :new
    assert_not_nil assigns(:topic)
  end

  test "normal user not create" do
    sign_in @user_tom
    post :create
    assert_redirected_to root_path
    assert_equal I18n.t('unauthorized.manage.all'),flash[:alert]
  end

  test "admin create" do
    sign_in @admin_jack
    assert_difference('Topic.count') do
      post :create,:topic => { :name => 'a new topic'}
    end
    assert_redirected_to :action => :index
  end

  test "admin create invalid" do
    sign_in @admin_jack
    assert_no_difference('Topic.count') do
      post :create,:topic => { :name => 'a n.ew topic'}
    end
    assert_template :new
  end

  test "normal user not destroy" do
    sign_in @user_tom
    xhr :delete,:destroy,{:id => @topic_website.id}
    assert_redirected_to root_path
    assert_equal I18n.t('unauthorized.manage.all'),flash[:alert]
  end

  test "admin destroy valid topic" do
    sign_in @admin_jack
    assert_difference('Topic.count',-1) do
      xhr :delete,:destroy,{:id => @topic_website.id}
    end 
    assert_response :success
  end

  test "admin destroy invalid topic" do
    sign_in @admin_jack
    assert_no_difference('Topic.count') do
      xhr :delete,:destroy,{:id => @topic_iPhone.id}
    end 
    assert_response :success
  end

  test "normal user not edit" do
    sign_in @user_tom
    get :edit,{:id => @topic_iPhone.id}
    assert_redirected_to root_path
    assert_equal I18n.t('unauthorized.manage.all'),flash[:alert]
  end

  test "admin get edit" do
    sign_in @admin_jack
    get :edit,{:id => @topic_iPhone.id}
    assert_response :success
    assert_template :edit
    assert_not_nil assigns(:topic)
  end

  test "normal user not update" do
    sign_in @user_tom
    put :update,{:id => @topic_iPhone.id}
    assert_redirected_to root_path
    assert_equal I18n.t('unauthorized.manage.all'),flash[:alert]
  end

  test "admin update" do
    sign_in @admin_jack
    assert_no_difference('Topic.count') do
      put :update,{:id => @topic_iPhone.id,:topic => {:name => "update a name"}}
    end
    assert_redirected_to :action => :index
  end

  test "admin update invalid" do
    sign_in @admin_jack
    assert_no_difference('Topic.count') do
      put :update,{:id => @topic_iPhone.id,:topic => {:name => "upd.ate a name"}}
    end
    assert_template :edit
  end
end
