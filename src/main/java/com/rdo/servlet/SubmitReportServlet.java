package com.rdo.servlet;

import java.io.IOException;
import java.sql.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.rdo.dao.WorkReportDAO;
import com.rdo.model.WorkReport;

@WebServlet("/SubmitReportServlet")
public class SubmitReportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer officerId = (Integer) session.getAttribute("officerId");
        
        if(officerId == null) {
            response.sendRedirect("login.html");
            return;
        }
        
        try {
            // Get form data
            String reportDateStr = request.getParameter("reportDate");
            Date reportDate = Date.valueOf(reportDateStr);
            
            String villageName = request.getParameter("villageName");
            String gramPanchayat = request.getParameter("gramPanchayat");
            int schemeId = Integer.parseInt(request.getParameter("schemeId"));
            String workDescription = request.getParameter("workDescription");
            int beneficiariesCount = Integer.parseInt(request.getParameter("beneficiariesCount"));
            double fundsUtilized = Double.parseDouble(request.getParameter("fundsUtilized"));
            String gpsLocation = request.getParameter("gpsLocation");
            
            // Create report object
            WorkReport report = new WorkReport();
            report.setOfficerId(officerId);
            report.setReportDate(reportDate);
            report.setVillageName(villageName);
            report.setGramPanchayat(gramPanchayat);
            report.setSchemeId(schemeId);
            report.setWorkDescription(workDescription);
            report.setBeneficiariesCount(beneficiariesCount);
            report.setFundsUtilized(fundsUtilized);
            report.setGpsLocation(gpsLocation);
            
            // Save to database
            WorkReportDAO dao = new WorkReportDAO();
            boolean result = dao.submitReport(report);
            
            if(result) {
                response.sendRedirect("submitReport.jsp?success=true");
            } else {
                response.sendRedirect("submitReport.jsp?error=true");
            }
            
        } catch(Exception e) {
            e.printStackTrace();
            response.sendRedirect("submitReport.jsp?error=true");
        }
    }
}