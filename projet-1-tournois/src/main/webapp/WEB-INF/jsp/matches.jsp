<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Matchs | Gestion de tournois</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="custom-container">
    <!-- Header -->
    <div class="match-header">
        <h1>
            <i class="fas fa-calendar-alt"></i>
            Matchs - <%= tournament != null ? tournament.getName() : "Tournoi" %>
        </h1>
        <p class="text-muted-custom">
            <i class="fas fa-info-circle"></i>
            Le calendrier est généré automatiquement au premier affichage.
        </p>
    </div>

    <!-- Tableau des matchs -->
    <div class="match-table">
        <table class="table">
            <thead>
                <tr>
                    <th><i class="fas fa-flag-checkered me-1"></i> Phase</th>
                    <th><i class="fas fa-calendar-day me-1"></i> Date</th>
                    <th><i class="fas fa-map-marker-alt me-1"></i> Terrain</th>
                    <th><i class="fas fa-users me-1"></i> Affiche</th>
                    <th><i class="fas fa-chart-simple me-1"></i> Score</th>
                    <th><i class="fas fa-pen me-1"></i> Action</th>
                </tr>
            </thead>
            <tbody>
            <% if (matches != null && !matches.isEmpty()) {
                   for (Match match : matches) {
                       // Déterminer la classe du badge selon la phase
                       String stageClass = "stage-group";
                       String stageIcon = "fas fa-layer-group";
                       String stage = match.getStage();
                       
                       if (stage != null) {
                           if (stage.toLowerCase().contains("quart")) {
                               stageClass = "stage-quarter";
                               stageIcon = "fas fa-chart-line";
                           } else if (stage.toLowerCase().contains("demi") || stage.toLowerCase().contains("semi")) {
                               stageClass = "stage-semi";
                               stageIcon = "fas fa-chart-simple";
                           } else if (stage.toLowerCase().contains("final")) {
                               stageClass = "stage-final";
                               stageIcon = "fas fa-trophy";
                           }
                       }
            %>
                <tr>
                    <td>
                        <span class="badge-stage <%= stageClass %>">
                            <i class="<%= stageIcon %> me-1"></i> <%= match.getStage() %>
                        </span>
                    </td>
                    <td>
                        <i class="fas fa-clock me-1" style="color: var(--text-light);"></i>
                        <%= match.getScheduledAt() %>
                    </td>
                    <td>
                        <i class="fas fa-futbol me-1" style="color: var(--text-light);"></i>
                        Terrain <%= match.getFieldNumber() %>
                    </td>
                    <td>
                        <div class="match-fixture">
                            <span class="team-name">
                                <i class="fas fa-shield-alt"></i>
                                <%= teamNames.getOrDefault(match.getHomeTeamId(), "TBD") %>
                            </span>
                            <span class="vs">VS</span>
                            <span class="team-name">
                                <i class="fas fa-shield-alt"></i>
                                <%= teamNames.getOrDefault(match.getAwayTeamId(), "TBD") %>
                            </span>
                        </div>
                    </td>
                    <td>
                        <span class="score-display">
                            <%= match.getHomeScore() == null ? "-" : match.getHomeScore() %> 
                            <i class="fas fa-times" style="font-size: 0.8rem;"></i> 
                            <%= match.getAwayScore() == null ? "-" : match.getAwayScore() %>
                        </span>
                    </td>
                    <td>
                        <form method="post" action="${pageContext.request.contextPath}/matches" class="score-form">
                            <input type="hidden" name="tournamentId" value="<%= tournament.getId() %>">
                            <input type="hidden" name="matchId" value="<%= match.getId() %>">
                            <input type="number" class="score-input" min="0" name="homeScore" 
                                   placeholder="Dom." required>
                            <input type="number" class="score-input" min="0" name="awayScore" 
                                   placeholder="Ext." required>
                            <button class="btn-validate" type="submit">
                                <i class="fas fa-check-circle"></i> Valider
                            </button>
                        </form>
                    </td>
                </tr>
            <%     }
               } else { %>
                <tr>
                    <td colspan="6" class="empty-state">
                        <i class="fas fa-calendar-times"></i>
                        <p class="mb-0">Aucun match trouvé</p>
                        <small class="text-muted">Le calendrier sera généré automatiquement</small>
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>
    </div>

    <!-- Boutons de navigation -->
    <div class="navigation-buttons">
        <a class="btn-nav btn-standings" href="${pageContext.request.contextPath}/standings?tournamentId=<%= tournament.getId() %>">
            <i class="fas fa-chart-line"></i> Voir classement
        </a>
        <a class="btn-nav btn-back" href="${pageContext.request.contextPath}/teams?tournamentId=<%= tournament.getId() %>">
            <i class="fas fa-arrow-left"></i> Retour équipes
        </a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>