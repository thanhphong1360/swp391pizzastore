/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 *
 * @author cungp
 */
public class Order {
    private int orderId;
    private int invoiceId;
    private int waiterId;
    private int chefId;
    private int tableId;
    private String status;
    private BigDecimal price;
    private String note;
    private LocalDateTime created_at;

    public Order() {
    }

    public Order(int orderId, int invoiceId, int waiterId, int chefId, int tableId, String status, BigDecimal price, String note, LocalDateTime created_at) {
        this.orderId = orderId;
        this.invoiceId = invoiceId;
        this.waiterId = waiterId;
        this.chefId = chefId;
        this.tableId = tableId;
        this.status = status;
        this.price = price;
        this.note = note;
        this.created_at = created_at;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getInvoiceId() {
        return invoiceId;
    }

    public void setInvoiceId(int invoiceId) {
        this.invoiceId = invoiceId;
    }

    public int getWaiterId() {
        return waiterId;
    }

    public void setWaiterId(int waiterId) {
        this.waiterId = waiterId;
    }

    public int getChefId() {
        return chefId;
    }

    public void setChefId(int chefId) {
        this.chefId = chefId;
    }

    public int getTableId() {
        return tableId;
    }

    public void setTableId(int tableId) {
        this.tableId = tableId;
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

    public LocalDateTime getCreated_at() {
        return created_at;
    }

    public void setCreated_at(LocalDateTime created_at) {
        this.created_at = created_at;
    }
    
    
}
