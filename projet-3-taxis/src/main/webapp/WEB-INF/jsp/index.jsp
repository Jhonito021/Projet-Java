<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.projetsimple.taxis.model.Driver" %>
<%@ page import="com.projetsimple.taxis.model.Vehicle" %>
<%@ page import="com.projetsimple.taxis.model.Ride" %>
<%
List<Driver> drivers = (List<Driver>) request.getAttribute("drivers");
List<Vehicle> vehicles = (List<Vehicle>) request.getAttribute("vehicles");
List<Ride> rides = (List<Ride>) request.getAttribute("rides");
Map<String, Object> stats = (Map<String, Object>) request.getAttribute("stats");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestion flotte taxis</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container py-4">
    <h1 class="h3 mb-3">🚖 Projet 3 - Flotte de taxis</h1>

    <div class="row mb-4 g-3">
        <div class="col-md-3">
            <div class="card stats-card">
                <div class="card-body">
                    CA total
                    <strong><%= stats.get("revenue") %> Ar</strong>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card stats-card">
                <div class="card-body">
                    Commission
                    <strong><%= stats.get("companyRevenue") %> Ar</strong>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card stats-card">
                <div class="card-body">
                    Courses terminées
                    <strong><%= stats.get("completed") %></strong>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card stats-card">
                <div class="card-body">
                    Courses annulées
                    <strong><%= stats.get("cancelled") %></strong>
                </div>
            </div>
        </div>
    </div>

    <div class="row g-3 mb-4">
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <h2 class="h6 mb-3">👨‍✈️ Ajouter chauffeur</h2>
                    <form method="post" action="<%= request.getContextPath() %>/drivers">
                        <input class="form-control mb-2" name="fullName" placeholder="Nom complet" required>
                        <input class="form-control mb-2" name="phone" placeholder="Téléphone" required>
                        <input class="form-control mb-2" name="licenseNumber" placeholder="Permis" required>
                        <button class="btn btn-primary btn-sm w-100">Ajouter</button>
                    </form>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <h2 class="h6 mb-3">🚗 Ajouter véhicule</h2>
                    <form method="post" action="<%= request.getContextPath() %>/vehicles">
                        <input class="form-control mb-2" name="brandModel" placeholder="Marque / modèle" required>
                        <input class="form-control mb-2" name="plateNumber" placeholder="Immatriculation" required>
                        <input class="form-control mb-2" type="number" min="0" name="mileage" placeholder="Kilométrage" required>
                        <button class="btn btn-primary btn-sm w-100">Ajouter</button>
                    </form>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <h2 class="h6 mb-3">✨ Nouvelle course</h2>
                    <form method="post" action="<%= request.getContextPath() %>/rides">
                        <input type="hidden" name="action" value="CREATE">
                        <input class="form-control mb-2" name="pickup" placeholder="Départ" required>
                        <input class="form-control mb-2" name="destination" placeholder="Destination" required>
                        <input class="form-control mb-2" type="number" step="0.1" min="0" name="distanceKm" placeholder="Distance km" required>
                        <input class="form-control mb-2" type="number" min="0" name="waitMinutes" placeholder="Attente (min)" required>
                        <input class="form-control mb-2" type="number" step="0.1" min="0" name="extraFees" placeholder="Frais supplémentaires" required>
                        <button class="btn btn-success btn-sm w-100">Créer</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="row g-3 mb-4">
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h2 class="h5 mb-3">👥 Chauffeurs</h2>
                    <div class="table-responsive">
                        <table class="table table-sm table-bordered">
                            <thead>
                                <tr><th>Nom</th><th>Téléphone</th><th>Permis</th><th>Statut</th></tr>
                            </thead>
                            <tbody>
                                <% for (Driver d : drivers) { %>
                                <tr>
                                    <td><%= d.getFullName() %></td>
                                    <td><%= d.getPhone() %></td>
                                    <td><%= d.getLicenseNumber() %></td>
                                    <td>
                                        <span class="badge-status <%= "ACTIF".equals(d.getStatus()) ? "badge-active" : "badge-inactive" %>">
                                            <%= d.getStatus() %>
                                        </span>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h2 class="h5 mb-3">🚘 Véhicules</h2>
                    <div class="table-responsive">
                        <table class="table table-sm table-bordered">
                            <thead>
                                <tr><th>Modèle</th><th>Plaque</th><th>KM</th><th>Statut</th></tr>
                            </thead>
                            <tbody>
                                <% for (Vehicle v : vehicles) { %>
                                <tr>
                                    <td><%= v.getBrandModel() %></td>
                                    <td><%= v.getPlateNumber() %></td>
                                    <td><%= v.getMileage() %> km</td>
                                    <td>
                                        <span class="badge-status <%= "DISPONIBLE".equals(v.getStatus()) ? "badge-active" : "badge-inactive" %>">
                                            <%= v.getStatus() %>
                                        </span>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="card">
        <div class="card-body">
            <h2 class="h5 mb-3">📋 Historique des courses</h2>
            <div class="table-responsive">
                <table class="table table-bordered align-middle">
                    <thead>
                        <tr>
                            <th>ID</th><th>Trajet</th><th>Statut</th><th>Prix</th><th>Chauffeur</th><th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Ride r : rides) { %>
                        <tr>
                            <td>#<%= r.getId() %></td>
                            <td><%= r.getPickup() %> → <%= r.getDestination() %></td>
                            <td>
                                <span class="badge-status 
                                    <%= "TERMINEE".equals(r.getStatus()) ? "badge-active" : 
                                       ("EN_COURS".equals(r.getStatus()) ? "badge-pending" : "badge-inactive") %>">
                                    <%= r.getStatus() %>
                                </span>
                            </td>
                            <td><strong><%= r.getTotalPrice() %></strong> Ar</td>
                            <td><%= r.getDriverId() == null ? "Non assigné" : "Chauffeur #" + r.getDriverId() %></td>
                            <td>
                                <% if ("ASSIGNEE".equals(r.getStatus())) { %>
                                <form method="post" action="<%= request.getContextPath() %>/rides" class="d-inline">
                                    <input type="hidden" name="action" value="START">
                                    <input type="hidden" name="rideId" value="<%= r.getId() %>">
                                    <button class="btn btn-primary btn-sm">▶ Démarrer</button>
                                </form>
                                <% } else if ("EN_COURS".equals(r.getStatus())) { %>
                                <form method="post" action="<%= request.getContextPath() %>/rides" class="d-inline">
                                    <input type="hidden" name="action" value="FINISH">
                                    <input type="hidden" name="rideId" value="<%= r.getId() %>">
                                    <button class="btn btn-success btn-sm">✅ Terminer</button>
                                </form>
                                <% } else { %>
                                <span class="text-light">-</span>
                                <% } %>
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