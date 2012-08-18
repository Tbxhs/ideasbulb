class MessagesController < ApplicationController
  authorize_resource

  def show
    message = current_user.messages.find(params[:id])
    message.update_attribute(:readed, true)
    redirect_to message.link
  end
end
