package com.example.primaryschoolwebapp.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/debug-add")
public class DebugServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();

        out.println("<h1>Debug Add Student</h1>");
        out.println("<form method='post' action='students'>");
        out.println("<input type='hidden' name='formAction' value='add'>");
        out.println("Name: <input type='text' name='name' value='John'><br>");
        out.println("Surname: <input type='text' name='surname' value='Doe'><br>");
        out.println("Birth Cert: <input type='text' name='birthCertificateNo' value='BC123456'><br>");
        out.println("Gender: <select name='gender'><option value='M'>Male</option></select><br>");
        out.println("Address: <input type='text' name='address' value='Test Address'><br>");
        out.println("<button type='submit'>Test Add</button>");
        out.println("</form>");
    }
}