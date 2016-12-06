package com.zhuang.warehouse.domain;

public class Menus {
	private String menu_id;
	private String menu_name;
	private String self_code;
	private String pcode;
	private String page;
	public String getMenu_id() {
		return menu_id;
	}
	public void setMenu_id(String menu_id) {
		this.menu_id = menu_id;
	}
	public String getMenu_name() {
		return menu_name;
	}
	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}
	public String getSelf_code() {
		return self_code;
	}
	public void setSelf_code(String self_code) {
		this.self_code = self_code;
	}
	public String getPcode() {
		return pcode;
	}
	public void setPcode(String pcode) {
		this.pcode = pcode;
	}
	public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
	}
	@Override
	public String toString() {
		return "Menus [menu_id=" + menu_id + ", menu_name=" + menu_name
				+ ", self_code=" + self_code + ", pcode=" + pcode + ", page="
				+ page + "]";
	}
	
	
	
}
