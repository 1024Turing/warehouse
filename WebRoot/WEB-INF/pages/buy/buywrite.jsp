<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- 导入jquery核心类库 -->
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery-1.8.3.js"></script>
<!-- 导入easyui类库 -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui2/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui2/themes/icon.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui2/ext/portal.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/css/default.css">	
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/easyui2/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/easyui2/ext/jquery.portal.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/easyui2/ext/jquery.cookie.js"></script>
<script
	src="${pageContext.request.contextPath }/js/easyui2/locale/easyui-lang-zh_CN.js"
	type="text/javascript"></script>
<!--日期插件  -->
<script type="text/javascript" src="${pageContext.request.contextPath }/js/date/lhgcore.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/date/lhgcalendar.js"></script>
<script type="text/javascript">
	// 定义列
	var columns = [ [ {
		field : 'item_id',
		checkbox : true,
	},{
		field : 'secondcode',
		title : '物品分类',
		width : 120,
		align : 'center',
		formatter:function(value,row,index){
			var code = value.substring(4);
			return code; 
		}
	},{
		field : 'goods_name',
		title : '名称',
		width : 120,
		align : 'center',
	},{
		field : 'standard',
		title : '规格',
		width : 120,
		align : 'center'
	},{
		field : 'type',
		title : '类型',
		width : 120,
		align : 'center'
	},{
		field : 'unit',
		title : '计量单位',
		width : 120,
		align : 'center'
	},{
		field : 'goods_count',
		title : '数量',
		width : 120,
		align : 'center'
	}
	] ];
	
	$(function(){
		// 先将body隐藏，再显示，不会出现页面刷新效果
		$("body").css({visibility:"visible"});

		$('#grid').datagrid( {
			iconCls : 'icon-forward',
			fit : true,
			border : false,
			rownumbers : true,
			striped : true,
			pageList: [5,10],
			pagination : true,
			url : "${pageContext.request.contextPath}/itemAction_pageQuery.action",
			idField : 'item_id',
			columns : columns
		});
	});

	function doSave(){
		var rows=$("#grid").datagrid("getSelections");
		if(rows.length==0){
			$.messager.alert("提示信息","请选择采购项！","info");
			
		}else{
				var ids="";
				var array=new Array();
				for(var i=0;i<rows.length;i++){	
					var id = rows[i].item_id;
					array.push(id);
				}
				ids=array.join(",");
				$("#item_ids").val(ids);
				
				$("#buyForm").submit();	
		}
	}
	
	function goBack()
	{
	  window.history.back();
	}
	
</script>	
</head>

<body class="easyui-layout" style="visibility:hidden;">
	<div title="采购单填写" data-options="region:'north'" style="height:140px ;background-color:;">
		
	    	<div style="margin-left:20px;margin-top:6px">
	    		<form id="buyForm" action="${pageContext.request.contextPath}/buyAction_save.action" method="post">
	    		<input type="hidden" name="item_ids"  id="item_ids">
	    		<span>操作人 :</span><input type="text" name="buy_name"value="${user.staff.stf_name }">
	    		<span>说     明 :</span><textarea style="resize: none;width:250px;height:38px" name="bo_details"></textarea><br>	    		
	    		 </form>
	    		<div style="margin-top:5px;">
		    	<a id="button-save" onclick="doSave()" style="margin-left:30px;" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
		    	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back'" onclick="goBack()" style="margin-left:20px">返回</a>
		    	</div>
	    	</div>
	
	</div>
	
	<div region="center" border="false">
    	<table id="grid"></table>
	</div>
	
</body>
</html>	