package com.example.primaryschoolwebapp.Controller;

import com.example.primaryschoolwebapp.DAO.StudentDAO;
import com.example.primaryschoolwebapp.Model.Student;
import com.example.primaryschoolwebapp.Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name="DashboardServlet", urlPatterns = {"/dashboard"})
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession s = req.getSession(false);
        if (s == null || s.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }
        User u = (User) s.getAttribute("user");
        req.setAttribute("role", u.getRole());
        req.getRequestDispatcher("/WEB-INF/views/Dashboard.jsp").forward(req, resp);
    }
}