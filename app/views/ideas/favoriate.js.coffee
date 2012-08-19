<% unless @idea.errors.any? %>
 btnLink = $('<%= unfavor_idea_button(@idea) %>').hover -> toggleButton(this)
 $("#favor-link-<%= @idea.id %>").replaceWith(btnLink)
<% end %>
