package com.zhuang.warehouse.service;

import java.util.List;

import com.zhuang.warehouse.domain.PageBean;
import com.zhuang.warehouse.domain.Role;

public interface RoleService {

	List loadMenu();

	void save(Role model, String ids);

	void pagequery(PageBean pageBean);

	List<Role> findAll();

	void deleteBatch(String role_ids);

	Role findById(String role_id);

	void update(Role model, String ids);

}
