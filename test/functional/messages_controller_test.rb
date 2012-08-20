require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @admin_jack = users(:admin_jack)
    @user_tom = users(:user_tom)
    @user_tom_message =  messages(:user_tom_message)
    @user_tom_other_message =  messages(:user_tom_other_message)
    @message_ids = "#{@user_tom_message.id},#{@user_tom_other_message.id}"
  end

  test "everybody not get message" do
    get :show,{id: @user_tom_message.to_param}
    assert_redirected_to root_path
    assert_equal I18n.t('unauthorized.manage.all'),flash[:alert]
  end

  test "login user get own message" do
    sign_in @user_tom
    get :show,{id: @user_tom_message.to_param}
    assert_redirected_to @user_tom_message.link
    assert Message.find(@user_tom_message.id).readed
  end

  test "login user not get other message" do
    sign_in @admin_jack
    assert_raise(ActiveRecord::RecordNotFound){
      get :show,{id: @user_tom_message.to_param}
    }
  end

  test "everybody not update_multiple" do
    put :update_multiple,{message_ids: @message_ids}
    assert_redirected_to root_path
    assert_equal I18n.t('unauthorized.manage.all'),flash[:alert]
  end

  test "login user update_multiple own message" do
    sign_in @user_tom
    put :update_multiple,{message_ids: @message_ids}
    assert_redirected_to inbox_users_url 
    Message.find([@user_tom_message.id,@user_tom_other_message.id]).each do |message|
      assert message.readed
    end
  end

  test "login user not update_multiple other message" do
    sign_in @admin_jack
    put :update_multiple,{message_ids: @message_ids}
    assert_redirected_to inbox_users_url 
    Message.find([@user_tom_message.id,@user_tom_other_message.id]).each do |message|
      assert !message.readed
    end
  end

  test "everybody not delete_multiple" do
    delete :delete_multiple,{message_ids: @message_ids}
    assert_redirected_to root_path
    assert_equal I18n.t('unauthorized.manage.all'),flash[:alert]
  end

  test "login user delete_multiple own message" do
    sign_in @user_tom
    delete :delete_multiple,{message_ids: @message_ids}
    assert_redirected_to inbox_users_url 
    assert_raise(ActiveRecord::RecordNotFound){
      Message.find([@user_tom_message.id,@user_tom_other_message.id])
    }
  end

  test "login user not delete_multiple other message" do
    sign_in @admin_jack
    delete :delete_multiple,{message_ids: @message_ids}
    assert_redirected_to inbox_users_url 
    Message.find([@user_tom_message.id,@user_tom_other_message.id]).each do |message|
      assert !message.readed
    end
  end
end
