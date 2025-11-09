package com.example.primaryschoolwebapp.DAO;



import com.example.primaryschoolwebapp.Model.ClassRoom;
import com.example.primaryschoolwebapp.Util.DatabaseUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClassDAO {

    public List<ClassRoom> listAll() throws SQLException {
        List<ClassRoom> classes = new ArrayList<>();
        String sql = "SELECT * FROM classes ORDER BY id DESC";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                ClassRoom classRoom = new ClassRoom();
                classRoom.setId(rs.getInt("id"));
                classRoom.setClassName(rs.getString("class_name"));
                classRoom.setGradeLevel(rs.getString("grade_level"));
                classRoom.setTeacherName(rs.getString("teacher_name"));
                classes.add(classRoom);
            }
        }
        return classes;
    }

    public ClassRoom findById(int id) throws SQLException {
        String sql = "SELECT * FROM classes WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    ClassRoom classRoom = new ClassRoom();
                    classRoom.setId(rs.getInt("id"));
                    classRoom.setClassName(rs.getString("class_name"));
                    classRoom.setGradeLevel(rs.getString("grade_level"));
                    classRoom.setTeacherName(rs.getString("teacher_name"));
                    return classRoom;
                }
            }
        }
        return null;
    }

    public boolean add(ClassRoom classRoom) throws SQLException {
        String sql = "INSERT INTO classes (class_name, grade_level, teacher_name) VALUES (?, ?, ?)";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, classRoom.getClassName());
            stmt.setString(2, classRoom.getGradeLevel());
            stmt.setString(3, classRoom.getTeacherName());

            return stmt.executeUpdate() > 0;
        }
    }

    public boolean update(ClassRoom classRoom) throws SQLException {
        String sql = "UPDATE classes SET class_name = ?, grade_level = ?, teacher_name = ? WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, classRoom.getClassName());
            stmt.setString(2, classRoom.getGradeLevel());
            stmt.setString(3, classRoom.getTeacherName());
            stmt.setInt(4, classRoom.getId());

            return stmt.executeUpdate() > 0;
        }
    }

    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM classes WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }

    public void add(int id) {
    }
}