package dal;

import java.sql.*;
import java.util.*;
import model.CategoryRevenue;
import model.RevenueByDate;
import model.TopFood;

public class DashboardDAO extends DBContext {

    // Tổng doanh thu hôm nay (online + offline)
    public double getTodayRevenue() {
        double total = 0;
        String sql = """
            SELECT SUM(price) FROM (
                SELECT price, created_at FROM OnlineInvoices
                UNION ALL
                SELECT final_price, created_at FROM Invoices
            ) AS AllInvoices
            WHERE CAST(created_at AS DATE) = CAST(GETDATE() AS DATE)
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getDouble(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    // Tổng số hóa đơn (online + offline)
    public int getTotalInvoices() {
        int total = 0;
        String sql = """
            SELECT COUNT(*) FROM (
                SELECT online_invoice_id AS id FROM OnlineInvoices
                UNION ALL
                SELECT invoice_id AS id FROM Invoices
            ) AS AllInvoices
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    // Tổng khách hàng (có giao dịch)
    public int getTotalCustomers() {
        int total = 0;
        String sql = """
            SELECT COUNT(DISTINCT customer_id) FROM (
                SELECT customer_id FROM OnlineInvoices
                UNION ALL
                SELECT waiter_id FROM Invoices
            ) AS AllCustomers
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    // Doanh thu theo ngày (lọc theo khoảng)
    public List<RevenueByDate> getRevenueByDate(String fromDate, String toDate) {
        List<RevenueByDate> list = new ArrayList<>();
        String sql = """
            SELECT CAST(created_at AS DATE) AS date, SUM(price) AS total
            FROM (
                SELECT price, created_at FROM OnlineInvoices
                UNION ALL
                SELECT final_price, created_at FROM Invoices
            ) AS AllInvoices
            WHERE CAST(created_at AS DATE) BETWEEN ? AND ?
            GROUP BY CAST(created_at AS DATE)
            ORDER BY date ASC
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, fromDate);
            ps.setString(2, toDate);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new RevenueByDate(rs.getString("date"), rs.getDouble("total")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Tổng số hóa đơn theo khoảng (online + offline)
    public int getTotalInvoicesInRange(String from, String to) {
        int total = 0;
        String sql = """
            SELECT COUNT(*) FROM (
                SELECT online_invoice_id AS id FROM OnlineInvoices
                WHERE CAST(created_at AS DATE) BETWEEN ? AND ?
                UNION ALL
                SELECT invoice_id AS id FROM Invoices
                WHERE CAST(created_at AS DATE) BETWEEN ? AND ?
            ) AS AllInvoices
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, from);
            ps.setString(2, to);
            ps.setString(3, from);
            ps.setString(4, to);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    // Tổng khách hàng theo khoảng (có giao dịch)
    public int getTotalCustomersInRange(String from, String to) {
        int total = 0;
        String sql = """
            SELECT COUNT(DISTINCT customer_id) FROM (
                SELECT customer_id FROM OnlineInvoices
                WHERE CAST(created_at AS DATE) BETWEEN ? AND ?
                UNION ALL
                SELECT waiter_id FROM Invoices
                WHERE CAST(created_at AS DATE) BETWEEN ? AND ?
            ) AS AllCustomers
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, from);
            ps.setString(2, to);
            ps.setString(3, from);
            ps.setString(4, to);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    // Top món ăn bán chạy theo khoảng ngày (chỉ tính đơn đã thanh toán)
    public List<TopFood> getTopFoods(String from, String to, int limit) {
        List<TopFood> list = new ArrayList<>();
        String sql = """
        SELECT TOP (?) f.name AS food_name, SUM(t.total_quantity) AS total_quantity
        FROM (
            -- Offline: Chỉ đơn thanh toán
            SELECT ofd.food_id, SUM(ofd.quantity) AS total_quantity
            FROM OrderFoods ofd
            JOIN Orders o ON ofd.order_id = o.order_id
            JOIN Invoices i ON o.invoice_id = i.invoice_id
            WHERE CAST(o.created_at AS DATE) BETWEEN ? AND ? 
              AND i.status = 'paid'
            GROUP BY ofd.food_id
            
            UNION ALL
            
            -- Online: Chỉ đơn thanh toán
            SELECT oif.food_id, SUM(oif.quantity) AS total_quantity
            FROM OnlineInvoiceFoods oif
            JOIN OnlineInvoices oi ON oif.online_invoice_id = oi.online_invoice_id
            WHERE CAST(oi.created_at AS DATE) BETWEEN ? AND ? 
              AND oi.status = 'paid'
            GROUP BY oif.food_id
        ) AS t
        INNER JOIN Foods f ON t.food_id = f.food_id
        GROUP BY f.name
        ORDER BY total_quantity DESC;
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ps.setString(2, from);
            ps.setString(3, to);
            ps.setString(4, from);
            ps.setString(5, to);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new TopFood(rs.getString("food_name"), rs.getInt("total_quantity")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Doanh thu theo loại món (chỉ tính đơn đã thanh toán)
    public List<CategoryRevenue> getRevenueByCategory(String from, String to) {
        List<CategoryRevenue> list = new ArrayList<>();
        String sql = """
            SELECT c.name AS category_name, SUM(t.revenue) AS total_revenue
        FROM (
            -- Offline
            SELECT f.category_id, SUM(ofs.quantity * COALESCE(ofs.price, f.price)) AS revenue
            FROM OrderFoods ofs
            JOIN Orders o ON ofs.order_id = o.order_id
            JOIN Invoices i ON o.invoice_id = i.invoice_id
            JOIN Foods f ON ofs.food_id = f.food_id
            WHERE CAST(o.created_at AS DATE) BETWEEN ? AND ?
              AND i.status = 'paid'
            GROUP BY f.category_id
            
            UNION ALL
            
            -- Online
            SELECT f.category_id, SUM(oifs.quantity * COALESCE(oifs.price, f.price)) AS revenue
            FROM OnlineInvoiceFoods oifs
            JOIN OnlineInvoices oi ON oifs.online_invoice_id = oi.online_invoice_id
            JOIN Foods f ON oifs.food_id = f.food_id
            WHERE CAST(oi.created_at AS DATE) BETWEEN ? AND ?
              AND oi.status = 'paid'
            GROUP BY f.category_id
        ) AS t
        JOIN Categories c ON t.category_id = c.category_id
        GROUP BY c.name
        ORDER BY total_revenue DESC;
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, from);
            ps.setString(2, to);
            ps.setString(3, from);
            ps.setString(4, to);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new CategoryRevenue(rs.getString(1), rs.getDouble(2)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // so sánh Onlive với Offline
    public Map<String, Integer> getOrderChannelRatio(String from, String to) {
        Map<String, Integer> map = new HashMap<>();
        String sql = """
        SELECT 'Online' AS channel, COUNT(*) AS count FROM OnlineInvoices 
        WHERE CAST(created_at AS DATE) BETWEEN ? AND ?
        UNION ALL
        SELECT 'Offline', COUNT(*) FROM Invoices 
        WHERE CAST(created_at AS DATE) BETWEEN ? AND ?
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, from);
            ps.setString(2, to);
            ps.setString(3, from);
            ps.setString(4, to);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                map.put(rs.getString(1), rs.getInt(2));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

}
