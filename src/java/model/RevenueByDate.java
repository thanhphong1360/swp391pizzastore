package model;

public class RevenueByDate {

    private String date;
    private double total;

    public RevenueByDate(String date, double total) {
        this.date = date;
        this.total = total;
    }

    public String getDate() {
        return date;
    }

    public double getTotal() {
        return total;
    }
}
