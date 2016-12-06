package com.zhuang.warehouse.web.action;

import java.io.IOException;

import org.apache.struts2.ServletActionContext;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;
import com.zhuang.warehouse.domain.Staff;
import com.zhuang.warehouse.domain.User;
import com.zhuang.warehouse.service.UserService;
import com.zhuang.warehouse.web.action.base.BaseAction;
@Controller
@Scope("prototype")
public class UserAction extends BaseAction<User> {
	private String checkcode;

	public void setCheckcode(String checkcode) {
		this.checkcode = checkcode;
	}
	
	@Autowired
	private UserService userService;
	
	
	public String login(){
		
		//从session中获取生成的验证码
		String validateCode=(String) ActionContext.getContext().getSession().get("key");
		if(!checkcode.trim().isEmpty() && validateCode.equals(checkcode)){
			User user= userService.login(model);
			
			if(user!=null){
				ActionContext.getContext().getSession().put("user", user);
				return "home";
			}else{
				this.addActionError("账号或密码错误！");
				return LOGIN;
			}
		}else{
			this.addActionError("验证码输入错误！");
			return LOGIN;
		}			
	}
	public String pageQuery(){
		DetachedCriteria dc=pageBean.getDetachedCriteria();
		dc.add(Restrictions.ne("user_code", "admin"));
		
		userService.pageQuery(pageBean);
		//System.out.println("hahahhahah");
		this.writeObject2Json(pageBean, new String[]{"currentPage","pageSize","detachedCriteria"});
		return NONE;
	}
	//接收页面提交的多个角色id
	private String[] roleIds;
	public void setRoleIds(String[] roleIds) {
		this.roleIds = roleIds;
	}
	public String edit(){
		userService.edit(model.getUser_id(),roleIds);
		return "list";
	}
	
	public String quit(){
		ServletActionContext.getRequest().getSession().invalidate();
		return NONE;
	}
	
	public String editPassword() throws IOException{
		String f="1";//修改结果的标识位 1成功 0失败
		User user=(User) ServletActionContext.getRequest().getSession().getAttribute("user");

		user.setPassword(model.getPassword());
		try{
				userService.editPassword(user);
		}catch(Exception e){
			f="0";
			e.printStackTrace();
		}
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().print(f);
		return NONE;
	}
}
