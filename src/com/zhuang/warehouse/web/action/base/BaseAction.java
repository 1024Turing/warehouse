package com.zhuang.warehouse.web.action.base;

import java.io.IOException;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.apache.struts2.ServletActionContext;
import org.hibernate.criterion.DetachedCriteria;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import com.zhuang.warehouse.domain.PageBean;
import com.zhuang.warehouse.utils.CommonUtils;
import com.zhuang.warehouse.utils.JsonDateValueProcessor;

/**
 * 表现层通用实现
 * 
 *
 * @param <T>
 */
public class BaseAction<T> extends ActionSupport implements ModelDriven<T> {
	// 抽取分页相关
			// 接收分页参数
			protected PageBean pageBean = new PageBean();
			DetachedCriteria detachedCriteria = null;

			public void setPage(int page) {
				pageBean.setCurrentPage(page);
			}

			public void setRows(int rows) {
				pageBean.setPageSize(rows);
			}
	/**
	 * 将指定对象转为json，通过输出流写回客户端
	 * 对象类型
	 */
	public void writeObject2Json(Object o ,String[] excludes){
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.registerJsonValueProcessor(Date.class , new JsonDateValueProcessor());
		jsonConfig.setExcludes(excludes);
		
		//将集合对象转为json数据
		String json = JSONObject.fromObject(o,jsonConfig).toString();
		//System.out.println(json.toString());
		//通过输出流将json数据写回客户端
		
		ServletActionContext.getResponse().setContentType("text/json;charset=UTF-8");
		try {
			
			ServletActionContext.getResponse().getWriter().print(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**
	 * 将指定对象转为json，通过输出流写回客户端
	 * 
	 * 数组类型
	 */
	public void writeObject2Json(List o ,String[] excludes){
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setExcludes(excludes);
		
		//将PageBean对象转为json数据
		String json = JSONArray.fromObject(o,jsonConfig).toString();
		
		//通过输出流将json数据写回客户端
		ServletActionContext.getResponse().setContentType("text/json;charset=UTF-8");
		try {
			ServletActionContext.getResponse().getWriter().print(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	protected T model;
	public T getModel() {
		// TODO Auto-generated method stub
		return this.model;
	}
	
	public BaseAction(){
		// 获得父类（BaseAction<T>）的类型
				ParameterizedType genericSuperclass = (ParameterizedType) this.getClass().getGenericSuperclass();
				// 获得父类上声明的泛型数组
				Type[] actualTypeArguments = genericSuperclass.getActualTypeArguments();
				// 获得实体类型
				Class<T> entityClass = (Class<T>) actualTypeArguments[0];
				detachedCriteria = DetachedCriteria.forClass(entityClass);
				pageBean.setDetachedCriteria(detachedCriteria);
				try {
					// 通过反射创建模型对象
					model = entityClass.newInstance();
				} catch (InstantiationException e) {
					e.printStackTrace();
				} catch (IllegalAccessException e) {
					e.printStackTrace();
				}
	}
	
	// 接受物品项的参数
	protected String[] secondcode;
	protected String[] goods_name;
	protected String[] standard;
	protected String[] type;
	protected String[] unit;
	protected String[] goods_count;
	//封装成物品List
//封装成goodsIntem --goods--
	
	public void setGoods_name(String[] goods_name) {
		this.goods_name = goods_name;
	}

	public void setSecondcode(String[] secondcode) {
		this.secondcode = secondcode;
	}

	public void setStandard(String[] standard) {
		this.standard = standard;
	}

	public void setType(String[] type) {
		this.type = type;
	}

	public void setUnit(String[] unit) {
		this.unit = unit;
	}

	public void setGoods_count(String[] goods_count) {
		this.goods_count = goods_count;
	}
}
