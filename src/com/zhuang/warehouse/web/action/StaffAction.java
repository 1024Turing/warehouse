package com.zhuang.warehouse.web.action;

import java.io.IOException;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.zhuang.warehouse.domain.Staff;
import com.zhuang.warehouse.domain.User;
import com.zhuang.warehouse.service.StaffService;
import com.zhuang.warehouse.service.UserService;
import com.zhuang.warehouse.utils.CommonUtils;
import com.zhuang.warehouse.web.action.base.BaseAction;
@Controller
@Scope("prototype")
public class StaffAction extends BaseAction<Staff> {
	
	@Resource
	private StaffService staffService;
	@Resource
	private UserService userService;
	
	public String add(){
		String id= CommonUtils.uuid();
		String id_card=model.getId_card();
		model.setStf_id(id);	
		User user=new User();
		user.setUser_id(id);
		user.setUser_code(id_card);
		user.setPassword(id_card.substring(id_card.length()-8));
		userService.save(user);
		staffService.save(model);
		return "list";
	}
	public String edit(){
		String id_card=model.getId_card();
		Staff staff=staffService.findById(model.getStf_id());
		User user=userService.findById(model.getStf_id());
		System.out.println(id_card);
		System.out.println(id_card.substring(id_card.length()-8));
		user.setUser_code(id_card);
		user.setPassword(id_card.substring(id_card.length()-8));
		
		staff.setDept(model.getDept());
		staff.setPosition(model.getPosition());
		staff.setPst(model.getPst());
		staff.setStf_birth(model.getStf_birth());
		staff.setStf_email(model.getStf_email());
		staff.setStf_gender(model.getStf_gender());
		staff.setStf_name(model.getStf_name());
		staff.setStf_phone(model.getStf_phone());
		staff.setId_card(id_card);
		
		staffService.update(staff);
		userService.update(user);
		
		return "list";
	}
	//条件查询
	private String deptCriteria;
	private String posCriteria;
	private String pstCriteria;
	
	public void setDeptCriteria(String deptCriteria) {
		this.deptCriteria = deptCriteria;
	}
	public void setPosCriteria(String posCriteria) {
		this.posCriteria = posCriteria;
	}
	public void setPstCriteria(String pstCriteria) {
		this.pstCriteria = pstCriteria;
	}
	
	public String pageQuery() throws IOException{

		DetachedCriteria detachedCriteria =this.pageBean.getDetachedCriteria();
		if(StringUtils.isNotBlank(deptCriteria)){
			detachedCriteria.add(Restrictions.eq("dept", deptCriteria.trim()));
		}
		if(StringUtils.isNotBlank(posCriteria)){
			detachedCriteria.add(Restrictions.eq("position", posCriteria.trim()));
		}
		if(StringUtils.isNotBlank(pstCriteria)){
			detachedCriteria.add(Restrictions.eq("pst", pstCriteria.trim()));
		}
		staffService.pageQuery(pageBean);
		this.writeObject2Json(pageBean, new String[]{"currentPage","pageSize","detachedCriteria"});
		return NONE;
	}
	private String ids;
	public void setIds(String ids) {
		this.ids = ids;
	}
	
	public String delete(){
		staffService.deleteBatch(ids);
		return "list";
	}
}
