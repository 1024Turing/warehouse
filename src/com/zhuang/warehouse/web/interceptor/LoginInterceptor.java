package com.zhuang.warehouse.web.interceptor;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;
import com.zhuang.warehouse.domain.Staff;
import com.zhuang.warehouse.domain.User;

public class LoginInterceptor extends MethodFilterInterceptor {

	@Override
	protected String doIntercept(ActionInvocation invocation) throws Exception {
		User user=(User) ActionContext.getContext().getSession().get("user");
		
		if(user==null){
			ActionSupport actionSupport= (ActionSupport) invocation.getAction();
			actionSupport.addActionError("没有登录，无访问权限");
			return actionSupport.LOGIN;
		}else{
			return	invocation.invoke();
		}
	}

}
