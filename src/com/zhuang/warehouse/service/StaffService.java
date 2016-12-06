package com.zhuang.warehouse.service;

import com.zhuang.warehouse.domain.PageBean;
import com.zhuang.warehouse.domain.Staff;

public interface StaffService {

	void deleteBatch(String ids);

	void pageQuery(PageBean pageBean);

	void update(Staff staff);

	Staff findById(String stf_id);

	void save(Staff model);

}
