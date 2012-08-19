<% unless @solution.errors.any? %>
 $("#unpick-link-<%= @solution.id %>").replaceWith('<%= pick_solution_link(@solution) %>')
<% end %>
