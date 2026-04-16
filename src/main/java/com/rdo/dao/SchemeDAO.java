package com.rdo.dao;

import java.sql.*;
import java.util.*;
import com.rdo.model.Scheme;
import com.rdo.util.DBConnection;

public class SchemeDAO {
    
    public List<Scheme> getAllSchemes() {
        List<Scheme> schemes = new ArrayList<>();
        String query = "SELECT * FROM scheme WHERE status = 'active' ORDER BY scheme_name";
        
        try {
            Statement st = DBConnection.getConnection().createStatement();
            ResultSet rs = st.executeQuery(query);
            
            while(rs.next()) {
                Scheme scheme = new Scheme();
                scheme.setSchemeId(rs.getInt("scheme_id"));
                scheme.setSchemeCode(rs.getString("scheme_code"));
                scheme.setSchemeName(rs.getString("scheme_name"));
                scheme.setDepartment(rs.getString("department"));
                scheme.setBudgetHead(rs.getString("budget_head"));
                scheme.setFinancialOutlay(rs.getDouble("financial_outlay"));
                scheme.setSchemeType(rs.getString("scheme_type"));
                schemes.add(scheme);
            }
            rs.close();
            st.close();
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return schemes;
    }
}