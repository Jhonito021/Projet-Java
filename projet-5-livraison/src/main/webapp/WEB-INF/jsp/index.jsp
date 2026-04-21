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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Service de livraison - Dashboard</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<div class="container">
    <h1 class="h3">🚚 Projet 5 - Service de livraison</h1>
    
    <% if (flash != null) { %>
        <div class="alert alert-warning">
            ⚠️ <%= flash %>
        </div>
    <% } %>

    <!-- Statistiques -->
    <div class="row mb-3">
        <div class="col-md-4">
            <div class="card card-body">
                💰 Revenu total<br>
                <strong><%= stats.get("totalRevenue") %> Ar</strong>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card card-body">
                ✅ Livrées<br>
                <strong><%= stats.get("delivered") %></strong>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card card-body">
                ❌ Annulées<br>
                <strong><%= stats.get("cancelled") %></strong>
            </div>
        </div>
    </div>

    <!-- Formulaires d'ajout -->
    <div class="row g-3">
        <div class="col-md-4">
            <form class="card card-body" method="post" action="<%= request.getContextPath() %>/delivery">
                <h2 class="h6">👤 Ajouter un livreur</h2>
                <input type="hidden" name="action" value="ADD_PERSON">
                <input class="form-control mb-2" type="text" name="fullName" placeholder="Nom complet" required>
                <input class="form-control mb-2" type="tel" name="phone" placeholder="Téléphone" required>
                <button class="btn btn-primary btn-sm">➕ Ajouter</button>
            </form>
        </div>
        <div class="col-md-8">
            <form class="card card-body" method="post" action="<%= request.getContextPath() %>/delivery">
                <h2 class="h6">📦 Nouvelle commande</h2>
                <input type="hidden" name="action" value="CREATE_ORDER">
                <div class="row g-2">
                    <div class="col-md-4">
                        <input class="form-control" type="text" name="clientName" placeholder="Nom du client" required>
                    </div>
                    <div class="col-md-4">
                        <input class="form-control" type="text" name="pickupAddress" placeholder="Adresse de retrait" required>
                    </div>
                    <div class="col-md-4">
                        <input class="form-control" type="text" name="deliveryAddress" placeholder="Adresse de livraison" required>
                    </div>
                    <div class="col-md-3">
                        <input type="number" step="0.1" min="0" class="form-control" name="packageWeight" placeholder="Poids (kg)" required>
                    </div>
                    <div class="col-md-3">
                        <input class="form-control" type="text" name="packageSize" placeholder="Taille (S/M/L/XL)" required>
                    </div>
                    <div class="col-md-3">
                        <input type="number" step="0.1" min="0" class="form-control" name="distanceKm" placeholder="Distance (km)" required>
                    </div>
                    <div class="col-md-3">
                        <input type="number" step="0.1" min="0" class="form-control" name="extraFees" placeholder="Frais supplémentaires" required>
                    </div>
                </div>
                <div class="mt-2">
                    <button class="btn btn-success btn-sm">🚀 Créer la commande</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Tableaux des données -->
    <div class="row mt-3">
        <div class="col-md-4">
            <h2 class="h6">👥 Liste des livreurs</h2>
            <div class="table-responsive">
                <table class="table table-sm table-bordered">
                    <thead>
                        <tr>
                            <th>Nom</th>
                            <th>Téléphone</th>
                            <th>Statut</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (DeliveryPerson p : people) { %>
                            <tr>
                                <td><%= p.getFullName() %></td>
                                <td><%= p.getPhone() %></td>
                                <td>
                                    <% if ("DISPONIBLE".equals(p.getStatus())) { %>
                                        <span style="color: #4caf50;">✓ Disponible</span>
                                    <% } else { %>
                                        <span style="color: #ff9800;">⏳ En livraison</span>
                                    <% } %>
                                </td>
                            </tr>
                        <% } %>
                        <% if (people.isEmpty()) { %>
                            <tr>
                                <td colspan="3" style="text-align: center; color: var(--text-light);">
                                    Aucun livreur enregistré
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="col-md-8">
            <h2 class="h6">📋 Commandes en cours</h2>
            <div class="table-responsive">
                <table class="table table-sm table-bordered align-middle">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Client</th>
                            <th>Trajet</th>
                            <th>Statut</th>
                            <th>Prix</th>
                            <th>Livreur</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (DeliveryOrder o : orders) { %>
                            <tr>
                                <td>#<%= o.getId() %></td>
                                <td><%= o.getClientName() %></td>
                                <td><%= o.getPickupAddress() %><br>→<br><%= o.getDeliveryAddress() %></td>
                                <td>
                                    <% if ("ASSIGNEE".equals(o.getStatus())) { %>
                                        <span style="color: #ff9800;">📌 Assignée</span>
                                    <% } else if ("EN_COURS".equals(o.getStatus())) { %>
                                        <span style="color: #2196f3;">🚚 En cours</span>
                                    <% } else if ("LIVREE".equals(o.getStatus())) { %>
                                        <span style="color: #4caf50;">✅ Livrée</span>
                                    <% } else if ("ANNULEE".equals(o.getStatus())) { %>
                                        <span style="color: #f44336;">❌ Annulée</span>
                                    <% } %>
                                </td>
                                <td><%= o.getPrice() %> Ar</td>
                                <td>
                                    <% if (o.getDeliveryPersonId() == null) { %>
                                        <span style="color: var(--text-light);">Non assigné</span>
                                    <% } else { %>
                                        Livreur #<%= o.getDeliveryPersonId() %>
                                    <% } %>
                                </td>
                                <td>
                                    <% if ("ASSIGNEE".equals(o.getStatus())) { %>
                                        <form method="post" action="<%= request.getContextPath() %>/delivery" class="d-inline">
                                            <input type="hidden" name="action" value="START">
                                            <input type="hidden" name="orderId" value="<%= o.getId() %>">
                                            <button class="btn btn-primary btn-sm">▶ Démarrer</button>
                                        </form>
                                    <% } else if ("EN_COURS".equals(o.getStatus())) { %>
                                        <form method="post" action="<%= request.getContextPath() %>/delivery" class="d-inline">
                                            <input type="hidden" name="action" value="DELIVER">
                                            <input type="hidden" name="orderId" value="<%= o.getId() %>">
                                            <button class="btn btn-success btn-sm">✓ Livrer</button>
                                        </form>
                                    <% } %>
                                    <% if (!"LIVREE".equals(o.getStatus()) && !"ANNULEE".equals(o.getStatus())) { %>
                                        <form method="post" action="<%= request.getContextPath() %>/delivery" class="d-inline">
                                            <input type="hidden" name="action" value="CANCEL">
                                            <input type="hidden" name="orderId" value="<%= o.getId() %>">
                                            <button class="btn btn-danger btn-sm" onclick="return confirm('Annuler cette commande ?')">✗ Annuler</button>
                                        </form>
                                    <% } %>
                                </td>
                            </tr>
                        <% } %>
                        <% if (orders.isEmpty()) { %>
                            <tr>
                                <td colspan="7" style="text-align: center; color: var(--text-light);">
                                    Aucune commande enregistrée
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>