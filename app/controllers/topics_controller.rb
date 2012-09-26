class TopicsController < ApplicationController
  authorize_resource
  layout "admin"

  def show
    @topic = @site.topics.find(params[:id])
    @ideas = @topic.ideas.paginate(:page => params[:page]).includes(:tags,:user,:topic,:comments,:solutions).where("status = ?",IDEA_STATUS_REVIEWED_SUCCESS).order(hot_sort)
    render :layout => "list"
  end

end
