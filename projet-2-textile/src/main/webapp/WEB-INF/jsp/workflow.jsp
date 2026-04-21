<%@ page import="java.util.List" %>
<%@ page import="com.projetsimple.model.TextileOrder" %>
<%@ page import="com.projetsimple.model.ProductionStep" %>
<%
    TextileOrder order = (TextileOrder) request.getAttribute("order");
    List<ProductionStep> steps = (List<ProductionStep>) request.getAttribute("steps");
    String delayInfo = (String) request.getAttribute("delayInfo");
    String errorMessage = (String) session.getAttribute("errorMessage");
    if (errorMessage != null) {
        session.removeAttribute("errorMessage");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Workflow commande</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<div class="container py-4">
    <div class="card">
        <div class="card-header">
            <h1 class="h4 mb-0">Workflow commande #<%= order.getId() %> - <%= order.getClientName() %></h1>
        </div>
        <div class="card-body">
            <div class="mb-3">
                <p class="mb-1">Statut global: <strong><span class="badge" id="globalStatusBadge"><%= order.getStatus() %></span></strong></p>
                <p class="text-light"><%= delayInfo %></p>
            </div>
            
            <% if (errorMessage != null) { %>
            <div class="alert alert-danger"><%= errorMessage %></div>
            <% } %>

            <div class="table-responsive">
                <table class="table table-bordered align-middle">
                    <thead>
                        <tr>
                            <th>Etape</th>
                            <th>Responsable</th>
                            <th>Statut</th>
                            <th>Debut</th>
                            <th>Fin</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <% for (ProductionStep step : steps) { %>
                        <tr>
                            <td><strong><%= step.getStepName() %></strong></td>
                            <td><%= step.getResponsible() == null ? "-" : step.getResponsible() %></td>
                            <td>
                                <% if ("PENDING".equals(step.getStatus())) { %>
                                    <span class="badge bg-warning text-dark">En attente</span>
                                <% } else if ("IN_PROGRESS".equals(step.getStatus())) { %>
                                    <span class="badge bg-info">En cours</span>
                                <% } else if ("COMPLETED".equals(step.getStatus())) { %>
                                    <span class="badge bg-success">Terminée</span>
                                <% } else { %>
                                    <span class="badge bg-secondary"><%= step.getStatus() %></span>
                                <% } %>
                            </td>
                            <td><%= step.getStartedAt() == null ? "-" : step.getStartedAt() %></td>
                            <td><%= step.getEndedAt() == null ? "-" : step.getEndedAt() %></td>
                            <td>
                                <% if ("PENDING".equals(step.getStatus())) { %>
                                <form method="post" action="<%= request.getContextPath() %>/workflow" class="d-flex gap-2">
                                    <input type="hidden" name="orderId" value="<%= order.getId() %>">
                                    <input type="hidden" name="stepId" value="<%= step.getId() %>">
                                    <input type="hidden" name="action" value="START">
                                    <input class="form-control form-control-sm" name="responsible" placeholder="Responsable" required>
                                    <button class="btn btn-sm btn-primary" type="submit">Démarrer</button>
                                </form>
                                <% } else if ("IN_PROGRESS".equals(step.getStatus())) { %>
                                <form method="post" action="<%= request.getContextPath() %>/workflow" class="d-flex gap-2">
                                    <input type="hidden" name="orderId" value="<%= order.getId() %>">
                                    <input type="hidden" name="stepId" value="<%= step.getId() %>">
                                    <input type="hidden" name="action" value="COMPLETE">
                                    <input class="form-control form-control-sm" name="notes" placeholder="Remarques">
                                    <button class="btn btn-sm btn-success" type="submit">Valider</button>
                                </form>
                                <% } else { %>
                                <span class="badge bg-success">Terminée</span>
                                <% } %>
                            </td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>

            <div class="mt-3">
                <a class="btn btn-outline-primary" href="<%= request.getContextPath() %>/">Retour</a>
            </div>
        </div>
    </div>
</div>

<script>
    // Script optionnel pour styliser le badge du statut global
    document.addEventListener('DOMContentLoaded', function() {
        const statusBadge = document.getElementById('globalStatusBadge');
        if (statusBadge) {
            const status = statusBadge.textContent.trim();
            if (status === 'PENDING' || status === 'EN_ATTENTE') {
                statusBadge.className = 'badge bg-warning text-dark';
            } else if (status === 'IN_PROGRESS' || status === 'EN_COURS') {
                statusBadge.className = 'badge bg-info';
            } else if (status === 'COMPLETED' || status === 'TERMINE') {
                statusBadge.className = 'badge bg-success';
            } else {
                statusBadge.className = 'badge bg-secondary';
            }
        }
    });
</script>
</body>
</html>