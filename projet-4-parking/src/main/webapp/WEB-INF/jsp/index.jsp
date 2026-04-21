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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Smart Parking - Gestion de parking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/parking-theme.css">
</head>
<body>
<div class="container py-4">
    <!-- En-tête -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h1><i class="fas fa-parking"></i> Smart Parking</h1>
            <p class="text-light">Système intelligent de gestion de stationnement</p>
        </div>
        <div class="available-badge">
            <i class="fas fa-car"></i> Places disponibles: <strong><%= available %></strong>
        </div>
    </div>

    <!-- Messages flash -->
    <% if (flash != null) { %>
        <div class="alert alert-info alert-dismissible fade show" role="alert">
            <i class="fas fa-info-circle"></i> <%= flash %>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert"></button>
        </div>
    <% } %>

    <!-- Formulaires d'action -->
    <div class="row g-4 mb-5">
        <!-- Ajouter place -->
        <div class="col-md-3">
            <div class="card">
                <div class="card-body">
                    <h6><i class="fas fa-plus-circle"></i> Ajouter une place</h6>
                    <form method="post" action="${pageContext.request.contextPath}/parking">
                        <input type="hidden" name="action" value="ADD_SPOT">
                        <div class="mb-2">
                            <input class="form-control" name="code" placeholder="Code place" required>
                        </div>
                        <div class="form-check mb-3">
                            <input class="form-check-input" type="checkbox" name="vipReserved" id="vipCheck">
                            <label class="form-check-label" for="vipCheck">
                                <i class="fas fa-crown"></i> Réservée VIP
                            </label>
                        </div>
                        <button class="btn btn-primary w-100">
                            <i class="fas fa-plus"></i> Ajouter
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Réservation -->
        <div class="col-md-3">
            <div class="card">
                <div class="card-body">
                    <h6><i class="fas fa-calendar-check"></i> Réservation</h6>
                    <form method="post" action="${pageContext.request.contextPath}/parking">
                        <input type="hidden" name="action" value="RESERVE">
                        <div class="mb-2">
                            <input class="form-control" name="customerName" placeholder="Nom du client" required>
                        </div>
                        <div class="mb-2">
                            <select class="form-select" name="userType">
                                <option value="STANDARD">Standard</option>
                                <option value="ABONNE">Abonné</option>
                                <option value="VIP">VIP</option>
                            </select>
                        </div>
                        <div class="mb-2">
                            <input class="form-control" name="plateNumber" placeholder="Plaque d'immatriculation" required>
                        </div>
                        <div class="mb-3">
                            <input class="form-control" type="number" min="1" name="durationHours" placeholder="Durée (heures)" required>
                        </div>
                        <button class="btn btn-success w-100">
                            <i class="fas fa-check"></i> Réserver
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Entrée véhicule -->
        <div class="col-md-3">
            <div class="card">
                <div class="card-body">
                    <h6><i class="fas fa-sign-in-alt"></i> Entrée véhicule</h6>
                    <form method="post" action="${pageContext.request.contextPath}/parking">
                        <input type="hidden" name="action" value="ENTRY">
                        <div class="mb-2">
                            <input class="form-control" name="plateNumber" placeholder="Plaque d'immatriculation" required>
                        </div>
                        <div class="mb-3">
                            <select class="form-select" name="userType">
                                <option value="STANDARD">Standard</option>
                                <option value="ABONNE">Abonné</option>
                                <option value="VIP">VIP</option>
                            </select>
                        </div>
                        <button class="btn btn-warning w-100">
                            <i class="fas fa-door-open"></i> Enregistrer entrée
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Sortie véhicule -->
        <div class="col-md-3">
            <div class="card">
                <div class="card-body">
                    <h6><i class="fas fa-sign-out-alt"></i> Sortie véhicule</h6>
                    <form method="post" action="${pageContext.request.contextPath}/parking">
                        <input type="hidden" name="action" value="EXIT">
                        <div class="mb-2">
                            <input class="form-control" name="plateNumber" placeholder="Plaque d'immatriculation" required>
                        </div>
                        <div class="form-check mb-3">
                            <input class="form-check-input" type="checkbox" name="subscribed" id="subscribedCheck">
                            <label class="form-check-label" for="subscribedCheck">
                                <i class="fas fa-id-card"></i> Abonné
                            </label>
                        </div>
                        <button class="btn btn-danger w-100">
                            <i class="fas fa-door-closed"></i> Enregistrer sortie
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Tableaux de données -->
    <div class="row g-4">
        <!-- Places -->
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <h6><i class="fas fa-map-marker-alt"></i> Places de stationnement</h6>
                    <div class="table-responsive">
                        <table class="table table-sm">
                            <thead>
                                <tr><th>Code</th><th>VIP</th><th>Occupée</th></tr>
                            </thead>
                            <tbody>
                            <% for (ParkingSpot s : spots) { %>
                                <tr>
                                    <td><%= s.getCode() %></td>
                                    <td><% if(s.isVipReserved()) { %><i class="fas fa-crown text-warning"></i><% } else { %>-<% } %></td>
                                    <td><% if(s.isOccupied()) { %><i class="fas fa-car text-danger"></i><% } else { %><i class="fas fa-check text-success"></i><% } %></td>
                                </tr>
                            <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Réservations -->
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <h6><i class="fas fa-bookmark"></i> Réservations actives</h6>
                    <div class="table-responsive">
                        <table class="table table-sm">
                            <thead>
                                <tr><th>Client</th><th>Type</th><th>Plaque</th><th>Place</th></tr>
                            </thead>
                            <tbody>
                            <% for (Reservation r : reservations) { %>
                                <tr>
                                    <td><%= r.getCustomerName() %></td>
                                    <td><span class="badge bg-info"><%= r.getUserType() %></span></td>
                                    <td><%= r.getPlateNumber() %></td>
                                    <td><%= r.getSpotId() %></td>
                                </tr>
                            <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Entrées/Sorties -->
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <h6><i class="fas fa-history"></i> Historique des mouvements</h6>
                    <div class="table-responsive">
                        <table class="table table-sm">
                            <thead>
                                <tr><th>Plaque</th><th>Place</th><th>Entrée</th><th>Sortie</th><th>Montant</th></tr>
                            </thead>
                            <tbody>
                            <% for (ParkingEntry e : entries) { %>
                                <tr>
                                    <td><%= e.getPlateNumber() %></td>
                                    <td><%= e.getSpotId() %></td>
                                    <td><%= e.getEntryAt() %></td>
                                    <td><%= e.getExitAt() != null ? e.getExitAt() : "-" %></td>
                                    <td><%= e.getAmount() != null ? e.getAmount() + " €" : "-" %></td>
                                </tr>
                            <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>