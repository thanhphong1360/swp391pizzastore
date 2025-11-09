/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import dal.FoodDAO;
import dal.OrderDAO;
import java.math.BigDecimal;

/**
 *
 * @author cungp
 */
public class OrderFood {
    private int orderFoodId;
    private int orderId;
    private int foodId;
    private int quantity;
    private BigDecimal price;
    private String note;
    
    private Order order;
    private Food food;
    private String foodName;

    public OrderFood() {
    }

    public OrderFood(int orderId, int foodId, int quantity, BigDecimal price) {
        this.orderId = orderId;
        this.foodId = foodId;
        this.quantity = quantity;
        this.price = price;
    }

    public OrderFood(int orderFoodId, int orderId, int foodId, int quantity, BigDecimal price, String note) {
        this.orderFoodId = orderFoodId;
        this.orderId = orderId;
        this.foodId = foodId;
        this.quantity = quantity;
        this.price = price;
        this.note = note;
    }
    
    

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
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
    
    public void includeOrder(){
        this.order = OrderDAO.getOrderById(this.orderId);
    }
    
    public Order getOrder(){
        return this.order;
    }
    
    public void includeFood(){
        this.food = FoodDAO.getFoodById(this.foodId);
    }
    
    public Food getFood(){
        return this.food;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getFoodName() {
        return foodName;
    }

    public void setFoodName(String foodName) {
        this.foodName = foodName;
    }

    public int getOrderFoodId() {
        return orderFoodId;
    }

    public void setOrderFoodId(int orderFoodId) {
        this.orderFoodId = orderFoodId;
    }
    
    
}
