package com.lzh.pojo;

public class Admin {
    private Integer aId;

    private String aName;

    private String aPass;

    public Admin(Integer aId, String aName, String aPass) {
        this.aId = aId;
        this.aName = aName;
        this.aPass = aPass;
    }

    public Admin() {
        super();
    }

    public Integer getaId() {
        return aId;
    }

    public void setaId(Integer aId) {
        this.aId = aId;
    }

    public String getaName() {
        return aName;
    }

    public void setaName(String aName) {
        this.aName = aName == null ? null : aName.trim();
    }

    public String getaPass() {
        return aPass;
    }

    public void setaPass(String aPass) {
        this.aPass = aPass == null ? null : aPass.trim();
    }
}