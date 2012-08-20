class MessagesController < ApplicationController
  authorize_resource

  def show
    message = current_user.messages.find(params[:id])
    message.update_attribute(:readed, true)
    redirect_to message.link
  end

  def update_multiple
    unless params[:message_ids].empty?
      Message.update_all "readed=1", "user_id = #{current_user.id} AND id in (#{params[:message_ids]})" 
    end
    redirect_to inbox_users_url
  end

  def delete_multiple
    unless params[:message_ids].empty?
      Message.delete_all("user_id = #{current_user.id} AND id in (#{params[:message_ids]})")  
    end
    redirect_to inbox_users_url
  end
end
