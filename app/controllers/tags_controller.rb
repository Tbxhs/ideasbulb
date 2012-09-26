class TagsController < ApplicationController
  authorize_resource

  def show
    @tag = @site.tags.find(params[:id])
    @ideas = @tag.ideas.paginate(:page => params[:page]).includes(:tags,:user,:topic,:comments,:solutions).where("status = ?",IDEA_STATUS_REVIEWED_SUCCESS).order(hot_sort)
    render :layout => "list"
  end
end
