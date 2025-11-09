package com.example.primaryschoolwebapp.Controller;

import com.example.primaryschoolwebapp.DAO.StudentDAO;
import com.example.primaryschoolwebapp.Model.Student;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet(name = "StudentServlet", urlPatterns = {"/students", "/students/*"})
public class StudentServlet extends HttpServlet {

    private StudentDAO dao;

    @Override
    public void init() throws ServletException {
        try {
            dao = new StudentDAO();
        } catch (Exception e) {
            throw new ServletException("Error initializing StudentDAO", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getPathInfo();

        System.out.println("=== StudentServlet doGet ===");
        System.out.println("Action: " + action);

        if (action == null || "/".equals(action)) {
            listStudents(req, resp);
            return;
        }

        switch (action) {
            case "/add":
                showAddForm(req, resp);
                break;
            case "/edit":
                showEditForm(req, resp);
                break;
            case "/delete":
                deleteStudent(req, resp);
                break;
            case "/details":
                showDetails(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void listStudents(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<Student> students = dao.listAll();
            req.setAttribute("students", students);
            req.getRequestDispatcher("/Student-list.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Error retrieving students: " + e.getMessage());
            req.getRequestDispatcher("/Student-list.jsp").forward(req, resp);
        }
    }

    private void showAddForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("student", new Student());
        req.setAttribute("formAction", "add");
        req.getRequestDispatcher("/Student-form.jsp").forward(req, resp);
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            Student student = dao.findById(id);
            if (student != null) {
                req.setAttribute("student", student);
                req.setAttribute("formAction", "edit");
                req.getRequestDispatcher("/Student-form.jsp").forward(req, resp);
            } else {
                req.getSession().setAttribute("error", "Student not found with ID: " + id);
                resp.sendRedirect(req.getContextPath() + "/students");
            }
        } catch (NumberFormatException e) {
            req.getSession().setAttribute("error", "Invalid student ID");
            resp.sendRedirect(req.getContextPath() + "/students");
        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("error", "Error loading student: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/students");
        }
    }

    private void showDetails(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            Student student = dao.findById(id);
            if (student != null) {
                req.setAttribute("student", student);
                req.setAttribute("formAction", "details");
                req.getRequestDispatcher("/Student-form.jsp").forward(req, resp);
            } else {
                req.getSession().setAttribute("error", "Student not found with ID: " + id);
                resp.sendRedirect(req.getContextPath() + "/students");
            }
        } catch (NumberFormatException e) {
            req.getSession().setAttribute("error", "Invalid student ID");
            resp.sendRedirect(req.getContextPath() + "/students");
        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("error", "Error loading student details: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/students");
        }
    }

    private void deleteStudent(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            boolean deleted = dao.delete(id);
            if (deleted) {
                req.getSession().setAttribute("message", "Student deleted successfully");
            } else {
                req.getSession().setAttribute("error", "Failed to delete student");
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("error", "Error deleting student: " + e.getMessage());
        }
        resp.sendRedirect(req.getContextPath() + "/students");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String formAction = req.getParameter("formAction");

        System.out.println("=== StudentServlet doPost ===");
        System.out.println("Form Action: " + formAction);
        System.out.println("Parameters received:");
        req.getParameterMap().forEach((key, value) -> {
            System.out.println("  " + key + ": " + String.join(", ", value));
        });

        if ("add".equals(formAction) || "edit".equals(formAction)) {
            try {
                saveStudent(req, resp);
            } catch (Exception e) {
                e.printStackTrace();
                // Show error on the form instead of redirecting
                Student student = getStudentFromRequest(req);
                req.setAttribute("student", student);
                req.setAttribute("formAction", formAction);
                String errorMessage = e.getMessage() != null ? e.getMessage() : "An unknown error occurred";
                req.setAttribute("error", "Error: " + errorMessage);
                req.getRequestDispatcher("/Student-form.jsp").forward(req, resp);
            }
        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid form action: " + formAction);
        }
    }

    private void saveStudent(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String idStr = req.getParameter("id");
        Student student;

        if ("add".equals(req.getParameter("formAction"))) {
            student = new Student();
            System.out.println("Creating NEW student");
        } else {
            int id = Integer.parseInt(idStr);
            student = dao.findById(id);
            if (student == null) {
                throw new Exception("Student not found with ID: " + id);
            }
            System.out.println("Editing EXISTING student ID: " + id);
        }

        // Get and validate parameters - Basic Information
        String name = req.getParameter("name");
        String surname = req.getParameter("surname");
        String birthCertificateNo = req.getParameter("birthCertificateNo");
        String gender = req.getParameter("gender");
        String address = req.getParameter("address");
        String dobStr = req.getParameter("dob");
        String status = req.getParameter("status");

        // Get and validate parameters - Guardian Information
        String guardianName = req.getParameter("guardianName");
        String guardianContact = req.getParameter("guardianContact");
        String guardianEmail = req.getParameter("guardianEmail");
        String currentClass = req.getParameter("currentClass");

        System.out.println("=== Parsed Parameters ===");
        System.out.println("Basic Information:");
        System.out.println("  Name: " + name);
        System.out.println("  Surname: " + surname);
        System.out.println("  Birth Cert: " + birthCertificateNo);
        System.out.println("  Gender: " + gender);
        System.out.println("  Address: " + address);
        System.out.println("  DOB: " + dobStr);
        System.out.println("  Status: " + status);
        System.out.println("Guardian Information:");
        System.out.println("  Guardian Name: " + guardianName);
        System.out.println("  Guardian Contact: " + guardianContact);
        System.out.println("  Guardian Email: " + guardianEmail);
        System.out.println("  Current Class: " + currentClass);

        // Validate required fields - Basic Information
        if (name == null || name.trim().isEmpty()) {
            throw new Exception("First Name is required");
        }
        if (surname == null || surname.trim().isEmpty()) {
            throw new Exception("Surname is required");
        }
        if (birthCertificateNo == null || birthCertificateNo.trim().isEmpty()) {
            throw new Exception("Birth Certificate Number is required");
        }
        if (gender == null || gender.trim().isEmpty()) {
            throw new Exception("Gender is required");
        }
        if (dobStr == null || dobStr.trim().isEmpty()) {
            throw new Exception("Date of Birth is required");
        }
        if (address == null || address.trim().isEmpty()) {
            throw new Exception("Address is required");
        }

        // Validate required fields - Guardian Information
        if (guardianName == null || guardianName.trim().isEmpty()) {
            throw new Exception("Guardian Name is required");
        }
        if (guardianContact == null || guardianContact.trim().isEmpty()) {
            throw new Exception("Guardian Contact is required");
        }
        if (currentClass == null || currentClass.trim().isEmpty()) {
            throw new Exception("Current Class is required");
        }

        // Set student properties - Basic Information
        student.setName(name.trim());
        student.setSurname(surname.trim());
        student.setBirthCertificateNo(birthCertificateNo.trim());
        student.setGender(gender);
        student.setAddress(address);
        student.setStatus(status != null && !status.trim().isEmpty() ? status : "Active");

        // Set student properties - Guardian Information
        student.setGuardianName(guardianName.trim());
        student.setGuardianContact(guardianContact.trim());
        student.setGuardianEmail(guardianEmail != null ? guardianEmail.trim() : null);
        student.setCurrentClass(currentClass);

        // Handle date of birth - REQUIRED
        if (dobStr != null && !dobStr.trim().isEmpty()) {
            try {
                student.setDob(LocalDate.parse(dobStr));
                System.out.println("Parsed DOB: " + student.getDob());
            } catch (Exception e) {
                System.out.println("Invalid date format: " + dobStr);
                throw new Exception("Invalid date format. Please use YYYY-MM-DD format.");
            }
        } else {
            throw new Exception("Date of Birth is required");
        }

        // Save to database
        boolean success;
        if ("add".equals(req.getParameter("formAction"))) {
            System.out.println("Attempting to ADD student to database...");
            success = dao.add(student);
            if (success) {
                System.out.println("Student added successfully!");
                req.getSession().setAttribute("message", "Student added successfully");
            } else {
                System.out.println("Failed to add student!");
                throw new Exception("Failed to add student. Birth certificate number might already exist.");
            }
        } else {
            System.out.println("Attempting to UPDATE student in database...");
            success = dao.update(student);
            if (success) {
                System.out.println("Student updated successfully!");
                req.getSession().setAttribute("message", "Student updated successfully");
            } else {
                System.out.println("Failed to update student!");
                throw new Exception("Failed to update student");
            }
        }

        resp.sendRedirect(req.getContextPath() + "/students");
    }

    private Student getStudentFromRequest(HttpServletRequest req) {
        Student student = new Student();

        // Basic Information
        student.setName(req.getParameter("name"));
        student.setSurname(req.getParameter("surname"));
        student.setBirthCertificateNo(req.getParameter("birthCertificateNo"));
        student.setGender(req.getParameter("gender"));
        student.setAddress(req.getParameter("address"));
        student.setStatus(req.getParameter("status"));

        // Guardian Information
        student.setGuardianName(req.getParameter("guardianName"));
        student.setGuardianContact(req.getParameter("guardianContact"));
        student.setGuardianEmail(req.getParameter("guardianEmail"));
        student.setCurrentClass(req.getParameter("currentClass"));

        // Handle date of birth
        String dobStr = req.getParameter("dob");
        if (dobStr != null && !dobStr.trim().isEmpty()) {
            try {
                student.setDob(LocalDate.parse(dobStr));
            } catch (Exception e) {
                System.out.println("Warning: Invalid date format in getStudentFromRequest: " + dobStr);
                // Ignore invalid date for form repopulation
            }
        }

        // Handle ID
        String idStr = req.getParameter("id");
        if (idStr != null && !idStr.trim().isEmpty()) {
            try {
                student.setId(Integer.parseInt(idStr));
            } catch (NumberFormatException e) {
                System.out.println("Warning: Invalid ID format: " + idStr);
                // Ignore invalid ID for form repopulation
            }
        }

        return student;
    }
}