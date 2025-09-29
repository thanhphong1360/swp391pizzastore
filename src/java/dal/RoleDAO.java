/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.Role;

/**
 *
 * @author cungp
 */
public class RoleDAO {
    
    public static Role getRoleById(int id){
        String sql = "SELECT * FROM Roles WHERE role_id = ?";

        try {
            DBContext db = DBContext.getInstance();
            Connection conn = db.connection;

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Role role = new Role();
                role.setRoleId(rs.getInt("role_id"));
                role.setRoleName(rs.getString("role_name"));
                role.setDescription(rs.getString("description"));
                return role;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
