package com.rdo.servlet;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.rdo.dao.WorkReportDAO;
import com.rdo.model.WorkReport;

@WebServlet("/MyReportsServlet")
public class MyReportsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer officerId = (Integer) session.getAttribute("officerId");
        
        if(officerId == null) {
            response.sendRedirect("login.html");
            return;
        }
        
        WorkReportDAO dao = new WorkReportDAO();
        List<WorkReport> reports = dao.getReportsByOfficer(officerId);
        
        request.setAttribute("reports", reports);
        request.getRequestDispatcher("myReports.jsp").forward(request, response);
    }
}