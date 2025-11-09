package com.example.primaryschoolwebapp.DAO;

import com.example.primaryschoolwebapp.Model.Student;
import com.example.primaryschoolwebapp.Util.DatabaseUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {

    public List<Student> listAll() throws SQLException {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM students ORDER BY id DESC";

        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Student student = mapResultSetToStudent(rs);
                students.add(student);
            }
        } catch (SQLException e) {
            System.err.println("Error listing students: " + e.getMessage());
            throw e;
        }
        return students;
    }

    public Student findById(int id) throws SQLException {
        String sql = "SELECT * FROM students WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            System.out.println("Searching for student with ID: " + id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Student student = mapResultSetToStudent(rs);
                    System.out.println("Found student: " + student.getName() + " " + student.getSurname() + " with ID: " + student.getId());
                    return student;
                } else {
                    System.out.println("No student found with ID: " + id);
                    return null;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error finding student by ID " + id + ": " + e.getMessage());
            throw e;
        }
    }

    public boolean add(Student student) throws SQLException {
        String sql = "INSERT INTO students (name, surname, birth_certificate_no, gender, date_of_birth, address, " +
                "guardian_name, guardian_contact, guardian_email, current_class, status, registration_date) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            // Basic Information
            stmt.setString(1, student.getName());
            stmt.setString(2, student.getSurname());
            stmt.setString(3, student.getBirthCertificateNo());
            stmt.setString(4, student.getGender());

            // Handle date of birth - REQUIRED in your schema
            if (student.getDob() != null) {
                stmt.setDate(5, Date.valueOf(student.getDob()));
            } else {
                throw new SQLException("Date of birth is required");
            }

            stmt.setString(6, student.getAddress());

            // Guardian fields - REQUIRED
            stmt.setString(7, student.getGuardianName());
            stmt.setString(8, student.getGuardianContact());
            stmt.setString(9, student.getGuardianEmail());
            stmt.setString(10, student.getCurrentClass());
            stmt.setString(11, student.getStatus() != null ? student.getStatus() : "Active");

            // Registration date - REQUIRED in your schema
            stmt.setDate(12, new Date(System.currentTimeMillis()));

            int result = stmt.executeUpdate();

            // Get the generated ID
            if (result > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        student.setId(generatedKeys.getInt(1));
                        System.out.println("Student added with ID: " + student.getId());
                    }
                }
            }

            return result > 0;
        } catch (SQLException e) {
            System.err.println("Error adding student: " + e.getMessage());
            System.err.println("Student details: " + student.getName() + " " + student.getSurname());
            throw e;
        }
    }

    public boolean update(Student student) throws SQLException {
        String sql = "UPDATE students SET name = ?, surname = ?, gender = ?, date_of_birth = ?, address = ?, " +
                "guardian_name = ?, guardian_contact = ?, guardian_email = ?, current_class = ?, status = ? " +
                "WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, student.getName());
            stmt.setString(2, student.getSurname());
            stmt.setString(3, student.getGender());

            // Handle date of birth - REQUIRED
            if (student.getDob() != null) {
                stmt.setDate(4, Date.valueOf(student.getDob()));
            } else {
                throw new SQLException("Date of birth is required");
            }

            stmt.setString(5, student.getAddress());

            // Guardian fields
            stmt.setString(6, student.getGuardianName());
            stmt.setString(7, student.getGuardianContact());
            stmt.setString(8, student.getGuardianEmail());
            stmt.setString(9, student.getCurrentClass());
            stmt.setString(10, student.getStatus() != null ? student.getStatus() : "Active");
            stmt.setInt(11, student.getId());

            int result = stmt.executeUpdate();
            System.out.println("Update result for student ID " + student.getId() + ": " + result);
            return result > 0;
        } catch (SQLException e) {
            System.err.println("Error updating student ID " + student.getId() + ": " + e.getMessage());
            throw e;
        }
    }

    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM students WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            int result = stmt.executeUpdate();
            System.out.println("Delete result for student ID " + id + ": " + result);
            return result > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting student ID " + id + ": " + e.getMessage());
            throw e;
        }
    }

    private Student mapResultSetToStudent(ResultSet rs) throws SQLException {
        Student student = new Student();
        try {
            // Map ID first - this is crucial
            student.setId(rs.getInt("id"));
            System.out.println("Mapping student with ID: " + student.getId());

            student.setName(rs.getString("name"));
            student.setSurname(rs.getString("surname"));
            student.setBirthCertificateNo(rs.getString("birth_certificate_no"));
            student.setGender(rs.getString("gender"));

            // Map date_of_birth to dob
            Date dateOfBirth = rs.getDate("date_of_birth");
            if (dateOfBirth != null) {
                student.setDob(dateOfBirth.toLocalDate());
            }

            student.setAddress(rs.getString("address"));

            // Guardian fields
            student.setGuardianName(rs.getString("guardian_name"));
            student.setGuardianContact(rs.getString("guardian_contact"));
            student.setGuardianEmail(rs.getString("guardian_email"));
            student.setCurrentClass(rs.getString("current_class"));
            student.setStatus(rs.getString("status"));

            System.out.println("Successfully mapped student: " + student.getName() + " " + student.getSurname() + " ID: " + student.getId());
        } catch (SQLException e) {
            System.err.println("Error mapping ResultSet to Student: " + e.getMessage());
            throw e;
        }
        return student;
    }
}