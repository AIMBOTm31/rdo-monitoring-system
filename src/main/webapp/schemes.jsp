<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    com.rdo.model.Officer officer = (com.rdo.model.Officer) session.getAttribute("officer");
    if(officer == null) {
        response.sendRedirect("login.html");
        return;
    }
    
    com.rdo.dao.SchemeDAO schemeDAO = new com.rdo.dao.SchemeDAO();
    java.util.List<com.rdo.model.Scheme> schemes = schemeDAO.getAllSchemes();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Government Schemes - Chhattisgarh</title>
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
        .scheme-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(350px, 1fr)); gap: 20px; margin-top: 20px; }
        .scheme-card { background: white; border-radius: 10px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.1); transition: transform 0.3s; }
        .scheme-card:hover { transform: translateY(-5px); }
        .scheme-header { background: #FF9933; color: white; padding: 15px; }
        .scheme-header h3 { font-size: 18px; }
        .scheme-code { font-size: 12px; opacity: 0.9; }
        .scheme-body { padding: 15px; }
        .scheme-body p { margin: 8px 0; color: #555; }
        .scheme-body .label { font-weight: bold; color: #333; }
        .budget { color: #138808; font-weight: bold; font-size: 18px; }
        .footer { background: #2c3e50; color: white; text-align: center; padding: 20px; margin-top: 40px; }
        h2 { color: #333; }
        .subtitle { color: #666; margin-top: 5px; }
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
    <h2>Chhattisgarh Government Schemes</h2>
    <p class="subtitle">Active schemes under Panchayat and Rural Development Department (2026-27)</p>
    <div class="scheme-grid">
        <% for(com.rdo.model.Scheme scheme : schemes) { %>
        <div class="scheme-card">
            <div class="scheme-header">
                <h3><%= scheme.getSchemeName() %></h3>
                <div class="scheme-code">Code: <%= scheme.getSchemeCode() %></div>
            </div>
            <div class="scheme-body">
                <p><span class="label">Department:</span> <%= scheme.getDepartment() %></p>
                <p><span class="label">Scheme Type:</span> <%= scheme.getSchemeType() %></p>
                <p><span class="label">Budget Head:</span> <%= scheme.getBudgetHead() != null ? scheme.getBudgetHead() : "-" %></p>
                <p><span class="label">Financial Outlay:</span> <span class="budget">Rs. <%= String.format("%,.2f", scheme.getFinancialOutlay()/10000000) %> Crore</span></p>
            </div>
        </div>
        <% } %>
    </div>
</div>
<div class="footer"><p>(c) 2026 Panchayat and Rural Development Department, Government of Chhattisgarh</p></div>
</body>
</html>