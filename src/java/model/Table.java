/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author cungp
 */
public class Table {
    private int tableId;
    private String table_number;
    private int capacity;
    private String location;
    private String status;

    public Table() {
    }

    public Table(int tableId, String table_number, int capacity, String location, String status) {
        this.tableId = tableId;
        this.table_number = table_number;
        this.capacity = capacity;
        this.location = location;
        this.status = status;
    }

    public Table(int tableId, String table_number, String status) {
        this.tableId = tableId;
        this.table_number = table_number;
        this.status = status;
    }

    public int getTableId() {
        return tableId;
    }

    public void setTableId(int tableId) {
        this.tableId = tableId;
    }

    public String getTable_number() {
        return table_number;
    }

    public void setTable_number(String table_number) {
        this.table_number = table_number;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    
}
