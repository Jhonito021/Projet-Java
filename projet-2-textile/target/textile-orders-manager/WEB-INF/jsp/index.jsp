<%@ page import="java.util.List" %>
<%@ page import="com.projetsimple.model.TextileOrder" %>
<%
    List<TextileOrder> orders = (List<TextileOrder>) request.getAttribute("orders");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestion commandes textile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h1 class="h3">Commandes textile</h1>
        <a class="btn btn-primary" href="<%= request.getContextPath() %>/orders">Nouvelle commande</a>
    </div>

    <table class="table table-bordered bg-white">
        <thead>
        <tr><th>ID</th><th>Client</th><th>Article</th><th>Quantite</th><th>Livraison prevue</th><th>Statut</th><th>Action</th></tr>
        </thead>
        <tbody>
        <% if (orders != null) {
            for (TextileOrder order : orders) { %>
        <tr>
            <td><%= order.getId() %></td>
            <td><%= order.getClientName() %></td>
            <td><%= order.getArticleType() %></td>
            <td><%= order.getQuantity() %></td>
            <td><%= order.getExpectedDeliveryDate() %></td>
            <td><%= order.getStatus() %></td>
            <td><a class="btn btn-sm btn-outline-primary" href="<%= request.getContextPath() %>/workflow?orderId=<%= order.getId() %>">Workflow</a></td>
        </tr>
        <% }} %>
        </tbody>
    </table>
</div>
</body>
</html>
