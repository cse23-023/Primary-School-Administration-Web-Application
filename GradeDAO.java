package com.example.primaryschoolwebapp.DAO;

import com.example.primaryschoolwebapp.Model.Grade;
import com.example.primaryschoolwebapp.Util.DatabaseUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class GradeDAO {

    public static class ResultRow {
        private String studentName;
        private double averageMarks;

        public ResultRow(String studentName, double averageMarks) {
            this.studentName = studentName;
            this.averageMarks = averageMarks;
        }

        // Getters and setters
        public String getStudentName() { return studentName; }
        public void setStudentName(String studentName) { this.studentName = studentName; }
        public double getAverageMarks() { return averageMarks; }
        public void setAverageMarks(double averageMarks) { this.averageMarks = averageMarks; }
    }

    public boolean addGrade(Grade grade) throws SQLException {
        String sql = "INSERT INTO grades (student_id, class_id, subject, marks, term) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, grade.getStudentId());
            stmt.setInt(2, grade.getClassId());
            stmt.setString(3, grade.getSubject());
            stmt.setDouble(4, grade.getMarks());
            stmt.setString(5, grade.getTerm());

            return stmt.executeUpdate() > 0;
        }
    }

    public List<ResultRow> topStudentsByClass(int classId, int limit) throws SQLException {
        List<ResultRow> results = new ArrayList<>();
        String sql = "SELECT s.name, s.surname, AVG(g.marks) as avg_marks " +
                "FROM grades g " +
                "JOIN students s ON g.student_id = s.id " +
                "WHERE g.class_id = ? " +
                "GROUP BY g.student_id, s.name, s.surname " +
                "ORDER BY avg_marks DESC " +
                "LIMIT ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, classId);
            stmt.setInt(2, limit);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    String studentName = rs.getString("name") + " " + rs.getString("surname");
                    double avgMarks = rs.getDouble("avg_marks");
                    results.add(new ResultRow(studentName, avgMarks));
                }
            }
        }
        return results;
    }

    public List<Grade> getGradesByStudent(int studentId) throws SQLException {
        List<Grade> grades = new ArrayList<>();
        String sql = "SELECT * FROM grades WHERE student_id = ? ORDER BY term, subject";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, studentId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Grade grade = new Grade();
                    grade.setId(rs.getInt("id"));
                    grade.setStudentId(rs.getInt("student_id"));
                    grade.setClassId(rs.getInt("class_id"));
                    grade.setSubject(rs.getString("subject"));
                    grade.setMarks(rs.getDouble("marks"));
                    grade.setTerm(rs.getString("term"));
                    grades.add(grade);
                }
            }
        }
        return grades;
    }
}