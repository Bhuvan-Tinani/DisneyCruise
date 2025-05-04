package com.project.cruise.model.repo.passenger;

import com.project.cruise.model.data.BookingDetails;
import com.project.cruise.model.data.Cruise;
import com.project.cruise.model.data.OrderDetail;
import com.project.cruise.model.data.TransactionDetails;
import com.project.cruise.model.data.passenger.SignUpInfo;
import com.project.cruise.model.passenger.Passenger;
import com.project.cruise.model.utils.PasswordManager;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author My PC
 */
public class PassengerRepo implements IPassengerRepo {

    private Connection con;

    public PassengerRepo(Connection con) {
        this.con = con;
    }

    @Override
    public boolean createAccount(SignUpInfo info) throws SQLException {
        String hashpassword=PasswordManager.hashWithSalt(info.getPassword());
        String sql = "INSERT INTO users (username, password, role) VALUES (?, ?, ?)";
        PreparedStatement pstmt = con.prepareCall(sql);
        pstmt.setString(1, info.getUsername());
        pstmt.setString(2, hashpassword); // Ideally use password hashing
        pstmt.setString(3, "passenger");
        int rows = pstmt.executeUpdate();
        if (rows > 0) {
            return true;
        }
        return false;
    }

    @Override
    public boolean isPassenger(String username) throws SQLException {
        String sql = "SELECT COUNT(*) FROM passengers WHERE email = ?";
        try (PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setString(1, username);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    return count > 0;
                }
            }
        }
        return false;
    }

    @Override
    public boolean addPassenger(Passenger passenger) throws SQLException {
        String sql = "INSERT INTO passengers (first_name, last_name, email, phone, nationality, passport_number, created_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, NOW())";
        try (PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setString(1, passenger.getFirstName());
            pstmt.setString(2, passenger.getLastName());
            pstmt.setString(3, passenger.getEmail());
            pstmt.setString(4, passenger.getPhone());
            pstmt.setString(5, passenger.getNationality());
            pstmt.setString(6, passenger.getPassportNumber());

            int rows = pstmt.executeUpdate();
            return rows > 0;
        }
    }

    public List<Cruise> getAllCruises() throws SQLException {
        List<Cruise> cruises = new ArrayList<>();
        String sql = "SELECT * FROM cruises";
        PreparedStatement pstmt = con.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            Cruise cruise = new Cruise();
            cruise.setId(rs.getInt("id"));
            cruise.setShipName(rs.getString("ship_name"));
            cruise.setRoute(rs.getString("route"));
            cruise.setDepartureDate(rs.getString("departure_date"));
            cruise.setDurationDays(rs.getInt("duration_days"));
            cruise.setPrice(rs.getDouble("price"));
            cruise.setStatus(rs.getString("status"));
            cruises.add(cruise);
        }

        return cruises;
    }

    public Cruise getCruiseById(int cruiseId) throws SQLException {
        String query = "SELECT * FROM cruises WHERE id = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, cruiseId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            Cruise cruise = new Cruise();
            cruise.setId(rs.getInt("id"));
            cruise.setShipName(rs.getString("ship_name"));
            cruise.setRoute(rs.getString("route"));
            cruise.setDepartureDate(rs.getString("departure_date"));
            cruise.setDurationDays(rs.getInt("duration_days"));
            cruise.setPrice(rs.getDouble("price"));
            cruise.setStatus(rs.getString("status"));
            return cruise;
        }
        return null;
    }

    public Passenger getPassengerByEmail(String email) throws SQLException {
        String query = "SELECT * FROM passengers WHERE email = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            Passenger p = new Passenger();
            p.setId(rs.getInt("id"));
            p.setEmail(rs.getString("email"));
            p.setFirstName(rs.getString("first_name"));
            p.setLastName(rs.getString("last_name"));
            p.setPhone(rs.getString("phone"));
            p.setNationality(rs.getString("nationality"));
            p.setPassportNumber(rs.getString("passport_number"));
            return p;
        }
        return null;
    }

    public int addTransactions(OrderDetail orderDetail) throws SQLException {
        int row = 0;
        String sql = "INSERT INTO transaction (order_id, payment_id, amount, receipt, status, cruise_id, passenger_id, date, time) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, orderDetail.getOrder_id());
        ps.setString(2, orderDetail.getPayment_id()); // can be null
        ps.setString(3, orderDetail.getAmount());
        ps.setString(4, orderDetail.getReceipt());
        ps.setString(5, orderDetail.getStatus());
        ps.setInt(6, orderDetail.getCruise_id());
        ps.setInt(7, orderDetail.getPassenger_id());
        ps.setString(8, orderDetail.getDate());
        ps.setString(9, orderDetail.getTime());

        row = ps.executeUpdate();
        return row;
    }

    public boolean updateTransactionWithPaymentId(String paymentId, String orderId) throws SQLException {
        String query = "UPDATE transaction SET payment_id = ?, status = ? WHERE order_id = ?";
        try (PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, paymentId);
            stmt.setString(2, "paid");
            stmt.setString(3, orderId);
            int rows = stmt.executeUpdate();
            return rows > 0;
        }
    }

    public int setTransactionDetails(String orderId, String paymentId) throws SQLException {
        String sql = """
        SELECT 
            transaction_id, 
            order_id, 
            payment_id, 
            amount, 
            receipt, 
            status, 
            cruise_id, 
            passenger_id, 
            date, 
            time, 
            paid_time 
        FROM transaction 
        WHERE order_id = ? AND payment_id = ?
        """;

        try (PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setString(1, orderId);
            pstmt.setString(2, paymentId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    // Create and return a TransactionDetails object
                    TransactionDetails t = new TransactionDetails(
                            rs.getInt("transaction_id"),
                            rs.getString("order_id"),
                            rs.getString("payment_id"),
                            rs.getString("amount"),
                            rs.getString("receipt"),
                            rs.getString("status"),
                            rs.getInt("cruise_id"),
                            rs.getInt("passenger_id"),
                            rs.getString("date"),
                            rs.getString("time"),
                            rs.getString("paid_time")
                    );
                    int bookingid = createBooking(t.getPaymentId(), t.getCruiseId(), Double.parseDouble(t.getAmount()));
                    int bookingPassenger = addPassengerToBooking(bookingid, t.getPassengerId());
                    createBoardingPass(bookingPassenger, paymentId, t.getPassengerId());
                    return t.getPassengerId();
                }
            }
        }
        return -1; // Or throw a custom exception if preferred
    }

    public int createBooking(String paymentId, int cruiseId, double totalPrice) throws SQLException {
        String bookingRef = "BOOK-" + paymentId; // Prefix for readability
        String sql = """
        INSERT INTO bookings 
        (booking_reference, cruise_id, status, total_price)
        VALUES (?, ?, 'Confirmed', ?)
        """;

        try (PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            pstmt.setString(1, bookingRef);
            pstmt.setInt(2, cruiseId);
            pstmt.setDouble(3, (totalPrice / 100));

            int affectedRows = pstmt.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = pstmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1); // Return the generated booking ID
                    } else {
                        throw new SQLException("Failed to retrieve generated booking ID.");
                    }
                }
            } else {
                throw new SQLException("Failed to create booking.");
            }
        }
    }

    public int addPassengerToBooking(int bookingId, int passengerId) throws SQLException {
        String sql = "INSERT INTO booking_passengers (booking_id, passenger_id) VALUES (?, ?)";
        try (PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            pstmt.setInt(1, bookingId);
            pstmt.setInt(2, passengerId);

            int affectedRows = pstmt.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = pstmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1); // Return the generated booking_passengers ID
                    } else {
                        throw new SQLException("Failed to retrieve generated booking_passengers ID.");
                    }
                }
            } else {
                throw new SQLException("Failed to add passenger to booking.");
            }
        }
    }

    public boolean createBoardingPass(int bookingPassengerId, String paymentId, int passengerId) throws SQLException {
        String qrCode = paymentId + "$" + passengerId; // Generate QR code
        String sql = "INSERT INTO boardingpass (booking_passenger_id, qr_code) VALUES (?, ?)";
        try (PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setInt(1, bookingPassengerId);
            pstmt.setString(2, qrCode);

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        }
    }

    public BookingDetails fetchBookingDetails(int passengerId) throws SQLException {
        BookingDetails details = new BookingDetails();

        String sql = """
        SELECT 
            b.booking_reference, 
            c.ship_name AS cruise_name, 
            c.route AS cruise_route, 
            c.departure_date, 
            c.duration_days, 
            c.price AS cruise_price, 
            br.qr_code AS boarding_pass_qr, 
            p.first_name, 
            p.last_name,
            p.email AS passenger_email
        FROM bookings b
        JOIN cruises c ON b.cruise_id = c.id
        JOIN booking_passengers bp ON b.id = bp.booking_id
        JOIN passengers p ON bp.passenger_id = p.id
        JOIN boardingpass br ON bp.id = br.booking_passenger_id
        WHERE p.id = ?
    """;

        try (PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setInt(1, passengerId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    details.setBookingReference(rs.getString("booking_reference"));
                    details.setCruiseName(rs.getString("cruise_name"));
                    details.setCruiseRoute(rs.getString("cruise_route"));
                    details.setDepartureDate(rs.getString("departure_date"));
                    details.setDurationDays(rs.getInt("duration_days"));
                    details.setCruisePrice(rs.getDouble("cruise_price"));
                    details.setBoardingPassQr(rs.getString("boarding_pass_qr"));
                    details.setPassengerName(rs.getString("first_name") + " " + rs.getString("last_name"));
                    details.setPassengerEmail(rs.getString("passenger_email")); // Set passenger email
                }
            }
        }

        return details;
    }

    public boolean updatePassenger(Passenger p) throws SQLException {
        String query = "UPDATE passengers SET first_name=?, last_name=?, phone=?, nationality=?, passport_number=? WHERE email=?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, p.getFirstName());
        ps.setString(2, p.getLastName());
        ps.setString(3, p.getPhone());
        ps.setString(4, p.getNationality());
        ps.setString(5, p.getPassportNumber());
        ps.setString(6, p.getEmail());

        return ps.executeUpdate() > 0;
    }

}
