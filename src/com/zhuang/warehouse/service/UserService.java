package com.zhuang.warehouse.service;

import com.zhuang.warehouse.domain.PageBean;
import com.zhuang.warehouse.domain.Staff;
import com.zhuang.warehouse.domain.User;

public interface UserService {

	User login(User model);

	void save(User user);

	User findById(String stf_id);

	void update(User user);

	void pageQuery(PageBean pageBean);

	void edit(String user_id, String[] roleIds);

	void editPassword(User user);

}
