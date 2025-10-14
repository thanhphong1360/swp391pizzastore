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
public class Ingredient {
    private int ingedientId;
    private String name;
    private String description;
    private String unit;
    private BigDecimal quantity;
    private LocalDateTime updated_at;

    public Ingredient() {
    }

    public Ingredient(int ingedientId, String name, String description, String unit, BigDecimal quantity, LocalDateTime updated_at) {
        this.ingedientId = ingedientId;
        this.name = name;
        this.description = description;
        this.unit = unit;
        this.quantity = quantity;
        this.updated_at = updated_at;
    }

    public int getIngedientId() {
        return ingedientId;
    }

    public void setIngedientId(int ingedientId) {
        this.ingedientId = ingedientId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public BigDecimal getQuantity() {
        return quantity;
    }

    public void setQuantity(BigDecimal quantity) {
        this.quantity = quantity;
    }

    public LocalDateTime getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(LocalDateTime updated_at) {
        this.updated_at = updated_at;
    }
    
    
}
