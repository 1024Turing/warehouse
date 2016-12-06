package com.zhuang.warehouse.dao.impl;


import java.util.List;

import org.hibernate.SQLQuery;
import org.springframework.stereotype.Repository;

import com.zhuang.warehouse.dao.RoleDao;
import com.zhuang.warehouse.domain.Role;
@Repository
public class RoleDaoImpl extends BaseDaoImpl<Role> implements RoleDao {

	public void saveMenus(String role_id, String[] menusIds) {
		for(String id:menusIds ){
				
			String sql=" insert into role_menu values ('"+role_id+"','"+ id+"') ";
			
			 SQLQuery query =this.getSessionFactory().getCurrentSession().createSQLQuery(sql);    
		     query.executeUpdate(); 
		}
	}

	public List<Role> findByUser(String user_id) {
		String sql= "select r.* from role r "
				+ "left outer join user_role ur on r.role_id = ur.role_id "
				+ "WHERE ur.user_id = '"+user_id+"'";
		return	this.getSessionFactory().getCurrentSession().createSQLQuery(sql).addEntity(Role.class).list();
	
	}
	//删除与该角色关联的所有数据 user_role role  role_menu
	public void deleteAll(String id) {
		Role r=this.findById(id);
		this.delete(r);
		
		//user_role表
		String sql="delete from user_role where role_id = '"+id+"'";
		this.getSessionFactory().getCurrentSession().createSQLQuery(sql).executeUpdate();
		//
		delMenus(id);
	}
	//根据role_id删除role_menu表中的数据
	public void delMenus(String role_id) {
		String sql="delete from role_menu where role_id = '"+role_id+"'";
		this.getSessionFactory().getCurrentSession().createSQLQuery(sql).executeUpdate();
	}

	

}
