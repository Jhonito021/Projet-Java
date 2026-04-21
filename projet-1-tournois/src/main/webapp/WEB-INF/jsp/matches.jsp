<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.projetsimple.model.Match" %>
<%@ page import="com.projetsimple.model.Tournament" %>
<%
    Tournament tournament = (Tournament) request.getAttribute("tournament");
    List<Match> matches = (List<Match>) request.getAttribute("matches");
    Map<Integer, String> teamNames = (Map<Integer, String>) request.getAttribute("teamNames");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Matchs</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4">
    <h1 class="h4">Matchs - <%= tournament != null ? tournament.getName() : "" %></h1>
    <p class="text-muted">Le calendrier est genere automatiquement au premier affichage.</p>

    <table class="table table-bordered bg-white align-middle">
        <thead>
        <tr><th>Phase</th><th>Date</th><th>Terrain</th><th>Affiche</th><th>Score</th><th>Action</th></tr>
        </thead>
        <tbody>
        <% if (matches != null) {
               for (Match match : matches) { %>
        <tr>
            <td><%= match.getStage() %></td>
            <td><%= match.getScheduledAt() %></td>
            <td><%= match.getFieldNumber() %></td>
            <td>
                <%= teamNames.getOrDefault(match.getHomeTeamId(), "TBD") %>
                vs
                <%= teamNames.getOrDefault(match.getAwayTeamId(), "TBD") %>
            </td>
            <td><%= match.getHomeScore() == null ? "-" : match.getHomeScore() %> - <%= match.getAwayScore() == null ? "-" : match.getAwayScore() %></td>
            <td>
                <form method="post" action="<%= request.getContextPath() %>/matches" class="d-flex gap-2">
                    <input type="hidden" name="tournamentId" value="<%= tournament.getId() %>">
                    <input type="hidden" name="matchId" value="<%= match.getId() %>">
                    <input type="number" class="form-control form-control-sm" min="0" name="homeScore" style="width:80px" required>
                    <input type="number" class="form-control form-control-sm" min="0" name="awayScore" style="width:80px" required>
                    <button class="btn btn-sm btn-primary" type="submit">Valider</button>
                </form>
            </td>
        </tr>
        <%     }
           } %>
        </tbody>
    </table>

    <div class="d-flex gap-2">
        <a class="btn btn-dark" href="<%= request.getContextPath() %>/standings?tournamentId=<%= tournament.getId() %>">Voir classement</a>
        <a class="btn btn-secondary" href="<%= request.getContextPath() %>/teams?tournamentId=<%= tournament.getId() %>">Retour equipes</a>
    </div>
</div>
</body>
</html>
