module MessagesHelper
  def message_span_tag(count)
    cssClass ="label"
    cssClass += " label-important" if count > 0
    content_tag(:span,count,:style=>"display:inline-block;width:18px;height:18px;text-align:center;font-size:14px;line-height:18px",:class=>cssClass) 
  end
end
