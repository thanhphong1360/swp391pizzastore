/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;

/**
 *
 * @author cungp
 */
public class OnlineInvoice {
    private int onlineInvoiceId;
    private int customerId;
    private int deliveryStaffId;
    private int chefId;
    private String status;
    private BigDecimal price;
    private String note;

    public OnlineInvoice() {
    }

    public OnlineInvoice(int onlineInvoiceId, int customerId, int deliveryStaffId, int chefId, String status, BigDecimal price, String note) {
        this.onlineInvoiceId = onlineInvoiceId;
        this.customerId = customerId;
        this.deliveryStaffId = deliveryStaffId;
        this.chefId = chefId;
        this.status = status;
        this.price = price;
        this.note = note;
    }

    public int getOnlineInvoiceId() {
        return onlineInvoiceId;
    }

    public void setOnlineInvoiceId(int onlineInvoiceId) {
        this.onlineInvoiceId = onlineInvoiceId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getDeliveryStaffId() {
        return deliveryStaffId;
    }

    public void setDeliveryStaffId(int deliveryStaffId) {
        this.deliveryStaffId = deliveryStaffId;
    }

    public int getChefId() {
        return chefId;
    }

    public void setChefId(int chefId) {
        this.chefId = chefId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }
    
    
}
