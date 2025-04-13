package com.project.cruise.model.data;

/**
 *
 * @author My PC
 */
public class BookingDetails {
    private String bookingReference;
    private String cruiseName;
    private String cruiseRoute;
    private String departureDate;
    private int durationDays;
    private double cruisePrice;
    private String boardingPassQr;
    private String passengerName;
    private String passengerEmail; // Added field for passenger email

    // No-arg constructor for easier instantiation
    public BookingDetails() {}

    // Constructor with all fields
    public BookingDetails(
            String bookingReference,
            String cruiseName,
            String cruiseRoute,
            String departureDate,
            int durationDays,
            double cruisePrice,
            String boardingPassQr,
            String passengerName,
            String passengerEmail // Added parameter for passenger email
    ) {
        this.bookingReference = bookingReference;
        this.cruiseName = cruiseName;
        this.cruiseRoute = cruiseRoute;
        this.departureDate = departureDate;
        this.durationDays = durationDays;
        this.cruisePrice = cruisePrice;
        this.boardingPassQr = boardingPassQr;
        this.passengerName = passengerName;
        this.passengerEmail = passengerEmail;
    }

    // Getters and setters
    public String getBookingReference() {
        return bookingReference;
    }

    public void setBookingReference(String bookingReference) {
        this.bookingReference = bookingReference;
    }

    public String getCruiseName() {
        return cruiseName;
    }

    public void setCruiseName(String cruiseName) {
        this.cruiseName = cruiseName;
    }

    public String getCruiseRoute() {
        return cruiseRoute;
    }

    public void setCruiseRoute(String cruiseRoute) {
        this.cruiseRoute = cruiseRoute;
    }

    public String getDepartureDate() {
        return departureDate;
    }

    public void setDepartureDate(String departureDate) {
        this.departureDate = departureDate;
    }

    public int getDurationDays() {
        return durationDays;
    }

    public void setDurationDays(int durationDays) {
        this.durationDays = durationDays;
    }

    public double getCruisePrice() {
        return cruisePrice;
    }

    public void setCruisePrice(double cruisePrice) {
        this.cruisePrice = cruisePrice;
    }

    public String getBoardingPassQr() {
        return boardingPassQr;
    }

    public void setBoardingPassQr(String boardingPassQr) {
        this.boardingPassQr = boardingPassQr;
    }

    public String getPassengerName() {
        return passengerName;
    }

    public void setPassengerName(String passengerName) {
        this.passengerName = passengerName;
    }

    public String getPassengerEmail() {
        return passengerEmail;
    }

    public void setPassengerEmail(String passengerEmail) {
        this.passengerEmail = passengerEmail;
    }
}
