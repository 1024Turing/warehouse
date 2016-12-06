package com.zhuang.warehouse.dao;

import com.zhuang.warehouse.dao.base.BaseDao;
import com.zhuang.warehouse.domain.User;

public interface UserDao extends BaseDao<User> {

	User findByUsernameAndPassword(String username, String password);

	void edit(String user_id, String[] roleIds);

	void del(String id);

}
