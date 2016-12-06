package com.zhuang.warehouse.dao;

import java.util.List;

import com.zhuang.warehouse.dao.base.BaseDao;
import com.zhuang.warehouse.domain.Menus;

public interface MenusDao extends BaseDao<Menus> {

	List<Menus> findByRole(String role_id);

}
