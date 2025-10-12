/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author HP
 */
public class Discount {

    private int discountId;
    private String code;
    private String description;
    private String type;
    private double value;
    private Date startDate;
    private Date endDate;
    private double minInvoicePrice;
    private double maxDiscountAmount;
    private boolean status;
    private Date createdAt;

    public Discount() {
    }

    public Discount(int discountId, String code, String description, String type, double value, Date startDate, Date endDate, double minInvoicePrice, double maxDiscountAmount, boolean status, Date createdAt) {
        this.discountId = discountId;
        this.code = code;
        this.description = description;
        this.type = type;
        this.value = value;
        this.startDate = startDate;
        this.endDate = endDate;
        this.minInvoicePrice = minInvoicePrice;
        this.maxDiscountAmount = maxDiscountAmount;
        this.status = status;
        this.createdAt = createdAt;
    }

    public int getDiscountId() {
        return discountId;
    }

    public void setDiscountId(int discountId) {
        this.discountId = discountId;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public double getValue() {
        return value;
    }

    public void setValue(double value) {
        this.value = value;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public double getMinInvoicePrice() {
        return minInvoicePrice;
    }

    public void setMinInvoicePrice(double minInvoicePrice) {
        this.minInvoicePrice = minInvoicePrice;
    }

    public double getMaxDiscountAmount() {
        return maxDiscountAmount;
    }

    public void setMaxDiscountAmount(double maxDiscountAmount) {
        this.maxDiscountAmount = maxDiscountAmount;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

}
