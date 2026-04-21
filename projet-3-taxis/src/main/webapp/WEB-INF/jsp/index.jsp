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
<body class="bg-light">
<div class="container py-4">
    <h1 class="h3 mb-3">Projet 3 - Flotte de taxis</h1>

    <div class="row mb-3">
        <div class="col-md-3"><div class="card card-body">CA total: <strong><%= stats.get("revenue") %> Ar</strong></div></div>
        <div class="col-md-3"><div class="card card-body">Commission: <strong><%= stats.get("companyRevenue") %> Ar</strong></div></div>
        <div class="col-md-3"><div class="card card-body">Courses terminees: <strong><%= stats.get("completed") %></strong></div></div>
        <div class="col-md-3"><div class="card card-body">Courses annulees: <strong><%= stats.get("cancelled") %></strong></div></div>
    </div>

    <div class="row g-3">
        <div class="col-md-4">
            <form class="card card-body" method="post" action="<%= request.getContextPath() %>/drivers">
                <h2 class="h6">Ajouter chauffeur</h2>
                <input class="form-control mb-2" name="fullName" placeholder="Nom complet" required>
                <input class="form-control mb-2" name="phone" placeholder="Telephone" required>
                <input class="form-control mb-2" name="licenseNumber" placeholder="Permis" required>
                <button class="btn btn-primary btn-sm">Ajouter</button>
            </form>
        </div>
        <div class="col-md-4">
            <form class="card card-body" method="post" action="<%= request.getContextPath() %>/vehicles">
                <h2 class="h6">Ajouter vehicule</h2>
                <input class="form-control mb-2" name="brandModel" placeholder="Marque / modele" required>
                <input class="form-control mb-2" name="plateNumber" placeholder="Immatriculation" required>
                <input class="form-control mb-2" type="number" min="0" name="mileage" placeholder="Kilometrage" required>
                <button class="btn btn-primary btn-sm">Ajouter</button>
            </form>
        </div>
        <div class="col-md-4">
            <form class="card card-body" method="post" action="<%= request.getContextPath() %>/rides">
                <h2 class="h6">Nouvelle course</h2>
                <input type="hidden" name="action" value="CREATE">
                <input class="form-control mb-2" name="pickup" placeholder="Depart" required>
                <input class="form-control mb-2" name="destination" placeholder="Destination" required>
                <input class="form-control mb-2" type="number" step="0.1" min="0" name="distanceKm" placeholder="Distance km" required>
                <input class="form-control mb-2" type="number" min="0" name="waitMinutes" placeholder="Attente (min)" required>
                <input class="form-control mb-2" type="number" step="0.1" min="0" name="extraFees" placeholder="Frais supplementaires" required>
                <button class="btn btn-success btn-sm">Creer</button>
            </form>
        </div>
    </div>

    <div class="row mt-3">
        <div class="col-md-6">
            <h2 class="h5">Chauffeurs</h2>
            <table class="table table-sm table-bordered bg-white">
                <thead><tr><th>Nom</th><th>Telephone</th><th>Permis</th><th>Statut</th></tr></thead>
                <tbody><% for (Driver d : drivers) { %><tr><td><%= d.getFullName() %></td><td><%= d.getPhone() %></td><td><%= d.getLicenseNumber() %></td><td><%= d.getStatus() %></td></tr><% } %></tbody>
            </table>
        </div>
        <div class="col-md-6">
            <h2 class="h5">Vehicules</h2>
            <table class="table table-sm table-bordered bg-white">
                <thead><tr><th>Modele</th><th>Plaque</th><th>KM</th><th>Statut</th></tr></thead>
                <tbody><% for (Vehicle v : vehicles) { %><tr><td><%= v.getBrandModel() %></td><td><%= v.getPlateNumber() %></td><td><%= v.getMileage() %></td><td><%= v.getStatus() %></td></tr><% } %></tbody>
            </table>
        </div>
    </div>

    <h2 class="h5 mt-2">Courses</h2>
    <table class="table table-bordered bg-white align-middle">
        <thead><tr><th>ID</th><th>Trajet</th><th>Statut</th><th>Prix</th><th>Chauffeur</th><th>Action</th></tr></thead>
        <tbody>
        <% for (Ride r : rides) { %>
        <tr>
            <td><%= r.getId() %></td>
            <td><%= r.getPickup() %> -> <%= r.getDestination() %></td>
            <td><%= r.getStatus() %></td>
            <td><%= r.getTotalPrice() %> Ar</td>
            <td><%= r.getDriverId() == null ? "Non assigne" : r.getDriverId() %></td>
            <td>
                <% if ("ASSIGNEE".equals(r.getStatus())) { %>
                <form method="post" action="<%= request.getContextPath() %>/rides" class="d-inline">
                    <input type="hidden" name="action" value="START"><input type="hidden" name="rideId" value="<%= r.getId() %>">
                    <button class="btn btn-sm btn-primary">Demarrer</button>
                </form>
                <% } else if ("EN_COURS".equals(r.getStatus())) { %>
                <form method="post" action="<%= request.getContextPath() %>/rides" class="d-inline">
                    <input type="hidden" name="action" value="FINISH"><input type="hidden" name="rideId" value="<%= r.getId() %>">
                    <button class="btn btn-sm btn-success">Terminer</button>
                </form>
                <% } else { %>-<% } %>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
