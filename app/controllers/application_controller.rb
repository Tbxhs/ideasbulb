class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def after_sign_in_path_for(resource)
    sign_in_url = url_for(:action => 'new', :controller => 'sessions', :only_path => false, :protocol => 'http')
    if (request.referer == sign_in_url)
      super
    else
       request.referer || root_path
    end  
  end

  def hot_sort
    "(2*`solutions_count`+`comments_count`+`solutions_points`)/POW(TIMESTAMPDIFF(HOUR,`ideas`.`created_at`,NOW())+2,1.5) DESC" 
  end
end
