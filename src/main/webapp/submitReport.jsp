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
    <title>Submit Report - RDO</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #f5f5f5; }
        .header { background: linear-gradient(135deg, #FF9933, #FFCC66); color: white; padding: 15px; display: flex; justify-content: space-between; align-items: center; }
        .header-left { display: flex; align-items: center; gap: 15px; }
        .header-left img { height: 60px; }
        .nav { background: #138808; padding: 12px; }
        .nav a { color: white; text-decoration: none; padding: 10px 20px; margin: 0 5px; display: inline-block; }
        .nav a:hover { background: #0a5a06; border-radius: 5px; }
        .container { max-width: 800px; margin: 30px auto; padding: 0 20px; }
        .form-card { background: white; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); overflow: hidden; }
        .form-header { background: #FF9933; color: white; padding: 15px 20px; }
        .form-body { padding: 25px; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: bold; color: #333; }
        .form-group input, .form-group select, .form-group textarea { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; font-size: 14px; }
        .form-group textarea { resize: vertical; min-height: 80px; }
        .row { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; }
        .btn-submit { background: #138808; color: white; padding: 12px 30px; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; width: 100%; }
        .btn-submit:hover { background: #0a5a06; }
        .footer { background: #2c3e50; color: white; text-align: center; padding: 20px; margin-top: 40px; }
        .success-msg { background: #d4edda; color: #155724; padding: 10px; border-radius: 5px; margin-bottom: 20px; }
        .error-msg { background: #f8d7da; color: #721c24; padding: 10px; border-radius: 5px; margin-bottom: 20px; }
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
    <div class="form-card">
        <div class="form-header"><h2>Submit Daily Work Report</h2><p>Fill in your field visit details</p></div>
        <div class="form-body">
        <% if(request.getParameter("success") != null) { %>
            <div class="success-msg">Report submitted successfully!</div>
        <% } else if(request.getParameter("error") != null) { %>
            <div class="error-msg">Failed to submit report. Please try again.</div>
        <% } %>
        <form action="SubmitReportServlet" method="post">
            <div class="row">
                <div class="form-group"><label>Report Date *</label><input type="date" name="reportDate" required value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>"></div>
                <div class="form-group"><label>Select Scheme *</label><select name="schemeId" required><option value="">-- Select Scheme --</option><% for(com.rdo.model.Scheme scheme : schemes) { %><option value="<%= scheme.getSchemeId() %>"><%= scheme.getSchemeCode() %> - <%= scheme.getSchemeName() %></option><% } %></select></div>
            </div>
            <div class="row">
                <div class="form-group"><label>Village Name *</label><input type="text" name="villageName" placeholder="e.g., Khairjhiti" required></div>
                <div class="form-group"><label>Gram Panchayat</label><input type="text" name="gramPanchayat" placeholder="e.g., Kota GP"></div>
            </div>
            <div class="form-group"><label>Work Description *</label><textarea name="workDescription" placeholder="Describe the work done, meetings conducted, inspections performed..." required></textarea></div>
            <div class="row">
                <div class="form-group"><label>Number of Beneficiaries</label><input type="number" name="beneficiariesCount" value="0" min="0"></div>
                <div class="form-group"><label>Funds Utilized (Rs.)</label><input type="number" name="fundsUtilized" value="0" min="0" step="1000"></div>
            </div>
            <div class="form-group"><label>GPS Location</label><input type="text" name="gpsLocation" placeholder="e.g., 22.09°N, 82.14°E"><small style="color: #666;">Get coordinates from your phone's GPS</small></div>
            <button type="submit" class="btn-submit">Submit Report</button>
        </form>
        </div>
    </div>
</div>
<div class="footer"><p>(c) 2026 Panchayat and Rural Development Department, Government of Chhattisgarh</p></div>
</body>
</html>