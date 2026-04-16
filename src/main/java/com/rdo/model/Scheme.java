package com.rdo.model;

public class Scheme {
    private int schemeId;
    private String schemeCode;
    private String schemeName;
    private String department;
    private String budgetHead;
    private double financialOutlay;
    private String schemeType;
    
    public Scheme() {}
    
    public int getSchemeId() { return schemeId; }
    public void setSchemeId(int schemeId) { this.schemeId = schemeId; }
    
    public String getSchemeCode() { return schemeCode; }
    public void setSchemeCode(String schemeCode) { this.schemeCode = schemeCode; }
    
    public String getSchemeName() { return schemeName; }
    public void setSchemeName(String schemeName) { this.schemeName = schemeName; }
    
    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }
    
    public String getBudgetHead() { return budgetHead; }
    public void setBudgetHead(String budgetHead) { this.budgetHead = budgetHead; }
    
    public double getFinancialOutlay() { return financialOutlay; }
    public void setFinancialOutlay(double financialOutlay) { this.financialOutlay = financialOutlay; }
    
    public String getSchemeType() { return schemeType; }
    public void setSchemeType(String schemeType) { this.schemeType = schemeType; }
}