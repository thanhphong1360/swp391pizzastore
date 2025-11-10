package model;

import java.util.List;

public class Menu {

    private int foodId;
    private int categoryId;

    private String foodName;
    private String description;
    private double price;
    private String status;
    private String categoryName;
    private String categoryDescription;  
    private String imgURL;
    private String size;
    
    private List<Ingredient> ingredients;

    public Menu() {
    }

    public Menu(int foodId, int categoryId, String foodName, String description, double price, String status, String categoryName, String categoryDescription, String imgURL, String size, List<Ingredient> ingredients) {
        this.foodId = foodId;
        this.categoryId = categoryId;
        this.foodName = foodName;
        this.description = description;
        this.price = price;
        this.status = status;
        this.categoryName = categoryName;
        this.categoryDescription = categoryDescription;
        this.imgURL = imgURL;
        this.size = size;
        this.ingredients = ingredients;
    }

    public void setFoodId(int foodId) {
        this.foodId = foodId;
    }

    public int getFoodId() {
        return foodId;
    }

    public String getFoodName() {
        return foodName;
    }

    public void setFoodName(String foodName) {
        this.foodName = foodName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getCategoryDescription() {
        return categoryDescription;
    }

    public void setCategoryDescription(String categoryDescription) {
        this.categoryDescription = categoryDescription;
    }

    public String getImgURL() {
        return imgURL;
    }

    public void setImgURL(String imgURL) {
        this.imgURL = imgURL;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public List<Ingredient> getIngredients() {
        return ingredients;
    }

    public void setIngredients(List<Ingredient> ingredients) {
        this.ingredients = ingredients;
    }

    
}
