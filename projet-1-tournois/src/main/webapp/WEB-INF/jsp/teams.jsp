<%@ page import="java.util.List" %>
<%@ page import="com.projetsimple.model.Team" %>
<%@ page import="com.projetsimple.model.Tournament" %>
<%
    Tournament tournament = (Tournament) request.getAttribute("tournament");
    List<Team> teams = (List<Team>) request.getAttribute("teams");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Equipes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4">
    <h1 class="h4">Equipes - <%= tournament != null ? tournament.getName() : "" %></h1>

    <form method="post" action="<%= request.getContextPath() %>/teams" class="card card-body mb-3">
        <input type="hidden" name="tournamentId" value="<%= tournament.getId() %>">
        <div class="row g-2">
            <div class="col-md-4"><input class="form-control" name="name" placeholder="Nom equipe" required></div>
            <div class="col-md-4"><input class="form-control" name="logoUrl" placeholder="URL logo"></div>
            <div class="col-md-4"><input class="form-control" name="contact" placeholder="Contact"></div>
        </div>
        <div class="mt-2"><button class="btn btn-primary" type="submit">Ajouter equipe</button></div>
    </form>

    <table class="table table-bordered bg-white">
        <thead><tr><th>#</th><th>Nom</th><th>Logo</th><th>Contact</th></tr></thead>
        <tbody>
        <% if (teams != null) {
               for (Team team : teams) { %>
        <tr>
            <td><%= team.getId() %></td>
            <td><%= team.getName() %></td>
            <td><%= team.getLogoUrl() == null ? "" : team.getLogoUrl() %></td>
            <td><%= team.getContact() == null ? "" : team.getContact() %></td>
        </tr>
        <%     }
           } %>
        </tbody>
    </table>

    <div class="d-flex gap-2">
        <a class="btn btn-success" href="<%= request.getContextPath() %>/matches?tournamentId=<%= tournament.getId() %>">Voir / generer matchs</a>
        <a class="btn btn-secondary" href="<%= request.getContextPath() %>/">Retour</a>
    </div>
</div>
</body>
</html>
