package com.zhuang.warehouse.service;

import java.util.List;

import com.zhuang.warehouse.domain.PageBean;
import com.zhuang.warehouse.domain.Personstate;

public interface PersonstService {

	void save(Personstate model);



	void update(Personstate pst);

	void pageQuery(PageBean pageBean);

	void deleteBatch(String ids);



	Personstate findById(String pst_id);



	List<Personstate> findAll();

}
