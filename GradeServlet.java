package com.example.primaryschoolwebapp.Controller;

import com.example.primaryschoolwebapp.DAO.StudentDAO;
import com.example.primaryschoolwebapp.DAO.ClassDAO;
import com.example.primaryschoolwebapp.DAO.GradeDAO;
import com.example.primaryschoolwebapp.Model.Grade;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name="GradeServlet", urlPatterns = {"/grades","/grades/*"})
public class GradeServlet extends HttpServlet {
    private GradeDAO gradeDAO;
    private StudentDAO studentDAO;
    private ClassDAO classDAO;

    @Override
    public void init() throws ServletException {
        try {
            gradeDAO = new GradeDAO();
            studentDAO = new StudentDAO();
            classDAO = new ClassDAO();
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String p = req.getPathInfo();
        if (p == null || "/".equals(p)) {
            // show grade form (needs students & classes)
            try {
                req.setAttribute("students", studentDAO.listAll());
                req.setAttribute("classes", classDAO.listAll());
                req.getRequestDispatcher("/WEB-INF/views/Grade-form.jsp").forward(req, resp);
            } catch (Exception e) {
                throw new ServletException(e);
            }
            return;
        }
        if ("/top5".equals(p)) {
            try {
                int classId = Integer.parseInt(req.getParameter("classId"));
                List<GradeDAO.ResultRow> rows = gradeDAO.topStudentsByClass(classId, 5);
                req.setAttribute("rows", rows);
                req.getRequestDispatcher("/WEB-INF/views/top5.jsp").forward(req, resp);
            } catch (Exception e) {
                throw new ServletException(e);
            }
            return;
        }
        resp.sendError(HttpServletResponse.SC_NOT_FOUND);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // /grades/save
        String path = req.getPathInfo();
        if ("/save".equals(path)) {
            try {
                Grade g = new Grade();
                g.setStudentId(Integer.parseInt(req.getParameter("studentId")));
                g.setClassId(Integer.parseInt(req.getParameter("classId")));
                g.setSubjectId(Integer.parseInt(req.getParameter("subjectId")));
                g.setTerm(req.getParameter("term"));
                g.setMarks(Double.parseDouble(req.getParameter("marks")));
                gradeDAO.addGrade(g);
                resp.sendRedirect(req.getContextPath() + "/grades");
            } catch (Exception e) {
                throw new ServletException(e);
            }
            return;
        }
        resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
    }
}