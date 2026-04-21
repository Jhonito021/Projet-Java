<%@ page import="java.util.List" %>
<%@ page import="com.projetsimple.parking.model.ParkingSpot" %>
<%@ page import="com.projetsimple.parking.model.Reservation" %>
<%@ page import="com.projetsimple.parking.model.ParkingEntry" %>
<%
List<ParkingSpot> spots = (List<ParkingSpot>) request.getAttribute("spots");
List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
List<ParkingEntry> entries = (List<ParkingEntry>) request.getAttribute("entries");
Integer available = (Integer) request.getAttribute("available");
String flash = (String) session.getAttribute("flash");
if (flash != null) session.removeAttribute("flash");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestion parking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4">
    <h1 class="h3">Projet 4 - Gestion parking</h1>
    <p>Places disponibles: <strong><%= available %></strong></p>
    <% if (flash != null) { %><div class="alert alert-info"><%= flash %></div><% } %>

    <div class="row g-3">
        <div class="col-md-3">
            <form class="card card-body" method="post" action="<%= request.getContextPath() %>/parking">
                <h2 class="h6">Ajouter place</h2>
                <input type="hidden" name="action" value="ADD_SPOT">
                <input class="form-control mb-2" name="code" placeholder="Code place" required>
                <div class="form-check mb-2"><input class="form-check-input" type="checkbox" name="vipReserved"><label class="form-check-label">Reserve VIP</label></div>
                <button class="btn btn-primary btn-sm">Ajouter</button>
            </form>
        </div>
        <div class="col-md-3">
            <form class="card card-body" method="post" action="<%= request.getContextPath() %>/parking">
                <h2 class="h6">Reservation</h2>
                <input type="hidden" name="action" value="RESERVE">
                <input class="form-control mb-2" name="customerName" placeholder="Client" required>
                <select class="form-select mb-2" name="userType"><option>STANDARD</option><option>ABONNE</option><option>VIP</option></select>
                <input class="form-control mb-2" name="plateNumber" placeholder="Plaque" required>
                <input class="form-control mb-2" type="number" min="1" name="durationHours" placeholder="Duree h" required>
                <button class="btn btn-success btn-sm">Reserver</button>
            </form>
        </div>
        <div class="col-md-3">
            <form class="card card-body" method="post" action="<%= request.getContextPath() %>/parking">
                <h2 class="h6">Entree vehicule</h2>
                <input type="hidden" name="action" value="ENTRY">
                <input class="form-control mb-2" name="plateNumber" placeholder="Plaque" required>
                <select class="form-select mb-2" name="userType"><option>STANDARD</option><option>ABONNE</option><option>VIP</option></select>
                <button class="btn btn-warning btn-sm">Enregistrer entree</button>
            </form>
        </div>
        <div class="col-md-3">
            <form class="card card-body" method="post" action="<%= request.getContextPath() %>/parking">
                <h2 class="h6">Sortie vehicule</h2>
                <input type="hidden" name="action" value="EXIT">
                <input class="form-control mb-2" name="plateNumber" placeholder="Plaque" required>
                <div class="form-check mb-2"><input class="form-check-input" type="checkbox" name="subscribed"><label class="form-check-label">Abonne</label></div>
                <button class="btn btn-danger btn-sm">Enregistrer sortie</button>
            </form>
        </div>
    </div>

    <div class="row mt-3">
        <div class="col-md-4">
            <h2 class="h6">Places</h2>
            <table class="table table-sm table-bordered bg-white"><thead><tr><th>Code</th><th>VIP</th><th>Occupee</th></tr></thead><tbody>
            <% for (ParkingSpot s : spots) { %><tr><td><%= s.getCode() %></td><td><%= s.isVipReserved() %></td><td><%= s.isOccupied() %></td></tr><% } %>
            </tbody></table>
        </div>
        <div class="col-md-4">
            <h2 class="h6">Reservations</h2>
            <table class="table table-sm table-bordered bg-white"><thead><tr><th>Client</th><th>Type</th><th>Plaque</th><th>Place</th></tr></thead><tbody>
            <% for (Reservation r : reservations) { %><tr><td><%= r.getCustomerName() %></td><td><%= r.getUserType() %></td><td><%= r.getPlateNumber() %></td><td><%= r.getSpotId() %></td></tr><% } %>
            </tbody></table>
        </div>
        <div class="col-md-4">
            <h2 class="h6">Entrees/Sorties</h2>
            <table class="table table-sm table-bordered bg-white"><thead><tr><th>Plaque</th><th>Place</th><th>Entree</th><th>Sortie</th><th>Montant</th></tr></thead><tbody>
            <% for (ParkingEntry e : entries) { %><tr><td><%= e.getPlateNumber() %></td><td><%= e.getSpotId() %></td><td><%= e.getEntryAt() %></td><td><%= e.getExitAt() %></td><td><%= e.getAmount() %></td></tr><% } %>
            </tbody></table>
        </div>
    </div>
</div>
</body>
</html>
