package com.zhuang.warehouse.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zhuang.warehouse.dao.PersonstDao;
import com.zhuang.warehouse.domain.PageBean;
import com.zhuang.warehouse.domain.Personstate;

import com.zhuang.warehouse.service.PersonstService;
@Service
@Transactional
public class PersonstServiceImpl implements PersonstService {
	
	@Resource
	private PersonstDao personstDao;

	public void save(Personstate model) {
		personstDao.save(model);
		
	}

	public void update(Personstate pst) {
		personstDao.update(pst);
		
	}

	public void pageQuery(PageBean pageBean) {
		personstDao.pageQuery(pageBean);
		
	}

	public void deleteBatch(String ids) {
		if(StringUtils.isNotBlank(ids)){
			String[] array=ids.split(",");
			for(String id :array){
				Personstate pst=personstDao.findById(id);
				personstDao.delete(pst);
			}
		}
		
	}

	public Personstate findById(String pst_id) {
		return personstDao.findById(pst_id);
	}

	public List<Personstate> findAll() {
		
		return personstDao.findAll();
	}

}
