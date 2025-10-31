/*
     * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
     * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author HP
 */
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.User;
import java.util.Scanner;

public class UserDAO {

    private Connection conn;

    public UserDAO() {
        this.conn = DBContext.getInstance().getConnection();
    }

    public static User login(String email, String password) {
        String sql = "SELECT user_id, role_id, email, password, name, created_at "
                + "FROM Users WHERE email = ? AND password = ?";

        try {
            DBContext db = DBContext.getInstance();
            Connection conn = db.connection;

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setRoleId(rs.getInt("role_id"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setName(rs.getString("name"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                return user;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean checkEmailExists(String email) {
        String sql = "SELECT user_id FROM Users WHERE email = ?";
        try {
            DBContext db = DBContext.getInstance();
            Connection conn = db.connection;
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next(); // nếu có kết quả tức là email tồn tại
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean insertUser(User user) {
        String sql = "INSERT INTO Users(role_id, email, password, name) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, user.getRoleId());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getName());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updatePassword(String email, String newPassword) {
        String sql = "UPDATE Users SET password = ? WHERE email = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setString(2, email);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<User> getAll() {
        List<User> list = new ArrayList<>();
        String sql = """
        SELECT u.user_id, u.role_id, r.role_name, u.email, u.password,
               u.name, u.created_at, u.status
        FROM Users u
        JOIN Roles r ON u.role_id = r.role_id
        ORDER BY u.user_id DESC
    """;

        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                User u = new User();
                u.setUserId(rs.getInt("user_id"));
                u.setRoleId(rs.getInt("role_id"));
                u.setRoleName(rs.getString("role_name"));
                u.setEmail(rs.getString("email"));
                u.setPassword(rs.getString("password"));
                u.setName(rs.getString("name"));
                u.setCreatedAt(rs.getTimestamp("created_at"));
                u.setStatus(rs.getBoolean("status"));
                list.add(u);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateStatus(int id, boolean newStatus) {
        String sql = "UPDATE Users SET status = ? WHERE user_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBoolean(1, newStatus);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("❌ updateStatus failed: " + e.getMessage());
            return false;
        }
    }

    public User getById(int id) {
        String sql = """
        SELECT user_id, role_id, email, password, name, created_at, status
        FROM Users
        WHERE user_id = ?
    """;
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User u = new User();
                u.setUserId(rs.getInt("user_id"));
                u.setRoleId(rs.getInt("role_id"));
                u.setEmail(rs.getString("email"));
                u.setPassword(rs.getString("password"));
                u.setName(rs.getString("name"));
                u.setCreatedAt(rs.getTimestamp("created_at"));
                u.setStatus(rs.getBoolean("status"));
                return u;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ✅ Thêm user mới
    public boolean insert(User u) {
        String sql = """
        INSERT INTO Users (role_id, email, password, name, created_at, status)
        VALUES (?, ?, ?, ?, GETDATE(), 1)
    """;
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, u.getRoleId());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPassword());
            ps.setString(4, u.getName());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("❌ Insert user failed: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // ✅ Cập nhật user
    public boolean update(User u) {
        String sql = "UPDATE Users SET role_id=?, email=?, password=?, name=? WHERE user_id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, u.getRoleId());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPassword());
            ps.setString(4, u.getName());
            ps.setInt(5, u.getUserId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Update user failed: " + e.getMessage());
        }
        return false;
    }

    // ✅ Kiểm tra trùng email
    public boolean existsByEmail(String email) {
        String sql = "SELECT COUNT(*) FROM Users WHERE email = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("email: ");
        String email = scanner.nextLine();
        System.out.println("password: ");
        String password = scanner.nextLine();
        UserDAO userdao = new UserDAO();
        User user = userdao.login(email, password);
        System.out.println("email: " + user.getEmail() + " password: " + user.getPassword());

    }
}
