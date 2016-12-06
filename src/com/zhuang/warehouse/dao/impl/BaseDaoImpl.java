package com.zhuang.warehouse.dao.impl;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.springframework.orm.hibernate5.support.HibernateDaoSupport;






import com.zhuang.warehouse.dao.base.BaseDao;
import com.zhuang.warehouse.domain.PageBean;

public  class BaseDaoImpl<T>  extends HibernateDaoSupport implements BaseDao<T> {

	private Class<T> entityClass;
	
	@Resource//可以按照bean的id注入，也可以按照bean的类型注入
	//@Autowired//只能按照类型注入,如果需要按照id注入，需要结合@Qualifier注解一起使用
	//@Qualifier(value="abc")
	public void setMySessionFactory(SessionFactory sessionFactory){	
		super.setSessionFactory(sessionFactory);
		
	}
	public BaseDaoImpl(){
		// 泛型的反射:
		Class clazz = this.getClass();// 获得是子类的Class: CustomerDaoImpl/LinkManDaoImpl的Class对象.
		// 调用Class的方法带有泛型的父类:
		Type type = clazz.getGenericSuperclass();// BaseDaoImpl<Customer>/BaseDaoImpl<LinkMan> 
		// 已经获得了参数化的类型:
		if(type instanceof ParameterizedType){
			ParameterizedType pType =  (ParameterizedType) type;// 参数化的类型BaseDaoImpl<Customer>
			// 获得实际类型参数
			Type[] types = pType.getActualTypeArguments();
			// 获得某一个实际类型参数:
			this.entityClass = (Class) types[0];
		}	
	}
	
	

	public void save(T entity) {
		this.getHibernateTemplate().save(entity);
		this.getHibernateTemplate().flush();
		
	}

	
	public void update(T entity) {
		this.getHibernateTemplate().update(entity);
		this.getHibernateTemplate().flush();
	}

	
	public void delete(T entity) {
		this.getHibernateTemplate().delete(entity);
		this.getHibernateTemplate().flush();
	}

	
	public T findById(Serializable id) {
		return (T)this.getHibernateTemplate().get(entityClass, id);
		
	}

	
	public List<T> findAll() {
		
		return (List<T>) this.getHibernateTemplate().find("FROM "+ entityClass.getSimpleName());
	}
	public void pageQuery(PageBean pageBean){
		DetachedCriteria detachedCriteria=pageBean.getDetachedCriteria();
		//查询总记录数
		detachedCriteria.setProjection(Projections.rowCount());
		int total=0;
		List<Long> totalList=(List<Long>) this.getHibernateTemplate().findByCriteria(detachedCriteria);
		if(totalList.size()>0){
			total= totalList.get(0).intValue();
		}
		pageBean.setTotal(total);
		//查询每页的记录
		detachedCriteria.setProjection(null);
		int begin=(pageBean.getCurrentPage()-1)*pageBean.getPageSize();
		List<T> list=(List<T>) this.getHibernateTemplate().findByCriteria(detachedCriteria,begin,pageBean.getPageSize());
		pageBean.setRows(list);
		this.getHibernateTemplate().getSessionFactory().getCurrentSession().clear();
	}
	public void executeUpdate(String queryName, Object... objects) {
		/*
		 * getNamedQuery(String queryName)
           	从映射文件中根据给定的查询的名称字符串获取一个Query（查询）实例。
		 */
		Query query = this.getSessionFactory().getCurrentSession().getNamedQuery(queryName);
		int i = 0;
		for (Object object : objects) {
			//每次循环为？赋值
			query.setParameter(i++,object);
		}
		//执行更新
		query.executeUpdate();
		
	}
	
	
	

}
