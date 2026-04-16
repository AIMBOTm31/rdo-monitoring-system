<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.rdo.util.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find Your RDO - Chhattisgarh</title>
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
            max-width: 900px;
            margin: 30px auto;
            padding: 0 20px;
        }
        
        .search-box {
            background: white;
            padding: 30px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        
        .search-box h2 {
            color: #333;
            margin-bottom: 20px;
        }
        
        .search-form {
            display: flex;
            gap: 10px;
            justify-content: center;
            flex-wrap: wrap;
        }
        
        .search-form input {
            padding: 12px;
            width: 300px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }
        
        .search-form select {
            padding: 12px;
            width: 200px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }
        
        .search-form button {
            padding: 12px 25px;
            background: #FF9933;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        
        .search-form button:hover {
            background: #e68a00;
        }
        
        .results {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .result-card {
            padding: 20px;
            border-bottom: 1px solid #eee;
        }
        
        .result-card:last-child {
            border-bottom: none;
        }
        
        .result-card h3 {
            color: #138808;
            margin-bottom: 10px;
        }
        
        .result-details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
            margin-top: 10px;
        }
        
        .detail-item {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .detail-label {
            font-weight: bold;
            color: #333;
            min-width: 80px;
        }
        
        .no-results {
            text-align: center;
            padding: 40px;
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
            .result-details {
                grid-template-columns: 1fr;
            }
            .search-form input, .search-form select {
                width: 100%;
            }
        }
    </style>
</head>
<body>

<div class="header">
    <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/55/Emblem_of_India.svg/1200px-Emblem_of_India.svg.png" alt="Emblem">
    <h1>Find Your Rural Development Officer</h1>
    <p>अपने क्षेत्र के RDO को खोजें | Find RDO in your area</p>
</div>

<div class="nav">
    <a href="index.html">Home</a>
    <a href="publicSchemes.jsp">All Schemes</a>
    <a href="findRDO.jsp">Find RDO</a>
    <a href="login.html">RDO Login</a>
</div>

<div class="container">
    <div class="search-box">
        <h2>Search by Village Name or Block</h2>
        <form class="search-form" method="get">
            <input type="text" name="village" placeholder="Enter village name..." value="<%= request.getParameter("village") != null ? request.getParameter("village") : "" %>">
            <select name="district">
                <option value="">All Districts</option>
                <option value="Bilaspur" <%= request.getParameter("district") != null && request.getParameter("district").equals("Bilaspur") ? "selected" : "" %>>Bilaspur</option>
                <option value="Raipur" <%= request.getParameter("district") != null && request.getParameter("district").equals("Raipur") ? "selected" : "" %>>Raipur</option>
                <option value="Durg" <%= request.getParameter("district") != null && request.getParameter("district").equals("Durg") ? "selected" : "" %>>Durg</option>
                <option value="Bastar" <%= request.getParameter("district") != null && request.getParameter("district").equals("Bastar") ? "selected" : "" %>>Bastar</option>
            </select>
            <button type="submit">Search</button>
        </form>
    </div>
    
    <div class="results">
        <%
            String village = request.getParameter("village");
            String district = request.getParameter("district");
            
            if((village != null && !village.trim().isEmpty()) || (district != null && !district.trim().isEmpty())) {
                
                String query = "SELECT * FROM officer WHERE status = 'active'";
                
                if(district != null && !district.trim().isEmpty()) {
                    query += " AND district = '" + district + "'";
                }
                
                query += " ORDER BY district, block_name";
                
                try {
                    Connection conn = DBConnection.getConnection();
                    Statement st = conn.createStatement();
                    ResultSet rs = st.executeQuery(query);
                    
                    boolean hasResults = false;
                    
                    while(rs.next()) {
                        hasResults = true;
        %>
        <div class="result-card">
            <h3>📍 <%= rs.getString("block_name") %> Block, <%= rs.getString("district") %> District</h3>
            <div class="result-details">
                <div class="detail-item">
                    <span class="detail-label">Officer Name:</span>
                    <span><%= rs.getString("full_name") %></span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">Designation:</span>
                    <span><%= rs.getString("designation") %></span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">📞 Mobile:</span>
                    <span><%= rs.getString("mobile") %></span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">✉️ Email:</span>
                    <span><%= rs.getString("email") %></span>
                </div>
            </div>
        </div>
        <%
                    }
                    
                    if(!hasResults) {
        %>
        <div class="no-results">
            <p>❌ No RDO found for your search criteria.</p>
            <p>Please try a different village or district.</p>
        </div>
        <%
                    }
                    
                    rs.close();
                    st.close();
                } catch(Exception e) {
                    e.printStackTrace();
        %>
        <div class="no-results">
            <p>Error fetching data. Please try again.</p>
        </div>
        <%
                }
            } else {
        %>
        <div class="no-results">
            <p>🔍 Enter a village name or select a district to find your RDO.</p>
            <p>Example: Kota, Khairjhiti, Sakri, etc.</p>
        </div>
        <% } %>
    </div>
</div>

<div class="footer">
    <p>(c) 2026 Panchayat and Rural Development Department, Government of Chhattisgarh</p>
    <p>Helpline: 1800-XXX-XXXX | Timings: 10:00 AM - 5:00 PM</p>
</div>

</body>
</html>