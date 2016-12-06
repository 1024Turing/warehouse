package com.zhuang.warehouse.service.impl;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zhuang.warehouse.dao.StaffDao;
import com.zhuang.warehouse.dao.UserDao;
import com.zhuang.warehouse.domain.PageBean;
import com.zhuang.warehouse.domain.Staff;
import com.zhuang.warehouse.service.StaffService;
@Service
@Transactional
public class StaffServiceImpl implements StaffService{

	@Resource
	private StaffDao staffDao;
	@Resource
	private UserDao userDao;
	public void deleteBatch(String ids) {
		if(StringUtils.isNotBlank(ids)){
			String[] array=ids.split(",");
			for(String id: array){
				
				Staff s=staffDao.findById(id);
				staffDao.delete(s);
				userDao.del(id);
			}
		}
		
	}

	public void pageQuery(PageBean pageBean) {
		staffDao.pageQuery(pageBean);
		
	}

	public void update(Staff staff) {
		staffDao.update(staff);
		
	}

	public Staff findById(String stf_id) {
		
		return staffDao.findById(stf_id);
	}

	public void save(Staff model) {
		staffDao.save(model);
		
	}

}
