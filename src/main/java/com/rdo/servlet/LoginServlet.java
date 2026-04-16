package com.rdo.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.rdo.dao.OfficerDAO;
import com.rdo.model.Officer;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String employeeCode = request.getParameter("employeeCode");
        String password = request.getParameter("password");
        
        OfficerDAO dao = new OfficerDAO();
        Officer officer = dao.validateLogin(employeeCode, password);
        
        if(officer != null) {
            HttpSession session = request.getSession();
            session.setAttribute("officer", officer);
            session.setAttribute("officerId", officer.getOfficerId());
            session.setAttribute("officerName", officer.getFullName());
            response.sendRedirect("dashboard.jsp");
        } else {
            response.sendRedirect("login.html?error=invalid");
        }
    }
}