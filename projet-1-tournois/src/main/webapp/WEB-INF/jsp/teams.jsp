<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Équipes | Gestion de tournois</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="custom-container">
    <!-- Header -->
    <div class="teams-header">
        <h1>
            <i class="fas fa-users"></i>
            Équipes - <%= tournament != null ? tournament.getName() : "Tournoi" %>
        </h1>
        <p>
            <i class="fas fa-info-circle"></i>
            Gérez les équipes participantes au tournoi
        </p>
    </div>

    <!-- Message d'information -->
    <div class="info-message">
        <i class="fas fa-lightbulb"></i>
        <p>
            <strong>Astuce :</strong> Ajoutez au moins 2 équipes pour générer les matchs. 
            Les équipes sont automatiquement prises en compte dans le classement.
        </p>
    </div>

    <!-- Formulaire d'ajout d'équipe -->
    <div class="team-form">
        <div class="team-form-title">
            <i class="fas fa-plus-circle"></i>
            <h5>Ajouter une nouvelle équipe</h5>
        </div>
        <form method="post" action="${pageContext.request.contextPath}/teams">
            <input type="hidden" name="tournamentId" value="<%= tournament.getId() %>">
            <div class="row g-3">
                <div class="col-md-5">
                    <input type="text" class="form-input form-control" name="name" 
                           placeholder="Nom de l'équipe" required>
                </div>
                <div class="col-md-4">
                    <input type="text" class="form-input form-control" name="logoUrl" 
                           placeholder="URL du logo (optionnel)">
                </div>
                <div class="col-md-3">
                    <input type="text" class="form-input form-control" name="contact" 
                           placeholder="Contact (optionnel)">
                </div>
            </div>
            <div class="mt-3">
                <button class="btn-submit" type="submit">
                    <i class="fas fa-save"></i> Ajouter l'équipe
                </button>
            </div>
        </form>
    </div>

    <!-- Statistique du nombre d'équipes -->
    <% if (teams != null && !teams.isEmpty()) { %>
    <div class="mb-3">
        <span class="team-count">
            <i class="fas fa-users"></i> 
            <%= teams.size() %> équipe(s) inscrite(s)
        </span>
    </div>
    <% } %>

    <!-- Tableau des équipes -->
    <div class="teams-table">
        <table class="table">
            <thead>
                <tr>
                    <th><i class="fas fa-hashtag"></i> #</th>
                    <th><i class="fas fa-image"></i> Logo</th>
                    <th><i class="fas fa-tag"></i> Nom</th>
                    <th><i class="fas fa-envelope"></i> Contact</th>
                    <%-- <th><i class="fas fa-cog"></i> Actions</th> --%>
                </tr>
            </thead>
            <tbody>
            <% if (teams != null && !teams.isEmpty()) {
                   int index = 1;
                   for (Team team : teams) { 
                       boolean hasLogo = team.getLogoUrl() != null && !team.getLogoUrl().trim().isEmpty();
            %>
                <tr>
                    <td class="fw-bold">
                        <%= index++ %>
                    </td>
                    <td>
                        <% if (hasLogo) { %>
                            <div class="team-logo">
                                <img src="<%= team.getLogoUrl() %>" alt="<%= team.getName() %>" 
                                     onerror="this.onerror=null; this.parentElement.innerHTML='<div class=\'logo-placeholder\'><i class=\'fas fa-shield-alt\'></i></div>';">
                            </div>
                        <% } else { %>
                            <div class="logo-placeholder">
                                <i class="fas fa-shield-alt"></i>
                            </div>
                        <% } %>
                    </td>
                    <td class="fw-semibold">
                        <i class="fas fa-trophy me-2" style="color: var(--secondary-color); font-size: 0.8rem;"></i>
                        <%= team.getName() %>
                    </td>
                    <td>
                        <% if (team.getContact() != null && !team.getContact().isEmpty()) { %>
                            <div class="contact-info">
                                <i class="fas fa-phone-alt"></i>
                                <span><%= team.getContact() %></span>
                            </div>
                        <% } else { %>
                            <span class="text-muted">Non renseigné</span>
                        <% } %>
                    </td>
                    <%-- 
                    <td class="team-actions">
                        <button class="btn-icon" onclick="editTeam('<%= team.getId() %>')" title="Modifier">
                            <i class="fas fa-edit"></i>
                        </button>
                        <button class="btn-icon delete" onclick="deleteTeam('<%= team.getId() %>')" title="Supprimer">
                            <i class="fas fa-trash-alt"></i>
                        </button>
                    </td>
                    --%>
                </tr>
            <%     }
               } else { %>
                <tr>
                    <td colspan="4" class="empty-teams">
                        <i class="fas fa-users-slash"></i>
                        <p class="mb-0">Aucune équipe inscrite</p>
                        <small>Ajoutez votre première équipe en utilisant le formulaire ci-dessus</small>
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>
    </div>

    <!-- Boutons de navigation -->
    <div class="navigation-buttons">
        <a class="btn-nav btn-standings" href="${pageContext.request.contextPath}/matches?tournamentId=<%= tournament.getId() %>">
            <i class="fas fa-calendar-alt"></i> Voir / générer les matchs
        </a>
        <a class="btn-nav btn-back" href="${pageContext.request.contextPath}/tournament-dashboard">
            <i class="fas fa-arrow-left"></i> Retour au tableau de bord
        </a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Fonctions pour les actions sur les équipes (optionnelles)
    function editTeam(teamId) {
        // Implémenter la modification d'équipe
        console.log('Edit team: ' + teamId);
        // window.location.href = '${pageContext.request.contextPath}/teams/edit?id=' + teamId;
    }
    
    function deleteTeam(teamId) {
        if (confirm('Êtes-vous sûr de vouloir supprimer cette équipe ?')) {
            console.log('Delete team: ' + teamId);
            // window.location.href = '${pageContext.request.contextPath}/teams/delete?id=' + teamId;
        }
    }
</script>
</body>
</html>