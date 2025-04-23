package com.project.cruise.model.data;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author My PC
 */

public class BookingDetailMeta {
    private String bookingReference;
    private String cruiseName;
    private String cruiseRoute;
    private String departureDate;
    private int durationDays;
    private double cruisePrice;
    private String boardingPassQr;
    private String passengerName;
    private String passengerEmail;

    // Additional fields
    private String phone;
    private String nationality;
    private String passportNumber;

    // No-arg constructor
    public BookingDetailMeta() {}

    // All-args constructor
    public BookingDetailMeta(
        String bookingReference,
        String cruiseName,
        String cruiseRoute,
        String departureDate,
        int durationDays,
        double cruisePrice,
        String boardingPassQr,
        String passengerName,
        String passengerEmail,
        String phone,
        String nationality,
        String passportNumber
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
        this.phone = phone;
        this.nationality = nationality;
        this.passportNumber = passportNumber;
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

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getNationality() {
        return nationality;
    }

    public void setNationality(String nationality) {
        this.nationality = nationality;
    }

    public String getPassportNumber() {
        return passportNumber;
    }

    public void setPassportNumber(String passportNumber) {
        this.passportNumber = passportNumber;
    }
}

