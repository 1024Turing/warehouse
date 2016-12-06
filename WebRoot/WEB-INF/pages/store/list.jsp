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
		field : 'rec_id',
		checkbox : true,
	},{
		field : 'secondcode',
		title : '物品类别',
		width : 180,
		align : 'center'
	},{
		field : 'goods_name',
		title : '物品名称',
		width : 120,
		align : 'center',
		
	},{
		field : 'standard',
		title : '规格',
		width : 120,
		align : 'center'
	},{
		field : 'type',
		title : '型号',
		width : 120,
		align : 'center'
	},{
		field : 'unit',
		title : '计量单位',
		width : 120,
		align : 'center'
	},{
		field : 'end',
		title : '总量',
		width : 120,
		align : 'center'
	}
	] ];
	
	$(function(){
		// 先将body隐藏，再显示，不会出现页面刷新效果
		$("body").css({visibility:"visible"});
		
		$.post("${pageContext.request.contextPath}/gcodAction_findByPid",{"pId":"0"}, function(data){
			$(data).each(function(i,n){
				$("#firstcode").append("<option value='"+n.id+"'>"+n.name+"</option>");
			});
		},"json");
		
		
		// 取派员信息表格
		$('#grid').datagrid( {
			iconCls : 'icon-forward',
			fit : true,
			border : false,
			rownumbers : true,
			striped : true,
			pageList: [16],
			pagination : true,
			toolbar : '#tb',
			url : "${pageContext.request.contextPath}/recordsAction_pageQuery.action",
			idField : 'rec_id',
			columns : columns,
			onDblClickRow : doDblClickRow
		});
		
	
		
	});

	function doDblClickRow(rowIndex, rowData){
		$("#editStaffWindow").window("open");
		
		$("#editStaffWindow").form("load",rowData);
	}
	function doExport(){
		
	}
	function doSearch(){
		$('#grid').datagrid('load',{
			goods_name: $('#goods_name').val(),
			firstcode: $('#firstcode').val(),
			secondcode:$('#secondcode').val()
		});
	}
	function doChange(obj){
		var pId=$(obj).val();
		$("#secondcode").empty();
		$("#secondcode").append("<option value='' >---请选择---</option>");
		$.post("${pageContext.request.contextPath}/gcodAction_findByPid",{"pId":pId}, function(data){
			$(data).each(function(i,n){
				$("#secondcode").append("<option value='"+n.id+"'>"+n.name+"</option>");
			});
		},"json");
	}
</script>	
</head>

<body class="easyui-layout" style="visibility:hidden;">
	<div id="tb" style="padding:3px">
		<a id="button-add" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="doExport()" plain="true">导出</a>
		<span style="margin-left:20px">物品名称:</span>
			<input type="text" id="goods_name" />
		<span style="margin-left:20px">分类 :</span>
			<select id="firstcode" onChange="doChange(this)" style="width:120px">
				<option value="">---请选择---</option>
			</select>
			<select id="secondcode" style="width:120px">
				<option value="">---请选择---</option>
			</select>
		
		<a href="javascript:void(0)" class="easyui-linkbutton" plain="true" onclick="doSearch()" style="margin-left:20px">查询</a>
	</div>
	<div region="center" border="false">
    	<table id="grid"></table>
	</div>
	
		
	
</body>
</html>	