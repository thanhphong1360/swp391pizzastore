package model;

import java.math.BigDecimal;
import java.sql.Date;

public class Payment {

    private int paymentId;
    private int orderId;
    private String method;
    private BigDecimal amount;
    private Date paymentDate;
    private String status;

    // Constructors
    public Payment() {
    }

    public Payment(int orderId, String method, BigDecimal amount, String status) {
        this.orderId = orderId;
        this.method = method;
        this.amount = amount;
        this.status = status;
    }

    // Getters and Setters
    public int getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public Date getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
