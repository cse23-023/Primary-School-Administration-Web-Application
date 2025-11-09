package com.example.primaryschoolwebapp.Controller;

import com.example.primaryschoolwebapp.DAO.ClassDAO;
import com.example.primaryschoolwebapp.Model.ClassRoom;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name="ClassServlet", urlPatterns = {"/classes","/classes/*"})
public class ClassServlet extends HttpServlet {
    private ClassDAO dao;

    @Override
    public void init() throws ServletException {
        try {
            dao = new ClassDAO();
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if (path == null || "/".equals(path)) {
            list(req, resp);
            return;
        }
        switch (path) {
            case "/add":
                req.getRequestDispatcher("/WEB-INF/views/Class-form.jsp").forward(req, resp);
                break;
            case "/edit":
                edit(req, resp);
                break;
            case "/delete":
                delete(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<ClassRoom> list = dao.listAll();
            req.setAttribute("classes", list);
            req.getRequestDispatcher("/WEB-INF/views/Class-list.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void edit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            ClassRoom cr = dao.findById(id);
            req.setAttribute("classroom", cr);
            req.getRequestDispatcher("/WEB-INF/views/Class-form.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            dao.delete(id);
            resp.sendRedirect(req.getContextPath() + "/classes");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        try {
            if ("/save".equals(path)) {
                save(req, resp);
            } else {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void save(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String id = req.getParameter("id");
        String name = req.getParameter("name");
        String desc = req.getParameter("description");

        ClassRoom cr;
        if (id == null || id.isBlank()) {
            cr = new ClassRoom();
            cr.setName(name);
            cr.setDescription(desc);
            dao.add(cr.getId());
        } else {
            cr = dao.findById(Integer.parseInt(id));
            cr.setName(name);
            cr.setDescription(desc);
            dao.update(cr);
        }
        resp.sendRedirect(req.getContextPath() + "/classes");
    }
}