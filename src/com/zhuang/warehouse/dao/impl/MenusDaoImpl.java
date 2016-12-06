package com.zhuang.warehouse.dao.impl;


import java.util.List;

import org.springframework.stereotype.Repository;

import com.zhuang.warehouse.dao.MenusDao;
import com.zhuang.warehouse.domain.Menus;
@Repository
public class MenusDaoImpl extends BaseDaoImpl<Menus> implements MenusDao {

	public List<Menus> findByRole(String role_id) {
		String sql="SELECT DISTINCT m.* "
				+ " FROM menu m LEFT OUTER JOIN role_menu rm "
				+ " ON m.self_code=rm.menu_code "
				+ " WHERE rm.role_id='"+role_id+"'";
		List<Menus> list=this.getSessionFactory().getCurrentSession().createSQLQuery(sql).addEntity(Menus.class).list();

		return list;
	}
	


}
