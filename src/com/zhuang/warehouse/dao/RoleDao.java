package com.zhuang.warehouse.dao;

import java.util.List;

import com.zhuang.warehouse.dao.base.BaseDao;
import com.zhuang.warehouse.domain.Role;

public interface RoleDao extends BaseDao<Role> {

	void saveMenus(String role_id, String[] menusIds);

	List<Role> findByUser(String user_id);

	void deleteAll(String id);

	void delMenus(String role_id);

}
