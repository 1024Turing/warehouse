package com.zhuang.warehouse.dao.impl;


import java.util.List;

import org.springframework.stereotype.Repository;

import com.zhuang.warehouse.dao.IndexDao;
import com.zhuang.warehouse.domain.Menus;
import com.zhuang.warehouse.domain.User;
@Repository
public class IndexDaoImpl extends BaseDaoImpl<Menus> implements IndexDao {

	public List<Menus> findByUser(User user) {
		String sql="SELECT DISTINCT m.* "
				+ " FROM menu m LEFT OUTER JOIN  role_menu rm ON m.self_code = rm.menu_code "
				+ " LEFT OUTER JOIN  user_role ur ON ur.role_id = rm.role_id"
				+ " WHERE ur.user_id='"+user.getUser_id().trim()+"' ORDER BY m.self_code";
		List<Menus> list=this.getSessionFactory().getCurrentSession().createSQLQuery(sql).addEntity(Menus.class).list();
		
		return list;
	}


}
