package com.zhuang.warehouse.dao;

import java.util.List;

import com.zhuang.warehouse.dao.base.BaseDao;
import com.zhuang.warehouse.domain.Menus;
import com.zhuang.warehouse.domain.User;

public interface IndexDao extends BaseDao<Menus> {

	List<Menus> findByUser(User user);

}
