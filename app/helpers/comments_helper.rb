module CommentsHelper
  def new_comment_button(idea)
    cssClass = user_signed_in? ? "comment-btn":"login-required"
    content_tag :div,:class=>"btn-group" do
      button_tag I18n.t("app.comment.new"),:class=>cssClass+" btn btn-info","data-idea"=> idea.id
    end
  end

  def edit_comment_link(comment)
    if (can? :update,comment) && current_user.id == comment.user.id
      content_tag :li,link_to(I18n.t("app.comment.edit"),"javascript:;","data-comment"=> comment.id,:class=>"edit-comment-link")
    end
  end
  
  def del_comment_link(comment)
   if (can? :destroy,comment) && current_user.id == comment.user.id
      content_tag :li,link_to(I18n.t("app.comment.del"),comment,:method => :delete,:remote => true,"data-comment"=> comment.id,:id=>"del-comment-#{comment.id}")
    end 
  end
end
