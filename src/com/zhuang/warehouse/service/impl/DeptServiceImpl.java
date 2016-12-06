package com.zhuang.warehouse.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zhuang.warehouse.dao.DeptDao;
import com.zhuang.warehouse.domain.Department;
import com.zhuang.warehouse.domain.PageBean;
import com.zhuang.warehouse.service.DeptService;
@Transactional
@Service
public class DeptServiceImpl implements DeptService {

	@Resource
	private DeptDao deptDao;
	public void save(Department model) {
		deptDao.save(model);
		
	}

	public void pageQuery(PageBean pageBean) {
		deptDao.pageQuery(pageBean);
		
	}

	public void edit(Department model) {
		deptDao.update(model);
		
	}

	public Department findById(String dept_id) {
		return	deptDao.findById(dept_id);
		
	}

	public void deleteBatch(String ids) {
		if(StringUtils.isNotBlank(ids)){
			String[] array=ids.split(",");
			for(String id :array){
				System.out.println(id);
				Department dept=deptDao.findById(id);
				deptDao.delete(dept);
			}
		}
		
	}

	public List<Department> findAll() {
		return deptDao.findAll();
	}
	
}
