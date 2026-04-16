package com.rdo.dao;

import java.sql.*;
import java.util.*;
import com.rdo.model.WorkReport;
import com.rdo.util.DBConnection;

public class WorkReportDAO {
    
    public boolean submitReport(WorkReport report) {
        String query = "INSERT INTO work_report (officer_id, report_date, village_name, gram_panchayat, scheme_id, work_description, beneficiaries_count, funds_utilized, gps_location, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'pending')";
        
        try {
            PreparedStatement pst = DBConnection.getConnection().prepareStatement(query);
            pst.setInt(1, report.getOfficerId());
            pst.setDate(2, report.getReportDate());
            pst.setString(3, report.getVillageName());
            pst.setString(4, report.getGramPanchayat());
            pst.setInt(5, report.getSchemeId());
            pst.setString(6, report.getWorkDescription());
            pst.setInt(7, report.getBeneficiariesCount());
            pst.setDouble(8, report.getFundsUtilized());
            pst.setString(9, report.getGpsLocation());
            
            int result = pst.executeUpdate();
            pst.close();
            return result > 0;
        } catch(SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<WorkReport> getReportsByOfficer(int officerId) {
        List<WorkReport> reports = new ArrayList<>();
        String query = "SELECT w.*, s.scheme_name FROM work_report w JOIN scheme s ON w.scheme_id = s.scheme_id WHERE w.officer_id = ? ORDER BY w.report_date DESC";
        
        try {
            PreparedStatement pst = DBConnection.getConnection().prepareStatement(query);
            pst.setInt(1, officerId);
            ResultSet rs = pst.executeQuery();
            
            while(rs.next()) {
                WorkReport report = new WorkReport();
                report.setReportId(rs.getInt("report_id"));
                report.setReportDate(rs.getDate("report_date"));
                report.setVillageName(rs.getString("village_name"));
                report.setGramPanchayat(rs.getString("gram_panchayat"));
                report.setSchemeName(rs.getString("scheme_name"));
                report.setWorkDescription(rs.getString("work_description"));
                report.setBeneficiariesCount(rs.getInt("beneficiaries_count"));
                report.setFundsUtilized(rs.getDouble("funds_utilized"));
                report.setGpsLocation(rs.getString("gps_location"));
                report.setStatus(rs.getString("status"));
                reports.add(report);
            }
            rs.close();
            pst.close();
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return reports;
    }
}