package com.zhuang.warehouse.dao.impl;


import java.util.List;

import org.hibernate.SQLQuery;
import org.springframework.stereotype.Repository;

import com.zhuang.warehouse.dao.UserDao;
import com.zhuang.warehouse.domain.User;
@Repository
public class UserDaoImpl extends BaseDaoImpl<User> implements UserDao {

	
	public User findByUsernameAndPassword(String user_code, String password) {
		List<User> list=(List<User>) this.getHibernateTemplate().find("FROM User WHERE user_code = ? AND password = ?",
				user_code,password);
		if(list!=null && list.size()>0){
			return list.get(0);
		}
		return null;
	}

	public void edit(String user_id, String[] roleIds) {
		//先清空，再添加
		String delSql="delete from user_role where user_id= '"+user_id+"'";
		this.getSessionFactory().getCurrentSession().createSQLQuery(delSql).executeUpdate(); 

		for(String roleid : roleIds ){
			//保存数据
			String saveSql="insert into user_role values('"+user_id+"','"+roleid+"')";
			this.getSessionFactory().getCurrentSession().createSQLQuery(saveSql).executeUpdate(); 
		}
		
	}

	public void del(String id) {
		//从user表中删除
		User user=this.findById(id);
		this.delete(user);
		//从user_role中删除
		String sql="delete from user_role where user_id ='"+id+"'";
		this.getSessionFactory().getCurrentSession().createSQLQuery(sql).executeUpdate();
	}

}
