class CommentsController < ApplicationController
  authorize_resource

  def create
    @comment = current_user.comments.build(params[:comment])
    @comment.idea = Idea.find(params[:idea_id])
    @comment.save
  end

  def update
    @comment = current_user.comments.find(params[:id])
    @comment.update_attributes(params[:comment])
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
  end
end
