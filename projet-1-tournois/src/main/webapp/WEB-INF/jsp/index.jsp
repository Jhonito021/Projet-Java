<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.projetsimple.model.Tournament" %>
<%
    List<Tournament> tournaments = (List<Tournament>) request.getAttribute("tournaments");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion de tournois | Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="custom-container">
    <!-- Header avec style modernisé -->
    <div class="dashboard-header d-flex justify-content-between align-items-center flex-wrap">
        <h1>
            <i class="fas fa-trophy"></i>
            Tableau de bord des tournois
        </h1>
        <a class="btn btn-primary-custom" href="${pageContext.request.contextPath}/tournaments">
            <i class="fas fa-plus-circle"></i> Nouveau tournoi
        </a>
    </div>

    <!-- Tableau des tournois -->
    <div class="tournament-table">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th><i class="fas fa-flag-checkered me-1"></i> Nom</th>
                    <th><i class="fas fa-futbol me-1"></i> Sport</th>
                    <th><i class="fas fa-tag me-1"></i> Type</th>
                    <th><i class="fas fa-map-marker-alt me-1"></i> Lieu</th>
                    <th><i class="fas fa-calendar-alt me-1"></i> Dates</th>
                    <th><i class="fas fa-cog me-1"></i> Actions</th>
                </tr>
            </thead>
            <tbody>
            <% if (tournaments != null && !tournaments.isEmpty()) {
                   for (Tournament t : tournaments) { 
                       String typeClass = "single".equalsIgnoreCase(t.getType()) ? "badge-single" : "badge-double";
                       String typeIcon = "single".equalsIgnoreCase(t.getType()) ? "fas fa-user" : "fas fa-users";
            %>
                <tr>
                    <td class="fw-semibold">
                        <i class="fas fa-trophy me-2" style="color: var(--secondary-color);"></i> 
                        <%= t.getName() %>
                    </td>
                    <td><%= t.getSport() %></td>
                    <td>
                        <span class="badge-type <%= typeClass %>">
                            <i class="<%= typeIcon %> me-1"></i> <%= t.getType() %>
                        </span>
                    </td>
                    <td>
                        <i class="fas fa-location-dot me-1" style="color: var(--text-light);"></i> 
                        <%= t.getLocation() %>
                    </td>
                    <td>
                        <i class="far fa-calendar me-1"></i> 
                        <%= t.getStartDate() %> 
                        <i class="fas fa-arrow-right mx-1"></i> 
                        <%= t.getEndDate() %>
                    </td>
                    <td>
                        <div class="action-buttons">
                            <a class="btn-action btn-teams" 
                               href="${pageContext.request.contextPath}/teams?tournamentId=<%= t.getId() %>">
                                <i class="fas fa-users"></i> Equipes
                            </a>
                            <a class="btn-action btn-matches" 
                               href="${pageContext.request.contextPath}/matches?tournamentId=<%= t.getId() %>">
                                <i class="fas fa-clock"></i> Matchs
                            </a>
                            <a class="btn-action btn-standing" 
                               href="${pageContext.request.contextPath}/standings?tournamentId=<%= t.getId() %>">
                                <i class="fas fa-chart-line"></i> Classement
                            </a>
                        </div>
                    </td>
                </tr>
            <%     }
               } else { %>
                <tr>
                    <td colspan="6" class="empty-state">
                        <i class="fas fa-database"></i>
                        <p class="mb-0">Aucun tournoi trouvé</p>
                        <small class="text-muted">Cliquez sur "Nouveau tournoi" pour commencer</small>
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>