<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    com.rdo.model.Officer officer = (com.rdo.model.Officer) session.getAttribute("officer");
    if(officer == null) {
        response.sendRedirect("login.html");
        return;
    }
    
    java.util.List<com.rdo.model.WorkReport> reports = (java.util.List<com.rdo.model.WorkReport>) request.getAttribute("reports");
    if(reports == null) {
        reports = new java.util.ArrayList<>();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Reports - RDO</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #f5f5f5; }
        .header { background: linear-gradient(135deg, #FF9933, #FFCC66); color: white; padding: 15px; display: flex; justify-content: space-between; align-items: center; }
        .header-left { display: flex; align-items: center; gap: 15px; }
        .header-left img { height: 60px; }
        .nav { background: #138808; padding: 12px; }
        .nav a { color: white; text-decoration: none; padding: 10px 20px; margin: 0 5px; display: inline-block; }
        .nav a:hover { background: #0a5a06; border-radius: 5px; }
        .container { max-width: 1200px; margin: 30px auto; padding: 0 20px; }
        .report-table { background: white; border-radius: 10px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .report-table table { width: 100%; border-collapse: collapse; }
        .report-table th { background: #FF9933; color: white; padding: 12px; text-align: left; }
        .report-table td { padding: 12px; border-bottom: 1px solid #ddd; }
        .status-approved { color: #138808; font-weight: bold; }
        .status-pending { color: #ff9800; font-weight: bold; }
        .footer { background: #2c3e50; color: white; text-align: center; padding: 20px; margin-top: 40px; }
        .no-data { text-align: center; padding: 40px; color: #666; }
        h2 { margin-bottom: 20px; color: #333; }
    </style>
</head>
<body>
<div class="header">
    <div class="header-left">
        <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/55/Emblem_of_India.svg/1200px-Emblem_of_India.svg.png" alt="Emblem">
        <div><h2>RDO Monitoring System</h2><small>Chhattisgarh Panchayat and Rural Development</small></div>
    </div>
    <div><strong><%= officer.getFullName() %></strong><br><a href="LogoutServlet" style="color: white;">Logout</a></div>
</div>
<div class="nav">
    <a href="dashboard.jsp">Home</a>
    <a href="submitReport.jsp">Submit Report</a>
    <a href="MyReportsServlet">My Reports</a>
    <a href="schemes.jsp">View Schemes</a>
</div>
<div class="container">
    <h2>My Submitted Reports</h2>
    <div class="report-table">
        <table>
            <thead><tr><th>ID</th><th>Date</th><th>Village</th><th>Gram Panchayat</th><th>Scheme</th><th>Beneficiaries</th><th>Funds (Rs.)</th><th>Status</th></tr></thead>
            <tbody>
                <% if(reports.isEmpty()) { %>
                <tr><td colspan="8" class="no-data">No reports submitted yet</td></tr>
                <% } else { 
                    for(com.rdo.model.WorkReport report : reports) {
                %>
                <tr>
                    <td><%= report.getReportId() %></td>
                    <td><%= report.getReportDate() %></td>
                    <td><%= report.getVillageName() %></td>
                    <td><%= report.getGramPanchayat() != null ? report.getGramPanchayat() : "-" %></td>
                    <td><%= report.getSchemeName() %></td>
                    <td><%= report.getBeneficiariesCount() %></td>
                    <td>Rs. <%= String.format("%,.2f", report.getFundsUtilized()) %></td>
                    <td class="status-<%= report.getStatus() %>"><%= report.getStatus().toUpperCase() %></td>
                </tr>
                <%      }
                } %>
            </tbody>
        </table>
    </div>
</div>
<div class="footer"><p>(c) 2026 Panchayat and Rural Development Department, Government of Chhattisgarh</p></div>
</body>
</html>