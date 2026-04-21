<%@ page import="java.util.List" %>
<%@ page import="com.projetsimple.model.StandingRow" %>
<%@ page import="com.projetsimple.model.Tournament" %>
<%
    Tournament tournament = (Tournament) request.getAttribute("tournament");
    List<StandingRow> standings = (List<StandingRow>) request.getAttribute("standings");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Classement</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4">
    <h1 class="h4">Classement - <%= tournament != null ? tournament.getName() : "" %></h1>

    <table class="table table-striped table-bordered bg-white">
        <thead>
        <tr>
            <th>#</th><th>Equipe</th><th>J</th><th>G</th><th>N</th><th>P</th><th>BP</th><th>BC</th><th>Diff</th><th>Pts</th>
        </tr>
        </thead>
        <tbody>
        <% if (standings != null) {
               int index = 1;
               for (StandingRow row : standings) { %>
        <tr>
            <td><%= index++ %></td>
            <td><%= row.getTeamName() %></td>
            <td><%= row.getPlayed() %></td>
            <td><%= row.getWins() %></td>
            <td><%= row.getDraws() %></td>
            <td><%= row.getLosses() %></td>
            <td><%= row.getGoalsFor() %></td>
            <td><%= row.getGoalsAgainst() %></td>
            <td><%= row.getGoalDifference() %></td>
            <td><strong><%= row.getPoints() %></strong></td>
        </tr>
        <%     }
           } %>
        </tbody>
    </table>
    <a class="btn btn-secondary" href="<%= request.getContextPath() %>/matches?tournamentId=<%= tournament.getId() %>">Retour matchs</a>
</div>
</body>
</html>
