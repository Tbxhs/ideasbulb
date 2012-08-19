<% unless @solution.errors.any? %>
 btnLink = $('<%= unpick_solution_link(@solution)%>').hover -> toggleButton(this)
 $("#pick-link-<%= @solution.id %>").replaceWith(btnLink)
<% end %>
