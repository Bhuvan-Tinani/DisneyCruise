/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.project.cruise.model.data;

/**
 *
 * @author My PC
 */
public class Cruise {
    private int id;
    private String shipName;
    private String route;
    private String departureDate;
    private int durationDays;
    private double price;
    private String status;

    // Constructors
    public Cruise() {
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getShipName() {
        return shipName;
    }

    public void setShipName(String shipName) {
        this.shipName = shipName;
    }

    public String getRoute() {
        return route;
    }

    public void setRoute(String route) {
        this.route = route;
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

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    // toString method
    @Override
    public String toString() {
        return "Cruise{" +
                "id=" + id +
                ", shipName='" + shipName + '\'' +
                ", route='" + route + '\'' +
                ", departureDate='" + departureDate + '\'' +
                ", durationDays=" + durationDays +
                ", price=" + price +
                ", status='" + status + '\'' +
                '}';
    }
}
