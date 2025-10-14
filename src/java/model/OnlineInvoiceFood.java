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
public class OnlineInvoiceFood {
    private int onlineInvoiceId;
    private int foodId;
    private int quantity;
    private BigDecimal price;

    public OnlineInvoiceFood() {
    }

    public OnlineInvoiceFood(int onlineInvoiceId, int foodId, int quantity, BigDecimal price) {
        this.onlineInvoiceId = onlineInvoiceId;
        this.foodId = foodId;
        this.quantity = quantity;
        this.price = price;
    }

    public int getOnlineInvoiceId() {
        return onlineInvoiceId;
    }

    public void setOnlineInvoiceId(int onlineInvoiceId) {
        this.onlineInvoiceId = onlineInvoiceId;
    }

    public int getFoodId() {
        return foodId;
    }

    public void setFoodId(int foodId) {
        this.foodId = foodId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }
    
    
    
}
