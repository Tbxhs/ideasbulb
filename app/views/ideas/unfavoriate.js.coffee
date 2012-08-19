<% unless @idea.errors.any? %>
 $("#favor-link-<%= @idea.id %>").replaceWith('<%= favor_idea_button(@idea) %>')
<% end %>
