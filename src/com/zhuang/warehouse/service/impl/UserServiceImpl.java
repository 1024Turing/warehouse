package com.zhuang.warehouse.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zhuang.warehouse.dao.RoleDao;
import com.zhuang.warehouse.dao.StaffDao;
import com.zhuang.warehouse.dao.UserDao;
import com.zhuang.warehouse.domain.PageBean;
import com.zhuang.warehouse.domain.Role;
import com.zhuang.warehouse.domain.Staff;
import com.zhuang.warehouse.domain.User;
import com.zhuang.warehouse.service.UserService;
@Transactional
@Service
public class UserServiceImpl implements UserService {

	@Resource
	private UserDao userDao;

	@Resource
	private StaffDao staffDao;
	@Resource
	private RoleDao roleDao;
	
	public User login(User model) {
		String user_code = model.getUser_code();
		String password = model.getPassword();
		User user = userDao.findByUsernameAndPassword(user_code,password);

		if(user==null) {return null;}
		if(user.getUser_code().trim().equals("admin")){
			Staff admin=new Staff();
			admin.setStf_name("超级管理员");
			user.setStaff(admin);
			return user;
		}
		Staff staff=staffDao.findById(user.getUser_id());
		//staff.getPst()!=null &&
		if( staff.getPst().trim().equals("在职")){
			user.setStaff(staff);
			return user;
		}
		return null;
	}
	public void save(User user) {
		userDao.save(user);
		
	}
	public User findById(String stf_id) {
		return userDao.findById(stf_id);
	}
	public void update(User user) {
		userDao.update(user);
	}

	public void pageQuery(PageBean pageBean) {
		
		userDao.pageQuery(pageBean);
		List<User> ulist=pageBean.getRows();
		for(User user: ulist){
			//封装员工信息
			Staff staff=staffDao.findById(user.getUser_id());
			user.setStaff(staff);
			//封装role
			//List<Role> roleList=user.getRoleList();
			List<Role> roleList=roleDao.findByUser(user.getUser_id());
			user.setRoleList(roleList);
		}
	}
	public void edit(String user_id, String[] roleIds) {
		if(StringUtils.isNotBlank(user_id) && roleIds!=null){
			userDao.edit(user_id, roleIds);
		}
	}
	public void editPassword(User user) {
		userDao.update(user);
		
	}


}
