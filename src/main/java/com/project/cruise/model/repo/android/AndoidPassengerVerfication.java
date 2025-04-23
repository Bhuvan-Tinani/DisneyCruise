/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.project.cruise.model.repo.android;

import com.project.cruise.model.data.BookingDetailMeta;
import com.project.cruise.model.data.BookingDetails;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author My PC
 */
public class AndoidPassengerVerfication implements IAndoidPassengerVerfication {

    Connection con;

    public AndoidPassengerVerfication(Connection con) {
        this.con = con;
    }

    @Override
    public boolean checkPassengerExistInCruise(int cruiseId, int passengerId) throws SQLException {
        final String sql = """
        SELECT COUNT(*) AS count
        FROM booking_passengers bp
        INNER JOIN bookings b ON bp.booking_id = b.id
        WHERE b.cruise_id = ? AND bp.passenger_id = ?
    """;

        try (PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, cruiseId);
            stmt.setInt(2, passengerId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt("count");
                    System.out.println("count-" + count);
                    return count > 0;
                }
            }
        }

        return false;
    }

    @Override
    public String checkInStatus(int cruiseId, int passengerId) throws SQLException {
        final String sql = """
        SELECT bp.scanned
        FROM boardingpass bp
        INNER JOIN booking_passengers bps ON bp.booking_passenger_id = bps.id
        INNER JOIN bookings b ON bps.booking_id = b.id
        WHERE b.cruise_id = ? AND bps.passenger_id = ?
        LIMIT 1
    """;

        try (PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, cruiseId);
            stmt.setInt(2, passengerId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int scanned = rs.getInt("scanned");
                    switch (scanned) {
                        case 0:
                            return "NotCheckedIn";
                        case 1:
                            return "CheckedIn";
                        case 2:
                            return "CheckedOut";
                        default:
                            return "Unknown";
                    }
                } else {
                    return "NotFound"; // No matching record
                }
            }
        }
    }

    @Override
    public String checkIn(int cruiseId, int passengerId) throws SQLException {
        String result = null;
        String sql = "{CALL CheckInPassenger(?, ?, ?)}";

        try (CallableStatement stmt = con.prepareCall(sql)) {
            stmt.setInt(1, cruiseId);
            stmt.setInt(2, passengerId);
            stmt.registerOutParameter(3, java.sql.Types.VARCHAR);

            stmt.execute();
            result = stmt.getString(3); // Get result from OUT parameter
        }

        return result;
    }

    @Override
    public void checkOut(int cruiseId, int passengerId) throws SQLException {
        String sql = "{ CALL checkout_passenger(?, ?) }";
        try (PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, cruiseId);
            stmt.setInt(2, passengerId);
            stmt.execute();
        }
    }

    @Override
    public BookingDetailMeta getBookingDetails(int cruiseId, int passengerId) throws SQLException {
        final String sql = """
        SELECT 
            b.booking_reference,
            c.ship_name AS cruise_name,
            c.route AS cruise_route,
            c.departure_date,
            c.duration_days,
            c.price AS cruise_price,
            bp.qr_code AS boarding_pass_qr,
            CONCAT(p.first_name, ' ', p.last_name) AS passenger_name,
            p.email AS passenger_email,
            p.phone,
            p.nationality,
            p.passport_number
        FROM booking_passengers bps
        INNER JOIN bookings b ON bps.booking_id = b.id
        INNER JOIN cruises c ON b.cruise_id = c.id
        INNER JOIN passengers p ON bps.passenger_id = p.id
        INNER JOIN boardingpass bp ON bp.booking_passenger_id = bps.id
        WHERE b.cruise_id = ? AND bps.passenger_id = ?
        LIMIT 1
    """;

        try (PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, cruiseId);
            stmt.setInt(2, passengerId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new BookingDetailMeta(
                            rs.getString("booking_reference"),
                            rs.getString("cruise_name"),
                            rs.getString("cruise_route"),
                            rs.getString("departure_date"),
                            rs.getInt("duration_days"),
                            rs.getDouble("cruise_price"),
                            rs.getString("boarding_pass_qr"),
                            rs.getString("passenger_name"),
                            rs.getString("passenger_email"),
                            rs.getString("phone"),
                            rs.getString("nationality"),
                            rs.getString("passport_number")
                    );
                }
            }
        }

        return null; // If no booking found
    }

}
