/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

public class Ingredient {
    private int ingredientId;
    private String name;
    private String description;
    private String unit;
    private double quantity;
    private Timestamp updatedAt;
    private boolean status;

    public Ingredient() {}

    public Ingredient(int ingredientId, String name, String description, String unit, double quantity, Timestamp updatedAt,boolean status) {
        this.ingredientId = ingredientId;
        this.name = name;
        this.description = description;
        this.unit = unit;
        this.quantity = quantity;
        this.updatedAt = updatedAt;
        this.status = status;
    }
    public boolean isStatus() {
    return status;
}

public void setStatus(boolean status) {
    this.status = status;
}

    public int getIngredientId() { return ingredientId; }
    public void setIngredientId(int ingredientId) { this.ingredientId = ingredientId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getUnit() { return unit; }
    public void setUnit(String unit) { this.unit = unit; }

    public double getQuantity() { return quantity; }
    public void setQuantity(double quantity) { this.quantity = quantity; }

    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }
}
