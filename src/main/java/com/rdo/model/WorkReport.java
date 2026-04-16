package com.rdo.model;

import java.sql.Date;

public class WorkReport {
    private int reportId;
    private int officerId;
    private Date reportDate;
    private String villageName;
    private String gramPanchayat;
    private int schemeId;
    private String schemeName;
    private String workDescription;
    private int beneficiariesCount;
    private double fundsUtilized;
    private String photoPath;
    private String gpsLocation;
    private String status;
    
    public WorkReport() {}
    
    public int getReportId() { return reportId; }
    public void setReportId(int reportId) { this.reportId = reportId; }
    
    public int getOfficerId() { return officerId; }
    public void setOfficerId(int officerId) { this.officerId = officerId; }
    
    public Date getReportDate() { return reportDate; }
    public void setReportDate(Date reportDate) { this.reportDate = reportDate; }
    
    public String getVillageName() { return villageName; }
    public void setVillageName(String villageName) { this.villageName = villageName; }
    
    public String getGramPanchayat() { return gramPanchayat; }
    public void setGramPanchayat(String gramPanchayat) { this.gramPanchayat = gramPanchayat; }
    
    public int getSchemeId() { return schemeId; }
    public void setSchemeId(int schemeId) { this.schemeId = schemeId; }
    
    public String getSchemeName() { return schemeName; }
    public void setSchemeName(String schemeName) { this.schemeName = schemeName; }
    
    public String getWorkDescription() { return workDescription; }
    public void setWorkDescription(String workDescription) { this.workDescription = workDescription; }
    
    public int getBeneficiariesCount() { return beneficiariesCount; }
    public void setBeneficiariesCount(int beneficiariesCount) { this.beneficiariesCount = beneficiariesCount; }
    
    public double getFundsUtilized() { return fundsUtilized; }
    public void setFundsUtilized(double fundsUtilized) { this.fundsUtilized = fundsUtilized; }
    
    public String getPhotoPath() { return photoPath; }
    public void setPhotoPath(String photoPath) { this.photoPath = photoPath; }
    
    public String getGpsLocation() { return gpsLocation; }
    public void setGpsLocation(String gpsLocation) { this.gpsLocation = gpsLocation; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}