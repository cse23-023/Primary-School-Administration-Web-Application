package com.example.primaryschoolwebapp.DAO;

import com.example.primaryschoolwebapp.Model.User;
import com.example.primaryschoolwebapp.Util.DatabaseUtil;
import java.sql.*;
import java.time.LocalDateTime;

public class UserDAO {

    public User login(String usernameOrEmail, String password) throws SQLException {
        String sql = "SELECT * FROM users WHERE (username = ? OR email = ?) AND password = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, usernameOrEmail);
            stmt.setString(2, usernameOrEmail);
            stmt.setString(3, password);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                    user.setName(rs.getString("name"));
                    user.setRole(rs.getString("role"));
                    user.setCreatedAt(rs.getObject("created_at", LocalDateTime.class));
                    return user;
                }
            }
        }
        return null;
    }

    public boolean addUser(User user) throws SQLException {
        String sql = "INSERT INTO users (username, email, password, name, role) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getName());
            stmt.setString(5, user.getRole());

            return stmt.executeUpdate() > 0;
        }
    }

    public User findByUsername(String username) throws SQLException {
        String sql = "SELECT * FROM users WHERE username = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                    user.setName(rs.getString("name"));
                    user.setRole(rs.getString("role"));
                    user.setCreatedAt(rs.getObject("created_at", LocalDateTime.class));
                    return user;
                }
            }
        }
        return null;
    }
}