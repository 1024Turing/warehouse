package com.zhuang.warehouse.dao.base;

import java.io.Serializable;
import java.util.List;

import com.zhuang.warehouse.domain.PageBean;

public interface BaseDao<T> {
	
	public void save(T entity);
	
	public void update(T entity);
	
	public void delete(T entity);
	
	public T findById(Serializable id);
	
	public List<T> findAll();
	
	public void pageQuery(PageBean pageBean);

	public void executeUpdate(String queryName ,Object ...objects);
}
