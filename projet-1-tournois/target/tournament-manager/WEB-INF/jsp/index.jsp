<%@ page import="java.util.List" %>
<%@ page import="com.projetsimple.model.Tournament" %>
<%
    List<Tournament> tournaments = (List<Tournament>) request.getAttribute("tournaments");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestion de tournois</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h1 class="h3">Tableau de bord des tournois</h1>
        <a class="btn btn-primary" href="<%= request.getContextPath() %>/tournaments">Nouveau tournoi</a>
    </div>

    <table class="table table-striped table-bordered bg-white">
        <thead>
        <tr>
            <th>Nom</th>
            <th>Sport</th>
            <th>Type</th>
            <th>Lieu</th>
            <th>Dates</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% if (tournaments != null) {
               for (Tournament t : tournaments) { %>
        <tr>
            <td><%= t.getName() %></td>
            <td><%= t.getSport() %></td>
            <td><%= t.getType() %></td>
            <td><%= t.getLocation() %></td>
            <td><%= t.getStartDate() %> - <%= t.getEndDate() %></td>
            <td class="d-flex gap-2">
                <a class="btn btn-sm btn-outline-primary" href="<%= request.getContextPath() %>/teams?tournamentId=<%= t.getId() %>">Equipes</a>
                <a class="btn btn-sm btn-outline-success" href="<%= request.getContextPath() %>/matches?tournamentId=<%= t.getId() %>">Matchs</a>
                <a class="btn btn-sm btn-outline-dark" href="<%= request.getContextPath() %>/standings?tournamentId=<%= t.getId() %>">Classement</a>
            </td>
        </tr>
        <%     }
           } %>
        </tbody>
    </table>
</div>
</body>
</html>
