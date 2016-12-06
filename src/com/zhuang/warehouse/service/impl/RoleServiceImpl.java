package com.zhuang.warehouse.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zhuang.warehouse.dao.MenusDao;
import com.zhuang.warehouse.dao.RoleDao;
import com.zhuang.warehouse.domain.Menus;
import com.zhuang.warehouse.domain.PageBean;
import com.zhuang.warehouse.domain.Role;
import com.zhuang.warehouse.domain.Staff;
import com.zhuang.warehouse.service.RoleService;
import com.zhuang.warehouse.utils.CommonUtils;
@Transactional
@Service
public class RoleServiceImpl implements RoleService {
	@Resource
	private MenusDao menusDao;
	@Resource
	private RoleDao roleDao;
	
	public List loadMenu() {
		List<Menus> menuList=menusDao.findAll();
		List mapList=new ArrayList();
		for( Menus menu : menuList){
			Map map=new HashMap();
			map.put("id", menu.getSelf_code());
			map.put("pId", menu.getPcode());
			map.put("name", menu.getMenu_name());
			mapList.add(map);
		}
		return mapList;
	}

	public void save(Role model, String ids) {
		String role_id=CommonUtils.uuid();
		model.setRole_id(role_id);
		roleDao.save(model);
		if(StringUtils.isNotBlank(ids)){
			String[] menusIds = ids.split(",");
			roleDao.saveMenus(role_id,menusIds);
		}
		
		
	}

	public void pagequery(PageBean pageBean) {
		roleDao.pageQuery(pageBean);
		
	}

	public List<Role> findAll() {
		return roleDao.findAll();
		
	}

	public void deleteBatch(String role_ids) {
		if(StringUtils.isNotBlank(role_ids)){
			String[] array=role_ids.split(",");
			for(String id: array){
				//删除与该角色关联的所有数据
				roleDao.deleteAll(id);
			}
		}
	}
	//根据id查role对象
	public Role findById(String role_id) {
		Role role=roleDao.findById(role_id);
		List<Menus> mList=menusDao.findByRole(role_id);
		role.setMenuList(mList);;
		return role;
	}

	public void update(Role model, String ids) {
		roleDao.update(model);
		//先删除以前的，再保存
		roleDao.delMenus(model.getRole_id());
		
		if(StringUtils.isNotBlank(ids)){
			String[] menusIds = ids.split(",");
			roleDao.saveMenus(model.getRole_id(),menusIds);
		}
		
		
	}

}
