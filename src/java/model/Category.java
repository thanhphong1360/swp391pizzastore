/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Dystopia
 */
public class Category {
    private int categoryId;
    private String name;
    private String description;
    private String status;

    public Category() {
    }

    public Category(String name, String description, String status) {
        this.name = name;
        this.description = description;
        this.status = status;
    }

    public Category(int categoryId, String name) {
        this.categoryId = categoryId;
        this.name = name;
    }
    public Category(int categoryId, String name, String description, String status) {
        this.categoryId = categoryId;
        this.name = name;
        this.description = description;
        this.status = status;
    }

    public int getCategoryId() {
        return categoryId;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
}
