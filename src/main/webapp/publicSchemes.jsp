<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.rdo.dao.SchemeDAO" %>
<%@ page import="com.rdo.model.Scheme" %>

<%
    SchemeDAO schemeDAO = new SchemeDAO();
    List<Scheme> schemes = schemeDAO.getAllSchemes();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Government Schemes - Chhattisgarh</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Arial', sans-serif;
            background: #f5f5f5;
        }
        
        .header {
            background: linear-gradient(135deg, #FF9933, #FFCC66);
            color: white;
            padding: 20px;
            text-align: center;
        }
        
        .header img {
            height: 60px;
        }
        
        .header h1 {
            font-size: 24px;
            margin: 10px 0;
        }
        
        .nav {
            background: #138808;
            padding: 12px;
            text-align: center;
        }
        
        .nav a {
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            margin: 0 5px;
            display: inline-block;
        }
        
        .nav a:hover {
            background: #0a5a06;
            border-radius: 5px;
        }
        
        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }
        
        .page-title {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .page-title h2 {
            color: #333;
            font-size: 32px;
        }
        
        .page-title p {
            color: #666;
            margin-top: 10px;
        }
        
        .filter-bar {
            background: white;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 30px;
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            justify-content: center;
        }
        
        .filter-bar input {
            padding: 10px;
            width: 300px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        
        .filter-bar select {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        
        .scheme-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 20px;
        }
        
        .scheme-card {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: transform 0.3s;
            cursor: pointer;
        }
        
        .scheme-card:hover {
            transform: translateY(-5px);
        }
        
        .scheme-header {
            background: #FF9933;
            color: white;
            padding: 15px;
        }
        
        .scheme-header h3 {
            font-size: 18px;
        }
        
        .scheme-code {
            font-size: 12px;
            opacity: 0.9;
        }
        
        .scheme-body {
            padding: 15px;
        }
        
        .scheme-body p {
            margin: 8px 0;
            color: #555;
        }
        
        .scheme-body .label {
            font-weight: bold;
            color: #333;
        }
        
        .view-details {
            display: inline-block;
            background: #138808;
            color: white;
            padding: 8px 15px;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 10px;
            font-size: 14px;
        }
        
        .view-details:hover {
            background: #0a5a06;
        }
        
        .no-data {
            text-align: center;
            padding: 50px;
            color: #666;
        }
        
        .footer {
            background: #2c3e50;
            color: white;
            text-align: center;
            padding: 20px;
            margin-top: 40px;
        }
        
        @media (max-width: 768px) {
            .nav a {
                display: inline-block;
                margin: 5px;
            }
            .scheme-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>

<div class="header">
    <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/55/Emblem_of_India.svg/1200px-Emblem_of_India.svg.png" alt="Emblem">
    <h1>Chhattisgarh Government Schemes</h1>
    <p>जानिए सरकार की योजनाओं के बारे में | Know about government schemes</p>
</div>

<div class="nav">
    <a href="index.html">Home</a>
    <a href="publicSchemes.jsp">All Schemes</a>
    <a href="findRDO.jsp">Find RDO</a>
    <a href="login.html">RDO Login</a>
</div>

<div class="container">
    <div class="page-title">
        <h2>📋 All Government Schemes</h2>
        <p>Active schemes under Panchayat and Rural Development Department</p>
    </div>
    
    <div class="filter-bar">
        <input type="text" id="searchInput" placeholder="Search scheme by name..." onkeyup="filterSchemes()">
        <select id="typeFilter" onchange="filterSchemes()">
            <option value="all">All Types</option>
            <option value="State">State Schemes</option>
            <option value="Central">Central Schemes</option>
            <option value="CSS">CSS Schemes</option>
        </select>
    </div>
    
    <div class="scheme-grid" id="schemeGrid">
        <% if(schemes.isEmpty()) { %>
            <div class="no-data">No schemes available at the moment.</div>
        <% } else { 
            for(Scheme scheme : schemes) {
        %>
        <div class="scheme-card" data-name="<%= scheme.getSchemeName().toLowerCase() %>" data-type="<%= scheme.getSchemeType() %>">
            <div class="scheme-header">
                <h3><%= scheme.getSchemeName() %></h3>
                <div class="scheme-code">Code: <%= scheme.getSchemeCode() %></div>
            </div>
            <div class="scheme-body">
                <p><span class="label">Department:</span> <%= scheme.getDepartment() %></p>
                <p><span class="label">Scheme Type:</span> <%= scheme.getSchemeType() %></p>
                <p><span class="label">Budget:</span> ₹<%= String.format("%,.2f", scheme.getFinancialOutlay()/10000000) %> Crore</p>
                <a href="schemeDetail.jsp?code=<%= scheme.getSchemeCode() %>" class="view-details">View Details →</a>
            </div>
        </div>
        <%      }
        } %>
    </div>
</div>

<script>
    function filterSchemes() {
        let searchTerm = document.getElementById('searchInput').value.toLowerCase();
        let typeFilter = document.getElementById('typeFilter').value;
        let cards = document.getElementsByClassName('scheme-card');
        
        for(let i = 0; i < cards.length; i++) {
            let card = cards[i];
            let schemeName = card.getAttribute('data-name');
            let schemeType = card.getAttribute('data-type');
            
            let matchesSearch = schemeName.includes(searchTerm);
            let matchesType = (typeFilter === 'all' || schemeType === typeFilter);
            
            if(matchesSearch && matchesType) {
                card.style.display = 'block';
            } else {
                card.style.display = 'none';
            }
        }
    }
</script>

<div class="footer">
    <p>(c) 2026 Panchayat and Rural Development Department, Government of Chhattisgarh</p>
    <p>For scheme application assistance, contact your block office</p>
</div>

</body>
</html>