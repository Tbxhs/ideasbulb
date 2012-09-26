class UsersController < ApplicationController
  authorize_resource

  def show
    @user = User.find(params[:id])
    @ideas = @user.ideas.where(:site_id => @site.id).paginate(:page => params[:page]).includes(:tags,:user,:topic,:comments,:solutions).order(hot_sort)
    @ideas_count = @user.ideas.where(:site_id => @site.id).count
    @ideas_favored_count = @user.favored_ideas.where(:site_id => @site.id).count
    render :layout => "list"
  end

end
