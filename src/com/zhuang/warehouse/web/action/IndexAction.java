package com.zhuang.warehouse.web.action;


import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.zhuang.warehouse.domain.Menus;
import com.zhuang.warehouse.service.IndexService;
import com.zhuang.warehouse.web.action.base.BaseAction;

@Controller
@Scope("prototype")
public class IndexAction extends BaseAction<Menus> {
	@Resource
	private IndexService indexService;
	//加载菜单
	public String loadMenu() throws IOException{
		
		Map menuMap=indexService.loadMenu();
		JsonConfig config= new JsonConfig();
		config.setExcludes(new String[]{"menu_id"});
		
		String json= JSONObject.fromObject(menuMap, config).toString();
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
	
		ServletActionContext.getResponse().getWriter().print(json);

		return NONE;
	}
}
