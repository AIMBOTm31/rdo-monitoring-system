<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.rdo.dao.SchemeDAO" %>
<%@ page import="com.rdo.model.Scheme" %>
<%@ page import="java.util.List" %>

<%
    String schemeCode = request.getParameter("code");
    SchemeDAO schemeDAO = new SchemeDAO();
    List<Scheme> allSchemes = schemeDAO.getAllSchemes();
    Scheme scheme = null;
    
    for(Scheme s : allSchemes) {
        if(s.getSchemeCode().equals(schemeCode)) {
            scheme = s;
            break;
        }
    }
    
    if(scheme == null) {
        response.sendRedirect("publicSchemes.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= scheme.getSchemeName() %> - Scheme Details</title>
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
        
        .scheme-detail {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .detail-header {
            background: #FF9933;
            color: white;
            padding: 25px;
            text-align: center;
        }
        
        .detail-header h1 {
            font-size: 28px;
            margin-bottom: 10px;
        }
        
        .detail-header .code {
            font-size: 14px;
            opacity: 0.9;
        }
        
        .detail-body {
            padding: 30px;
        }
        
        .info-section {
            margin-bottom: 25px;
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
        }
        
        .info-section h3 {
            color: #138808;
            margin-bottom: 15px;
        }
        
        .info-section p {
            color: #555;
            line-height: 1.6;
            margin: 5px 0;
        }
        
        .info-grid {
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 15px;
            margin: 15px 0;
        }
        
        .info-label {
            font-weight: bold;
            color: #333;
        }
        
        .info-value {
            color: #555;
        }
        
        .apply-btn {
            display: inline-block;
            background: #138808;
            color: white;
            padding: 15px 30px;
            text-decoration: none;
            border-radius: 5px;
            font-size: 18px;
            margin-top: 20px;
            text-align: center;
        }
        
        .apply-btn:hover {
            background: #0a5a06;
        }
        
        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #FF9933;
            text-decoration: none;
        }
        
        .footer {
            background: #2c3e50;
            color: white;
            text-align: center;
            padding: 20px;
            margin-top: 40px;
        }
        
        @media (max-width: 768px) {
            .info-grid {
                grid-template-columns: 1fr;
                gap: 5px;
            }
            .detail-header h1 {
                font-size: 22px;
            }
        }
    </style>
</head>
<body>

<div class="header">
    <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/55/Emblem_of_India.svg/1200px-Emblem_of_India.svg.png" alt="Emblem">
    <h1>Chhattisgarh Rural Development</h1>
</div>

<div class="nav">
    <a href="index.html">Home</a>
    <a href="publicSchemes.jsp">All Schemes</a>
    <a href="findRDO.jsp">Find RDO</a>
    <a href="login.html">RDO Login</a>
</div>

<div class="container">
    <div class="scheme-detail">
        <div class="detail-header">
            <h1><%= scheme.getSchemeName() %></h1>
            <div class="code">Scheme Code: <%= scheme.getSchemeCode() %></div>
        </div>
        
        <div class="detail-body">
            <div class="info-section">
                <h3>📌 Scheme Overview</h3>
                <div class="info-grid">
                    <div class="info-label">Department:</div>
                    <div class="info-value"><%= scheme.getDepartment() %></div>
                    
                    <div class="info-label">Scheme Type:</div>
                    <div class="info-value"><%= scheme.getSchemeType() %></div>
                    
                    <div class="info-label">Budget Allocation:</div>
                    <div class="info-value">₹<%= String.format("%,.2f", scheme.getFinancialOutlay()/10000000) %> Crore</div>
                </div>
            </div>
            
            <div class="info-section">
                <h3>✅ Who Can Apply? (Eligibility)</h3>
                <p>• Resident of Chhattisgarh</p>
                <p>• BPL/Antyodaya card holder (for welfare schemes)</p>
                <p>• Farmer with land records (for agriculture schemes)</p>
                <p>• Contact your block office for exact eligibility criteria</p>
            </div>
            
            <div class="info-section">
                <h3>📄 Documents Required</h3>
                <p>• Aadhaar Card</p>
                <p>• Income Certificate (if applicable)</p>
                <p>• Caste Certificate (if applicable)</p>
                <p>• Bank Account Passbook</p>
                <p>• Ration Card</p>
            </div>
            
            <div class="info-section">
                <h3>📝 How to Apply?</h3>
                <p>1. Visit your nearest Gram Panchayat office</p>
                <p>2. Meet the Rural Development Officer (RDO)</p>
                <p>3. Fill the application form</p>
                <p>4. Submit required documents</p>
                <p>5. Get acknowledgment receipt</p>
            </div>
            
            <div class="info-section">
                <h3>📞 Need Help?</h3>
                <p>Contact your Block Development Office or call helpline: 1800-XXX-XXXX</p>
                <a href="findRDO.jsp" class="apply-btn">Find Your RDO →</a>
            </div>
            
            <a href="publicSchemes.jsp" class="back-link">← Back to all schemes</a>
        </div>
    </div>
</div>

<div class="footer">
    <p>(c) 2026 Panchayat and Rural Development Department, Government of Chhattisgarh</p>
</div>

</body>
</html>