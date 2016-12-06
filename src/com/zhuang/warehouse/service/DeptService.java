package com.zhuang.warehouse.service;

import java.util.List;

import com.zhuang.warehouse.domain.Department;
import com.zhuang.warehouse.domain.PageBean;

public interface DeptService {

	void save(Department model);

	void pageQuery(PageBean pageBean);

	void edit(Department model);

	Department findById(String dept_id);

	void deleteBatch(String ids);

	List<Department> findAll();

}
