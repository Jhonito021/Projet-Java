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
</head>
<body class="bg-light">
<div class="container py-4">
    <h1 class="h4">Workflow commande #<%= order.getId() %> - <%= order.getClientName() %></h1>
    <p class="text-muted mb-1">Statut global: <strong><%= order.getStatus() %></strong></p>
    <p class="text-muted"><%= delayInfo %></p>
    <% if (errorMessage != null) { %>
    <div class="alert alert-danger"><%= errorMessage %></div>
    <% } %>

    <table class="table table-bordered bg-white align-middle">
        <thead>
        <tr><th>Etape</th><th>Responsable</th><th>Statut</th><th>Debut</th><th>Fin</th><th>Action</th></tr>
        </thead>
        <tbody>
        <% for (ProductionStep step : steps) { %>
        <tr>
            <td><%= step.getStepName() %></td>
            <td><%= step.getResponsible() == null ? "-" : step.getResponsible() %></td>
            <td><%= step.getStatus() %></td>
            <td><%= step.getStartedAt() == null ? "-" : step.getStartedAt() %></td>
            <td><%= step.getEndedAt() == null ? "-" : step.getEndedAt() %></td>
            <td>
                <% if ("PENDING".equals(step.getStatus())) { %>
                <form method="post" action="<%= request.getContextPath() %>/workflow" class="d-flex gap-2">
                    <input type="hidden" name="orderId" value="<%= order.getId() %>">
                    <input type="hidden" name="stepId" value="<%= step.getId() %>">
                    <input type="hidden" name="action" value="START">
                    <input class="form-control form-control-sm" name="responsible" placeholder="Responsable" required>
                    <button class="btn btn-sm btn-primary" type="submit">Demarrer</button>
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
                <span class="badge text-bg-success">Terminee</span>
                <% } %>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <a class="btn btn-secondary" href="<%= request.getContextPath() %>/">Retour</a>
</div>
</body>
</html>
