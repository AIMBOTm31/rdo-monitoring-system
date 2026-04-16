package com.rdo.dao;

import java.sql.*;
import com.rdo.model.Officer;
import com.rdo.util.DBConnection;

public class OfficerDAO {
    
    public Officer validateLogin(String employeeCode, String password) {
        Officer officer = null;
        String query = "SELECT * FROM officer WHERE employee_code = ? AND password_hash = ? AND status = 'active'";
        
        try {
            Connection conn = DBConnection.getConnection();
            if (conn == null) {
                System.err.println("Database connection is null!");
                return null;
            }
            
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, employeeCode);
            pst.setString(2, password);
            ResultSet rs = pst.executeQuery();
            
            if(rs.next()) {
                officer = new Officer();
                officer.setOfficerId(rs.getInt("officer_id"));
                officer.setEmployeeCode(rs.getString("employee_code"));
                officer.setFullName(rs.getString("full_name"));
                officer.setDesignation(rs.getString("designation"));
                officer.setDistrict(rs.getString("district"));
                officer.setBlockName(rs.getString("block_name"));
                officer.setMobile(rs.getString("mobile"));
                officer.setEmail(rs.getString("email"));
                officer.setStatus(rs.getString("status"));
            }
            rs.close();
            pst.close();
        } catch(SQLException e) {
            System.err.println("SQL Error in validateLogin: " + e.getMessage());
            e.printStackTrace();
        }
        return officer;
    }
}