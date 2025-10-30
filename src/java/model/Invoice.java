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
public class Invoice {
    private int invoiceId;
    private String invoiceCode;
    private int dicountId;
    private int waiterId;
    private int cashierId;
    private String status;
    private BigDecimal price;
    private BigDecimal finalPrice;
    private LocalDateTime createdAt;
    private LocalDateTime paidAt;
    private String note;
    
    private String tableNumbers;

    public Invoice() {
    }

    public Invoice(int invoiceId, String invoiceCode, int dicountId, int waiterId, int cashierId, String status, BigDecimal price, BigDecimal finalPrice, LocalDateTime createdAt, LocalDateTime paidAt, String note) {
        this.invoiceId = invoiceId;
        this.invoiceCode = invoiceCode;
        this.dicountId = dicountId;
        this.waiterId = waiterId;
        this.cashierId = cashierId;
        this.status = status;
        this.price = price;
        this.finalPrice = finalPrice;
        this.createdAt = createdAt;
        this.paidAt = paidAt;
        this.note = note;
    }

    

    public int getInvoiceId() {
        return invoiceId;
    }

    public void setInvoiceId(int invoiceId) {
        this.invoiceId = invoiceId;
    }

    public int getDicountId() {
        return dicountId;
    }

    public void setDicountId(int dicountId) {
        this.dicountId = dicountId;
    }

    public int getWaiterId() {
        return waiterId;
    }

    public void setWaiterId(int waiterId) {
        this.waiterId = waiterId;
    }

    public int getCashierId() {
        return cashierId;
    }

    public void setCashierId(int cashierId) {
        this.cashierId = cashierId;
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

    public BigDecimal getFinalPrice() {
        return finalPrice;
    }

    public void setFinalPrice(BigDecimal finalPrice) {
        this.finalPrice = finalPrice;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public String getInvoiceCode() {
        return invoiceCode;
    }

    public void setInvoiceCode(String invoiceCode) {
        this.invoiceCode = invoiceCode;
    }

    public LocalDateTime getPaidAt() {
        return paidAt;
    }

    public void setPaidAt(LocalDateTime paidAt) {
        this.paidAt = paidAt;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getTableNumbers() {
        return tableNumbers;
    }

    public void setTableNumbers(String tableNumbers) {
        this.tableNumbers = tableNumbers;
    }
    
    
    
    
}
