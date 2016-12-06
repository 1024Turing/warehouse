package com.zhuang.warehouse.domain;

public class Staff {
	private String stf_id;
	private String stf_name;
	private String stf_gender;//1：男         0： 女
	private String stf_birth;
	private String stf_phone;
	private String stf_email;
	private String id_card;
	private String dept;//部门
	private String position;//职位
	private String pst;//状态
	
	public String getId_card() {
		return id_card;
	}
	public void setId_card(String id_card) {
		this.id_card = id_card;
	}
	public String getStf_id() {
		return stf_id;
	}
	public void setStf_id(String stf_id) {
		this.stf_id = stf_id;
	}
	public String getStf_name() {
		return stf_name;
	}
	public void setStf_name(String stf_name) {
		this.stf_name = stf_name;
	}
	public String getStf_gender() {
		return stf_gender;
	}
	public void setStf_gender(String stf_gender) {
		this.stf_gender = stf_gender;
	}
	public String getStf_birth() {
		return stf_birth;
	}
	public void setStf_birth(String stf_birth) {
		this.stf_birth = stf_birth;
	}
	public String getStf_phone() {
		return stf_phone;
	}
	public void setStf_phone(String stf_phone) {
		this.stf_phone = stf_phone;
	}
	public String getStf_email() {
		return stf_email;
	}
	public void setStf_email(String stf_email) {
		this.stf_email = stf_email;
	}
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getPst() {
		return pst;
	}
	public void setPst(String pst) {
		this.pst = pst;
	}
	@Override
	public String toString() {
		return "Staff [stf_id=" + stf_id + ", stf_name=" + stf_name
				+ ", stf_gender=" + stf_gender + ", stf_birth=" + stf_birth
				+ ", stf_phone=" + stf_phone + ", stf_email=" + stf_email
				+ ", id_card=" + id_card + ", dept=" + dept + ", position="
				+ position + ", pst=" + pst + "]";
	}
	
}
