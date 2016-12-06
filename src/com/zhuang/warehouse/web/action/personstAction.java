package com.zhuang.warehouse.web.action;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import com.zhuang.warehouse.domain.Personstate;
import com.zhuang.warehouse.service.PersonstService;
import com.zhuang.warehouse.web.action.base.BaseAction;
@Controller
@Scope("prototype")
public class personstAction extends BaseAction<Personstate> {
	
	@Resource
	private PersonstService personstService;
	
	public String add(){
		personstService.save(model);
		return "list";
	}
	public String edit(){
		Personstate pst=personstService.findById(model.getPst_id());
		pst.setPst_state(model.getPst_state());
		personstService.update(pst);
		return "list";
	}
	//page_base_dept.action
	public String pageQuery() throws IOException{
		personstService.pageQuery(pageBean);
		this.writeObject2Json(pageBean, new String[]{"currentPage","pageSize","detachedCriteria"});
		return NONE;
	}
	
	private String ids;
	public void setIds(String ids) {
		this.ids = ids;
	}
	public String delete(){
		personstService.deleteBatch(ids);
		return "list";
	}
	public String findAll(){
		List<Personstate> pList=personstService.findAll();
		this.writeObject2Json(pList, new String[]{"pst_id"});
		return NONE;
	}
}
