package com.example.primaryschoolwebapp.Controller;

import com.example.primaryschoolwebapp.DAO.UserDAO;
import com.example.primaryschoolwebapp.Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name="AuthServlet", urlPatterns = {"/auth/login", "/auth/logout"})
public class AuthServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        try {
            userDAO = new UserDAO();
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getRequestURI().endsWith("/logout")) {
            HttpSession session = req.getSession(false);
            if (session != null) session.invalidate();
        }
        resp.sendRedirect(req.getContextPath() + "/login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String usernameOrEmail = req.getParameter("username");
        String password = req.getParameter("password");

        try {
            User user = userDAO.login(usernameOrEmail, password);

            if (user == null) {
                req.setAttribute("error", "Invalid username or password");
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
                return;
            }

            HttpSession session = req.getSession(true);
            session.setAttribute("user", user);

            resp.sendRedirect(req.getContextPath() + "/students");

        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendError(500, "Database error");
        }
    }
}