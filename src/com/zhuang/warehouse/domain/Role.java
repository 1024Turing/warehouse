package com.zhuang.warehouse.domain;

import java.awt.Menu;
import java.util.ArrayList;
import java.util.List;

public class Role {
	private String role_id;
	private String role_name;
	private String role_desc;
	
	private List<Menus> menuList=new ArrayList();
	
	private String menuids;
	

	public String getMenuids() {
		String ids="";
		for(int i=0;i<menuList.size();i++){
			
			ids+=menuList.get(i).getSelf_code();
			if(i!=menuList.size()-1){
				ids+=",";
			}
		}
		return ids;
	}
	public List<Menus> getMenuList() {
		return menuList;
	}
	public void setMenuList(List<Menus> menuList) {
		this.menuList = menuList;
	}
	public String getRole_id() {
		return role_id;
	}
	public void setRole_id(String role_id) {
		this.role_id = role_id;
	}
	public String getRole_name() {
		return role_name;
	}
	public void setRole_name(String role_name) {
		this.role_name = role_name;
	}
	public String getRole_desc() {
		return role_desc;
	}
	public void setRole_desc(String role_desc) {
		this.role_desc = role_desc;
	}
	@Override
	public String toString() {
		return "Role [role_id=" + role_id + ", role_name=" + role_name
				+ ", role_desc=" + role_desc + "]";
	}
	
}
