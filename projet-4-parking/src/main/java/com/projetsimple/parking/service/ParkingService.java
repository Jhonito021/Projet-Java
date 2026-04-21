package com.projetsimple.parking.service;

import com.projetsimple.parking.model.ParkingEntry;
import com.projetsimple.parking.model.ParkingSpot;
import com.projetsimple.parking.model.Reservation;
import com.projetsimple.parking.repository.ParkingRepository;

import java.sql.SQLException;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;

public class ParkingService {
    private static final double HOURLY_RATE = 2000.0;

    private final ParkingRepository repository = new ParkingRepository();

    public void addSpot(String code, boolean vipReserved) throws SQLException {
        repository.createSpot(code, vipReserved);
    }

    public String createReservation(Reservation reservation) throws SQLException {
        Integer spot = repository.firstAvailableSpot(reservation.getUserType());
        if (spot == null) {
            return "Parking complet ou aucun emplacement compatible.";
        }
        reservation.setSpotId(spot);
        reservation.setStatus("CONFIRMEE");
        reservation.setStartAt(LocalDateTime.now());
        repository.createReservation(reservation);
        return null;
    }

    public String vehicleEntry(String plate, String userType) throws SQLException {
        Integer spot = repository.firstAvailableSpot(userType);
        if (spot == null) {
            return "Entree refusee: parking complet.";
        }
        repository.createEntry(plate, spot);
        repository.occupySpot(spot, true);
        return null;
    }

    public String vehicleExit(String plate, boolean subscribed) throws SQLException {
        ParkingEntry active = repository.activeEntryByPlate(plate);
        if (active == null) {
            return "Aucune entree active pour cette plaque.";
        }
        long hours = Math.max(1, Duration.between(active.getEntryAt(), LocalDateTime.now()).toHours());
        double amount = subscribed ? 0.0 : (hours * HOURLY_RATE);
        repository.closeEntry(active.getId(), amount);
        repository.occupySpot(active.getSpotId(), false);
        return "Sortie validee. Montant: " + amount + " Ar";
    }

    public List<ParkingSpot> spots() throws SQLException { return repository.listSpots(); }
    public List<Reservation> reservations() throws SQLException { return repository.listReservations(); }
    public List<ParkingEntry> entries() throws SQLException { return repository.listEntries(); }
    public int availableCount() throws SQLException { return repository.availableCount(); }
}
