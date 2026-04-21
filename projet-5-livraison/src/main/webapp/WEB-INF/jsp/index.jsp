<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.projetsimple.livraison.model.DeliveryPerson" %>
<%@ page import="com.projetsimple.livraison.model.DeliveryOrder" %>
<%
List<DeliveryPerson> people = (List<DeliveryPerson>) request.getAttribute("people");
List<DeliveryOrder> orders = (List<DeliveryOrder>) request.getAttribute("orders");
Map<String, Object> stats = (Map<String, Object>) request.getAttribute("stats");
String flash = (String) session.getAttribute("flash");
if (flash != null) session.removeAttribute("flash");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Service de livraison</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4">
    <h1 class="h3">Projet 5 - Service de livraison</h1>
    <% if (flash != null) { %><div class="alert alert-warning"><%= flash %></div><% } %>

    <div class="row mb-3">
        <div class="col-md-4"><div class="card card-body">Revenu total: <strong><%= stats.get("totalRevenue") %> Ar</strong></div></div>
        <div class="col-md-4"><div class="card card-body">Livrees: <strong><%= stats.get("delivered") %></strong></div></div>
        <div class="col-md-4"><div class="card card-body">Annulees: <strong><%= stats.get("cancelled") %></strong></div></div>
    </div>

    <div class="row g-3">
        <div class="col-md-4">
            <form class="card card-body" method="post" action="<%= request.getContextPath() %>/delivery">
                <h2 class="h6">Ajouter livreur</h2>
                <input type="hidden" name="action" value="ADD_PERSON">
                <input class="form-control mb-2" name="fullName" placeholder="Nom" required>
                <input class="form-control mb-2" name="phone" placeholder="Telephone" required>
                <button class="btn btn-primary btn-sm">Ajouter</button>
            </form>
        </div>
        <div class="col-md-8">
            <form class="card card-body" method="post" action="<%= request.getContextPath() %>/delivery">
                <h2 class="h6">Nouvelle commande</h2>
                <input type="hidden" name="action" value="CREATE_ORDER">
                <div class="row g-2">
                    <div class="col-md-4"><input class="form-control" name="clientName" placeholder="Client" required></div>
                    <div class="col-md-4"><input class="form-control" name="pickupAddress" placeholder="Pickup" required></div>
                    <div class="col-md-4"><input class="form-control" name="deliveryAddress" placeholder="Destination" required></div>
                    <div class="col-md-3"><input type="number" step="0.1" min="0" class="form-control" name="packageWeight" placeholder="Poids" required></div>
                    <div class="col-md-3"><input class="form-control" name="packageSize" placeholder="Taille" required></div>
                    <div class="col-md-3"><input type="number" step="0.1" min="0" class="form-control" name="distanceKm" placeholder="Distance km" required></div>
                    <div class="col-md-3"><input type="number" step="0.1" min="0" class="form-control" name="extraFees" placeholder="Frais supp" required></div>
                </div>
                <div class="mt-2"><button class="btn btn-success btn-sm">Creer commande</button></div>
            </form>
        </div>
    </div>

    <div class="row mt-3">
        <div class="col-md-4">
            <h2 class="h6">Livreurs</h2>
            <table class="table table-sm table-bordered bg-white">
                <thead><tr><th>Nom</th><th>Tel</th><th>Statut</th></tr></thead>
                <tbody><% for (DeliveryPerson p : people) { %><tr><td><%= p.getFullName() %></td><td><%= p.getPhone() %></td><td><%= p.getStatus() %></td></tr><% } %></tbody>
            </table>
        </div>
        <div class="col-md-8">
            <h2 class="h6">Commandes</h2>
            <table class="table table-sm table-bordered bg-white align-middle">
                <thead><tr><th>ID</th><th>Client</th><th>Trajet</th><th>Statut</th><th>Prix</th><th>Livreur</th><th>Action</th></tr></thead>
                <tbody>
                <% for (DeliveryOrder o : orders) { %>
                <tr>
                    <td><%= o.getId() %></td>
                    <td><%= o.getClientName() %></td>
                    <td><%= o.getPickupAddress() %> -> <%= o.getDeliveryAddress() %></td>
                    <td><%= o.getStatus() %></td>
                    <td><%= o.getPrice() %> Ar</td>
                    <td><%= o.getDeliveryPersonId() == null ? "-" : o.getDeliveryPersonId() %></td>
                    <td>
                        <% if ("ASSIGNEE".equals(o.getStatus())) { %>
                        <form method="post" action="<%= request.getContextPath() %>/delivery" class="d-inline">
                            <input type="hidden" name="action" value="START"><input type="hidden" name="orderId" value="<%= o.getId() %>">
                            <button class="btn btn-sm btn-primary">Demarrer</button>
                        </form>
                        <% } else if ("EN_COURS".equals(o.getStatus())) { %>
                        <form method="post" action="<%= request.getContextPath() %>/delivery" class="d-inline">
                            <input type="hidden" name="action" value="DELIVER"><input type="hidden" name="orderId" value="<%= o.getId() %>">
                            <button class="btn btn-sm btn-success">Livrer</button>
                        </form>
                        <% } %>
                        <% if (!"LIVREE".equals(o.getStatus())) { %>
                        <form method="post" action="<%= request.getContextPath() %>/delivery" class="d-inline">
                            <input type="hidden" name="action" value="CANCEL"><input type="hidden" name="orderId" value="<%= o.getId() %>">
                            <button class="btn btn-sm btn-danger">Annuler</button>
                        </form>
                        <% } %>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
