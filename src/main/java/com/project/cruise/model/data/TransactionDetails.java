package com.project.cruise.model.data;

public class TransactionDetails {
    private int transactionId;
    private String orderId;
    private String paymentId;
    private String amount;
    private String receipt;
    private String status;
    private int cruiseId;
    private int passengerId;
    private String date;
    private String time;
    private String paidTime;

    public TransactionDetails(
            int transactionId,
            String orderId,
            String paymentId,
            String amount,
            String receipt,
            String status,
            int cruiseId,
            int passengerId,
            String date,
            String time,
            String paidTime
    ) {
        this.transactionId = transactionId;
        this.orderId = orderId;
        this.paymentId = paymentId;
        this.amount = amount;
        this.receipt = receipt;
        this.status = status;
        this.cruiseId = cruiseId;
        this.passengerId = passengerId;
        this.date = date;
        this.time = time;
        this.paidTime = paidTime;
    }

    // No-arg constructor for easier instantiation
    public TransactionDetails() {}

    // Getters and setters
    public int getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(int transactionId) {
        this.transactionId = transactionId;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(String paymentId) {
        this.paymentId = paymentId;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getReceipt() {
        return receipt;
    }

    public void setReceipt(String receipt) {
        this.receipt = receipt;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getCruiseId() {
        return cruiseId;
    }

    public void setCruiseId(int cruiseId) {
        this.cruiseId = cruiseId;
    }

    public int getPassengerId() {
        return passengerId;
    }

    public void setPassengerId(int passengerId) {
        this.passengerId = passengerId;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getPaidTime() {
        return paidTime;
    }

    public void setPaidTime(String paidTime) {
        this.paidTime = paidTime;
    }
}
