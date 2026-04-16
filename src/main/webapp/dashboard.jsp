<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    com.rdo.model.Officer officer = (com.rdo.model.Officer) session.getAttribute("officer");
    if(officer == null) {
        response.sendRedirect("login.html");
        return;
    }
    
    com.rdo.dao.WorkReportDAO reportDAO = new com.rdo.dao.WorkReportDAO();
    com.rdo.dao.SchemeDAO schemeDAO = new com.rdo.dao.SchemeDAO();
    java.util.List<?> reports = reportDAO.getReportsByOfficer(officer.getOfficerId());
    int reportCount = reports.size();
    int schemeCount = schemeDAO.getAllSchemes().size();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard - <%= officer.getFullName() %></title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #f5f5f5; }
        .header { background: linear-gradient(135deg, #FF9933, #FFCC66); color: white; padding: 15px; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; }
        .header-left { display: flex; align-items: center; gap: 15px; }
        .header-left img { height: 60px; }
        .nav { background: #138808; padding: 12px; }
        .nav a { color: white; text-decoration: none; padding: 10px 20px; margin: 0 5px; display: inline-block; }
        .nav a:hover { background: #0a5a06; border-radius: 5px; }
        .container { max-width: 1200px; margin: 30px auto; padding: 0 20px; }
        .welcome-card { background: white; padding: 20px; border-radius: 10px; margin-bottom: 30px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); border-left: 5px solid #FF9933; }
        .stats { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; margin-bottom: 30px; }
        .stat-card { background: white; padding: 25px; border-radius: 10px; text-align: center; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .stat-card h3 { font-size: 36px; color: #138808; margin: 10px 0; }
        .recent-table { background: white; border-radius: 10px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .recent-table table { width: 100%; border-collapse: collapse; }
        .recent-table th { background: #FF9933; color: white; padding: 12px; text-align: left; }
        .recent-table td { padding: 12px; border-bottom: 1px solid #ddd; }
        .status-approved { color: #138808; font-weight: bold; }
        .status-pending { color: #ff9800; font-weight: bold; }
        .footer { background: #2c3e50; color: white; text-align: center; padding: 20px; margin-top: 40px; }
    </style>
</head>
<body>
<div class="header">
    <div class="header-left">
        <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/55/Emblem_of_India.svg/1200px-Emblem_of_India.svg.png" alt="Emblem">
        <div><h2>RDO Monitoring System</h2><small>Chhattisgarh Panchayat and Rural Development</small></div>
    </div>
    <div><strong><%= officer.getFullName() %></strong><br><small><%= officer.getDesignation() %> | <%= officer.getDistrict() %></small><br><a href="LogoutServlet" style="color: white;">Logout</a></div>
</div>
<div class="nav">
    <a href="dashboard.jsp">Home</a>
    <a href="submitReport.jsp">Submit Report</a>
    <a href="MyReportsServlet">My Reports</a>
    <a href="schemes.jsp">View Schemes</a>
</div>
<div class="container">
    <div class="welcome-card">
        <h2>Welcome, <%= officer.getFullName() %>!</h2>
        <p>Block: <%= officer.getBlockName() %> | District: <%= officer.getDistrict() %></p>
        <p>Today's Date: <%= new java.util.Date() %></p>
    </div>
    <div class="stats">
        <div class="stat-card"><p>Total Reports</p><h3><%= reportCount %></h3></div>
        <div class="stat-card"><p>Active Schemes</p><h3><%= schemeCount %></h3></div>
        <div class="stat-card"><p>Villages Covered</p><h3>12</h3></div>
        <div class="stat-card"><p>Approved Reports</p><h3>8</h3></div>
    </div>
    <h3>Recent Work Reports</h3>
    <div class="recent-table">
        <table>
            <thead><tr><th>Date</th><th>Village</th><th>Scheme</th><th>Beneficiaries</th><th>Status</th></tr></thead>
            <tbody>
                <% if(reports.isEmpty()) { %>
                <tr><td colspan="5" style="text-align: center;">No reports submitted yet</td></tr>
                <% } else { 
                    int count = 0;
                    for(Object obj : reports) {
                        if(count++ >= 5) break;
                        com.rdo.model.WorkReport report = (com.rdo.model.WorkReport) obj;
                %>
                <tr>
                    <td><%= report.getReportDate() %></td>
                    <td><%= report.getVillageName() %></td>
                    <td><%= report.getSchemeName() %></td>
                    <td><%= report.getBeneficiariesCount() %></td>
                    <td class="status-<%= report.getStatus() %>"><%= report.getStatus().toUpperCase() %></td>
                </tr>
                <%      }
                } %>
            </tbody>
        </table>
    </div>
</div>
<div class="footer">
    <p>(c) 2026 Panchayat and Rural Development Department, Government of Chhattisgarh</p>
</div>
</body>
</html>