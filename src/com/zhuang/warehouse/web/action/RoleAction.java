package com.zhuang.warehouse.web.action;


import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;

import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.zhuang.warehouse.domain.Role;
import com.zhuang.warehouse.service.RoleService;
import com.zhuang.warehouse.web.action.base.BaseAction;

@Controller
@Scope("prototype")
public class RoleAction extends BaseAction<Role> {
	@Resource
	private  RoleService roleService;
	
	private String ids;//接收页面拼接的权限字符串
	public void setIds(String ids) {
		this.ids = ids;
	}
	public String add(){

		roleService.save(model,ids);
		return "list";
	}
	public String pageQuery(){
		roleService.pagequery(pageBean);
		this.writeObject2Json(pageBean, new String[]{""});
		return NONE;
	}

	//加载菜单
	public String functionTree() throws IOException{
		
		List mapList=roleService.loadMenu();

		
		String json= JSONArray.fromObject(mapList).toString();
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
	
		ServletActionContext.getResponse().getWriter().print(json);

		return NONE;
	}
	public String listajax(){
		List<Role> list=roleService.findAll();
		this.writeObject2Json(list, new String[]{});
		return NONE;
	}
	//删除
	private String role_ids;
	public void setRole_ids(String role_ids) {
		this.role_ids = role_ids;
	}
	public String delete(){
		roleService.deleteBatch(role_ids);
		return "list";
	}
	//修改
	public String editPre(){
		model=roleService.findById(model.getRole_id());
		return "edit";
	}
	public String edit(){
		roleService.update(model,ids);
		return "list";
	}
}
