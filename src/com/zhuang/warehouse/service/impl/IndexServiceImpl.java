package com.zhuang.warehouse.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.opensymphony.xwork2.ActionContext;
import com.zhuang.warehouse.dao.IndexDao;
import com.zhuang.warehouse.domain.Menus;
import com.zhuang.warehouse.domain.User;
import com.zhuang.warehouse.service.IndexService;
@Service
@Transactional
public class IndexServiceImpl implements IndexService {
	@Resource
	private IndexDao indexDao;

	public Map loadMenu() {
		User user=(User) ActionContext.getContext().getSession().get("user");
		List<Menus> menuList=null;
		if(user.getUser_id().equals("43534534523ff")){
			menuList=indexDao.findAll();
		}else{
			menuList=indexDao.findByUser(user);
		}
		Map<String ,List> map=new HashMap();
		
		for(Menus menu: menuList){
			//获得父节点
			String pcode=menu.getPcode();
			if(map.get(pcode)!=null){				
				map.get(pcode).add(menu);
			}else{
				List list=new  ArrayList();
				list.add(menu);
				map.put(pcode,list);
				
			}
		
		}
		System.out.println(map.toString());
		return map;
	}
	
	
}
