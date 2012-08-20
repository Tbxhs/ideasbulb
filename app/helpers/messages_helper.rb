module MessagesHelper
  def message_link_tag(message)
    if message.readed 
      message_class_link_tag(message,"message shallow","readed")   
    else
      message_class_link_tag(message,"message bold","unread")   
    end
  end

  def message_class_link_tag(message,cssClass,key)
    link_to message_path(message),:class=>cssClass do
      content_tag(:span,I18n.t("app.message.#{key}")+message.content)+content_tag(:span,distance_of_time_in_words_to_now(message.created_at),:class=>"shallow",:style=>"float:right")
    end
  end

  def message_span_tag(count)
    cssClass ="label"
    cssClass += " label-important" if count > 0
    content_tag(:span,count,:style=>"display:inline-block;width:18px;height:18px;text-align:center;font-size:14px;line-height:18px",:class=>cssClass) 
  end
end
