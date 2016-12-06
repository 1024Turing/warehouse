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
		//扩展校验规则,对数量进行校验
		var reg=/^[1|2|3|4|5|7|6|8|9|][0-9]*$/;
		$.extend($.fn.validatebox.defaults.rules,{
			goods_count:{
				validator:function(value,param){
					return reg.test(value) && value.length >= 1 && value.length <= 10;
				},
				message: "数量格式不正确"
			},
			 length: {   
			        validator: function(value, param){   
			            return value.length >= 1 && value.length <= 10;   
			        },   
			        message: "位数在1到10位之间"  
			    }  
		});
		
	});
	function goBack()
	{
	  window.history.back();
	}

	function doApe(obj)
	{
	  $("#sec_result").val(obj);
	  var v = $("#saForm").form("validate");
		if(v){
			//校验通过，提交表单
			$("#saForm").submit();
		}
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
	
	    <div title="一级审批单" data-options="region:'north'" style="height:250px ;background-color:;">
	    	<div style="margin-left:20px;margin-top:6px">
	    		<span>一级审批人 :</span><input type="text" name="fa_name" value="${fa_name }" readonly="readonly">
	    		<span>说     明 :</span><textarea style="resize: none;width:250px;height:38px" name="fa_details"  readonly="readonly">${fa_details }</textarea><br>	    			
	    	</div>
	    	<table border="" id="">
				<tr>
					<th >分类</th>
					<th>名称</th>
					<th>规格</th>
					<th>型号</th>
					<th>计量单位</th>
					<th>数量</th>
				</tr>
				<c:forEach items="${items }" var="item">
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

		<div title="二级审批单" data-options="region:'center'">
		<c:if test="${sec_result ne '未过' }">
		<form id="saForm" action="${pageContext.request.contextPath}/secondApeAction_save.action" method="post" >
			<input type="hidden" value="${model.sa_id }"  name ="sa_id"/>
			<input type="hidden" value=""  name ="sec_result" id="sec_result"/>
			
		 	<div style="margin-left:20px;margin-top:6px;">
		 		<c:choose>
		 			<c:when test="${sec_result eq '未审批'}">
		 				<span>二级审批人 :</span><input type="text" name="sa_name" value="${user.staff.stf_name }">
		 			</c:when>
		 			<c:otherwise>
		 				<span>二级审批人 :</span><input type="text" name="sa_name" value="${model.sa_name }">
		 			</c:otherwise>
		 		</c:choose>
	    		<span style="margin-left:80px;">审批说 明 :</span><textarea style="resize: none;width:250px;height:38px" name="sa_details"  >${model.sa_details }</textarea><br>	    		
				<br>
	    	</div>
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
				<input type="hidden" value="${item.item_id }"  name ="item_id"/>
				<tr >
						
					<td>
						<input type="text" name= "secondcode" value="${item.secondcode }">
					</td>
					<td><input type="text" name= "goods_name" value="${item.goods_name }"></td>
					<td><input type="text" name= "standard" value="${item.standard }"></td>
					<td><input type="text" name= "type" value="${item.type }"></td>
					<td><input type="text" name= "unit" value="${item.unit }"></td>
					<td><input type="text" name= "goods_count" value="${item.goods_count }" class="easyui-validatebox" required="true" data-options="validType:'goods_count'" ></td>
				</tr>
				</c:forEach>
			</table>	
			</form>
			</c:if>
		</div>
		<div title=""  data-options="region:'south'"  style="height:50px ;background-color:;" >
			<div style="margin-left:200px;margin-top:15px">
			<c:if test="${sec_result eq '未审批'}">
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="doApe('1')" style="margin-left:20px">批准</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-no'" onclick="doApe('2')" style="margin-left:20px">不批准</a>
			</c:if>
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back'" onclick="goBack()" style="margin-left:20px">返回</a>
			</div>
		</div>

	
	
  </body>
</html>
