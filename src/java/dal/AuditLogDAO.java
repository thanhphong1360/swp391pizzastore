package dal;

import java.sql.*;
import java.util.*;
import model.AuditLog;

public class AuditLogDAO {
    private Connection conn;

    public AuditLogDAO() {
        this.conn = DBContext.getInstance().getConnection();
    }

    
    public boolean insert(AuditLog log) {
        String sql = """
            INSERT INTO AuditLog (user_id, action_type, target_table, target_id, description, created_at)
            VALUES (?, ?, ?, ?, ?, GETDATE())
        """;
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setObject(1, log.getUserId());
            ps.setString(2, log.getActionType());
            ps.setString(3, log.getTargetTable());
            ps.setObject(4, log.getTargetId());
            ps.setString(5, log.getDescription());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("❌ Insert log failed: " + e.getMessage());
            return false;
        }
    }

    // ✅ Lấy tất cả log (join user để hiển thị tên)
    public List<AuditLog> getAll() {
        List<AuditLog> list = new ArrayList<>();
        String sql = """
            SELECT l.log_id, l.user_id, u.name AS user_name,
                   l.action_type, l.target_table, l.target_id,
                   l.description, l.created_at
            FROM AuditLog l
            LEFT JOIN Users u ON l.user_id = u.user_id
            ORDER BY l.log_id DESC
        """;
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                AuditLog log = new AuditLog();
                log.setLogId(rs.getInt("log_id"));
                log.setUserId((Integer) rs.getObject("user_id"));
                log.setUserName(rs.getString("user_name"));
                log.setActionType(rs.getString("action_type"));
                log.setTargetTable(rs.getString("target_table"));
                log.setTargetId((Integer) rs.getObject("target_id"));
                log.setDescription(rs.getString("description"));
                log.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(log);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

}
