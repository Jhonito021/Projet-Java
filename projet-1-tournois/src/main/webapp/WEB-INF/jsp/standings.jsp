<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.projetsimple.model.StandingRow" %>
<%@ page import="com.projetsimple.model.Tournament" %>
<%
    Tournament tournament = (Tournament) request.getAttribute("tournament");
    List<StandingRow> standings = (List<StandingRow>) request.getAttribute("standings");
    
    // Calculer les statistiques globales
    int totalGoals = 0;
    int totalMatches = 0;
    int bestAttack = 0;
    int bestDefense = Integer.MAX_VALUE;
    String bestAttackTeam = "";
    String bestDefenseTeam = "";
    
    if (standings != null) {
        totalMatches = standings.stream().mapToInt(StandingRow::getPlayed).sum() / 2;
        for (StandingRow row : standings) {
            totalGoals += row.getGoalsFor();
            if (row.getGoalsFor() > bestAttack) {
                bestAttack = row.getGoalsFor();
                bestAttackTeam = row.getTeamName();
            }
            if (row.getGoalsAgainst() < bestDefense) {
                bestDefense = row.getGoalsAgainst();
                bestDefenseTeam = row.getTeamName();
            }
        }
        if (bestDefense == Integer.MAX_VALUE) bestDefense = 0;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Classement | Gestion de tournois</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="custom-container">
    <!-- Header -->
    <div class="standing-header">
        <h1>
            <i class="fas fa-chart-line"></i>
            Classement - <%= tournament != null ? tournament.getName() : "Tournoi" %>
        </h1>
        <p>
            <i class="fas fa-info-circle"></i>
            Classement général des équipes basé sur les résultats des matchs
        </p>
    </div>

    <!-- Statistiques globales -->
    <% if (standings != null && !standings.isEmpty()) { %>
    <div class="stats-grid">
        <div class="stat-card">
            <i class="fas fa-futbol"></i>
            <div class="stat-value"><%= totalGoals %></div>
            <div class="stat-label">Buts marqués</div>
        </div>
        <div class="stat-card">
            <i class="fas fa-calendar-alt"></i>
            <div class="stat-value"><%= totalMatches %></div>
            <div class="stat-label">Matchs joués</div>
        </div>
        <div class="stat-card">
            <i class="fas fa-rocket"></i>
            <div class="stat-value"><%= bestAttack %></div>
            <div class="stat-label">Meilleure attaque<br><small><%= bestAttackTeam %></small></div>
        </div>
        <div class="stat-card">
            <i class="fas fa-shield-alt"></i>
            <div class="stat-value"><%= bestDefense %></div>
            <div class="stat-label">Meilleure défense<br><small><%= bestDefenseTeam %></small></div>
        </div>
    </div>
    <% } %>

    <!-- Légende -->
    <div class="legend">
        <div class="legend-item">
            <div class="legend-color gold"></div>
            <span>🥇 Champion</span>
        </div>
        <div class="legend-item">
            <div class="legend-color silver"></div>
            <span>🥈 Vice-champion</span>
        </div>
        <div class="legend-item">
            <div class="legend-color bronze"></div>
            <span>🥉 Troisième place</span>
        </div>
        <div class="legend-item">
            <i class="fas fa-chart-simple"></i>
            <span>Diff = Différence de buts (BP - BC)</span>
        </div>
        <div class="legend-item">
            <i class="fas fa-trophy"></i>
            <span>Pts = Victoire (3pts) | Nul (1pt) | Défaite (0pt)</span>
        </div>
    </div>

    <!-- Tableau de classement -->
    <div class="standing-table">
        <table class="table">
            <thead>
                <tr>
                    <th><i class="fas fa-hashtag"></i> #</th>
                    <th><i class="fas fa-users"></i> Équipe</th>
                    <th><i class="fas fa-chart-simple"></i> J</th>
                    <th><i class="fas fa-check-circle"></i> G</th>
                    <th><i class="fas fa-equals"></i> N</th>
                    <th><i class="fas fa-times-circle"></i> P</th>
                    <th><i class="fas fa-futbol"></i> BP</th>
                    <th><i class="fas fa-shield-alt"></i> BC</th>
                    <th><i class="fas fa-arrows-left-right"></i> Diff</th>
                    <th><i class="fas fa-trophy"></i> Pts</th>
                </tr>
            </thead>
            <tbody>
            <% if (standings != null && !standings.isEmpty()) {
                   int index = 1;
                   for (StandingRow row : standings) {
                       String rowClass = "";
                       String rankClass = "";
                       if (index == 1) {
                           rowClass = "first-place";
                           rankClass = "rank-1";
                       } else if (index == 2) {
                           rankClass = "rank-2";
                       } else if (index == 3) {
                           rankClass = "rank-3";
                       }
                       
                       // Déterminer l'icône de l'équipe
                       String teamIcon = "fas fa-shield-alt";
                       if (index == 1) teamIcon = "fas fa-crown";
                       else if (index == 2) teamIcon = "fas fa-medal";
                       else if (index == 3) teamIcon = "fas fa-medal";
            %>
                <tr class="<%= rowClass %>">
                    <td class="rank-cell <%= rankClass %>">
                        <%= index++ %>
                        <% if (index-1 == 1) { %>
                            <i class="fas fa-crown ms-1" style="color: #ffd700; font-size: 0.8rem;"></i>
                        <% } else if (index-1 == 2) { %>
                            <i class="fas fa-medal ms-1" style="color: #c0c0c0;"></i>
                        <% } else if (index-1 == 3) { %>
                            <i class="fas fa-medal ms-1" style="color: #cd7f32;"></i>
                        <% } %>
                    </td>
                    <td class="text-start">
                        <div class="team-name-cell">
                            <div class="team-icon">
                                <i class="<%= teamIcon %>"></i>
                            </div>
                            <span><%= row.getTeamName() %></span>
                        </div>
                    </td>
                    <td class="stat-number"><%= row.getPlayed() %></td>
                    <td class="stat-number"><%= row.getWins() %></td>
                    <td class="stat-number"><%= row.getDraws() %></td>
                    <td class="stat-number"><%= row.getLosses() %></td>
                    <td class="stat-number"><%= row.getGoalsFor() %></td>
                    <td class="stat-number"><%= row.getGoalsAgainst() %></td>
                    <td class="stat-number <%= row.getGoalDifference() >= 0 ? "text-success" : "text-danger" %>">
                        <%= row.getGoalDifference() >= 0 ? "+" : "" %><%= row.getGoalDifference() %>
                    </td>
                    <td class="points-cell">
                        <strong><%= row.getPoints() %></strong>
                    </td>
                </tr>
            <%     }
               } else { %>
                <tr>
                    <td colspan="10" class="empty-state">
                        <i class="fas fa-chart-simple"></i>
                        <p class="mb-0">Aucun classement disponible</p>
                        <small class="text-muted">Les matchs doivent être joués pour générer le classement</small>
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>
    </div>

    <!-- Boutons de navigation -->
    <div class="navigation-buttons">
        <a class="btn-nav btn-back" href="${pageContext.request.contextPath}/matches?tournamentId=<%= tournament.getId() %>">
            <i class="fas fa-calendar-alt"></i> Retour aux matchs
        </a>
        <a class="btn-nav btn-standings" href="${pageContext.request.contextPath}/teams?tournamentId=<%= tournament.getId() %>">
            <i class="fas fa-users"></i> Voir les équipes
        </a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>