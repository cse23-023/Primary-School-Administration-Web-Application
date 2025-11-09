package com.example.primaryschoolwebapp.Controller;

import com.example.primaryschoolwebapp.Model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = {"/students/*"})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession s = req.getSession(false);
        if (s != null && s.getAttribute("user") != null) {
            chain.doFilter(request, response);
            return;
        }
        resp.sendRedirect(req.getContextPath() + "/login.jsp");
    }
}