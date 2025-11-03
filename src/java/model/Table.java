package model;

public class Table {

    private int tableId;
    private String tableName;
    private int capacity;
    private String status;
    private String location;

    public Table() {
    }

    public Table(int tableId, String tableName, int capacity, String status, String location) {
        this.tableId = tableId;
        this.tableName = tableName;
        this.capacity = capacity;
        this.status = status;
        this.location = location;
    }

    public int getTableId() {
        return tableId;
    }

    public void setTableId(int tableId) {
        this.tableId = tableId;
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }
}
