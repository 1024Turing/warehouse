<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   
    
    <title>仓库初始化</title>
<!-- 导入jquery核心类库 -->
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery-1.11.3.min.js"></script>
<!-- 导入easyui类库 -->
<link id="easyuiTheme" rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui/themes/icon.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/easyui/jquery.easyui.min.js"></script>
<script
	src="${pageContext.request.contextPath }/js/easyui/locale/easyui-lang-zh_CN.js"
	type="text/javascript"></script>
<script type="text/javascript">
	$(function(){
		// 先将body隐藏，再显示，不会出现页面刷新效果
		$("body").css({visibility:"visible"});
		
		
	});
	function goBack()
	{
	  window.history.back();
	}
	function doApe(obj)
	{
	  $("#ao_state").val(obj);
	  $("#applyForm").submit();
	  
	}
	


 </script> 
  <style type="text/css">
 	table
  {
  border-collapse:collapse;
  }
 </style> 		
  </head>
  
<body class="easyui-layout" style="visibility:hidden;">

	<form id="applyForm" action="${pageContext.request.contextPath}/applyAction_edit.action" method="post" >
		<input type="hidden" name="ao_id" value="${model.ao_id }" />
		<input type="hidden" name="ao_state" id="ao_state" />
		
	    <div title="申请单" data-options="region:'north'" style="height:140px ;background-color:;">
	    	<div style="margin-left:20px;margin-top:6px">
	    		<c:choose>
		 			<c:when test="${model.ao_state eq '未审批'}">
		 				<span>审批人 :</span><input type="text" name="ao_opetator" value="${user.staff.stf_name }">
		 			</c:when>
		 			<c:otherwise>
		 				<span>审批人 :</span><input type="text" name="ao_opetator" value="${model.ao_opetator }">
		 			</c:otherwise>
		 		</c:choose>
		 		<hr>
		 		<span>申请人 :</span><input type="text" name="ao_name" value="${model.ao_name }">
	    		<span>说     明 :</span><textarea style="resize: none;width:250px;height:38px" name="ao_details"  >${model.ao_details }</textarea><br>	    		
	    		
	    	</div>
		</div>

		<div title="物品栏" s data-options="region:'center'">
			<table border="" id="">
				<tr>
					<th >分类</th>
					<th>名称</th>
					<th>规格</th>
					<th>型号</th>
					<th>计量单位</th>
					<th>数量</th>
				</tr>
				<c:forEach items="${model.items }" var="item">
				<tr >
					<td>
						<input type="text" name= "secondcode" value="${item.secondcode }">
					</td>
					<td><input type="text" name= "goods_name" value="${item.goods_name }"></td>
					<td><input type="text" name= "standard" value="${item.standard }"></td>
					<td><input type="text" name= "type" value="${item.type }"></td>
					<td><input type="text" name= "unit" value="${item.unit }"></td>
					<td><input type="text" name= "goods_count" value="${item.goods_count }"></td>
				</tr>
				</c:forEach>
			</table>	
		</div>
		<div title=""  data-options="region:'south'"  style="height:90px ;background-color:;" >
			<div style="margin-left:200px;margin-top:15px">
			<c:if test="${model.ao_state eq '未审批'}">
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="doApe('1')" style="margin-left:20px">批准</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-no'" onclick="doApe('2')" style="margin-left:20px">不批准</a>
			</c:if>
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back'" onclick="goBack()" style="margin-left:20px">返回</a>
			</div>
		</div>
	</form>	
	

  </body>
</html>
