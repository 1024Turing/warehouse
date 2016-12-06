package com.zhuang.warehouse.web.action;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.apache.struts2.ServletActionContext;
import org.hibernate.criterion.DetachedCriteria;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.zhuang.warehouse.domain.Department;
import com.zhuang.warehouse.domain.PageBean;
import com.zhuang.warehouse.service.DeptService;
import com.zhuang.warehouse.web.action.base.BaseAction;
@Controller
@Scope("prototype")
public class DeptAction extends BaseAction<Department> {
	
	@Resource
	private DeptService deptService;
	
	private int page;//当前页码
	private int rows;//每页显示行
	
	public void setPage(int page) {
		this.page = page;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}
	public String add(){
		deptService.save(model);
		return "list";
	}
	public String edit(){

		Department dept=deptService.findById(model.getDept_id());
		dept.setDept_name(model.getDept_name());
		deptService.edit(dept);
		return "list";
	}
	//page_base_dept.action
	public String pageQuery() throws IOException{
		PageBean pageBean = new PageBean();
		pageBean.setCurrentPage(page);
		pageBean.setPageSize(rows);
		
		DetachedCriteria detachedCriteria=DetachedCriteria.forClass(Department.class);
		pageBean.setDetachedCriteria(detachedCriteria);
		
		deptService.pageQuery(pageBean);
		//使用json-lib将PageBean对象转为json数据
		JsonConfig config= new JsonConfig();
		config.setExcludes(new String[]{"currentPage","pageSize","detachedCriteria"});
		
		String json= JSONObject.fromObject(pageBean, config).toString();
		
		ServletActionContext.getResponse().setContentType("text/json;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().print(json);
		return NONE;
		
		/*
		 * List<Region> rList  ---json
		 * 	
		 * String json=JSONArray.fromObject(rList).toString()
		 * 
		//通过输出流将json数据写回客户端
		ServletActionContext.getResponse().setContentType("text/json;charset=UTF-8");
		try {
			ServletActionContext.getResponse().getWriter().print(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "";
		 * 
		 * 
		 */
	}
	
	private String ids;
	public void setIds(String ids) {
		this.ids = ids;
	}
	public String delete(){
		deptService.deleteBatch(ids);
		return "list";
	}
	public String findAll(){
		List<Department> dlist=deptService.findAll();
		this.writeObject2Json(dlist, new String[]{"dept_id"});
		return NONE;
	}
}
