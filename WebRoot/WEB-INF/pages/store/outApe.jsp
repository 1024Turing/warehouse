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
	function doOut()
	{

	  $("#outForm").submit();
	  
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

	<form id="outForm" action="${pageContext.request.contextPath}/outputAction_save.action" method="post" >
		<input type="hidden" name="out_id" value="${model.ao_id }" />
		
		
		
	    <div title="出库单" data-options="region:'north'" style="height:180px ;background-color:;">
	    
	    	<div style="margin-left:20px;margin-top:6px;">
	    		<c:choose>
		 			<c:when test="${model.ao_isout eq '未出库'}">
		 				<span>出库人 :</span><input type="text" name="out_name" value="${user.staff.stf_name }">
		 			</c:when>
		 			<c:otherwise>
		 				<span>出库人 :</span><input type="text" name="out_name" value="${out_name }">
		 			</c:otherwise>
		 		</c:choose>
	    		<span style="margin-left:80px;">出库说 明 :</span><textarea style="resize: none;width:250px;height:38px" name="out_details"  >${out_details }</textarea><br>	    		
				<br>
	    	</div>
	    	<hr>
	    	<div style="margin-left:20px;margin-top:6px">
	    		
	    		<span>审批人 :</span><input type="text" name="ao_opetator" value="${model.ao_opetator }" readonly="readonly">
	    		<span>申请人 :</span><input type="text" name="ao_name" value="${model.ao_name }" readonly="readonly"><br>
	    		<span>说     明 :</span><textarea style="resize: none;width:250px;height:38px" name="ao_details"  readonly="readonly">${model.ao_details }</textarea><br>	    			
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
			<c:if test="${model.ao_isout eq '未出库'}">
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="doOut()" style="margin-left:20px">出库</a>
			</c:if>
			
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back'" onclick="goBack()" style="margin-left:20px">返回</a>
			</div>
		</div>
	</form>	
	

  </body>
</html>
