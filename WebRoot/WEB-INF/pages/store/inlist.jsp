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
		field : 'che_id',
		checkbox : true,
	},{
		field : 'che_name',
		title : '操作人',
		width : 120,
		align : 'center'
	},{
		field : 'che_time',
		title : '时间 ',
		width : 180,
		align : 'center'
	},{
		field : 'input',
		title : '入库',
		width : 120,
		align : 'center'
	}
	] ];

	$(function(){
		// 先将body隐藏，再显示，不会出现页面刷新效果
		$("body").css({visibility:"visible"});
		

		
		
		// 取派员信息表格
		$('#grid').datagrid( {
			iconCls : 'icon-forward',
			fit : true,
			border : false,
			rownumbers : true,
			striped : true,
			pageList: [6,10],
			pagination : true,
			toolbar : '#tb',
			url : "${pageContext.request.contextPath}/checkAction_pageQuery.action",
			idField : 'che_id',
			columns : columns,
			onDblClickRow : doDblClickRow
		});
		
	
		
	});

	function doDblClickRow(rowIndex, rowData){
		window.location.href="${pageContext.request.contextPath}/inputAction_load.action?in_id="+rowData.che_id;
	}


	function doSearch(param){

		 $('#grid').datagrid('load',{ 
			 input: param
			
		}); 
	}

</script>	
</head>

<body class="easyui-layout" style="visibility:hidden;">
	<div id="tb" style="padding:3px">
		<a href="javascript:void(0)" class="easyui-linkbutton" plain="false" onclick="doSearch('0')" style="margin-left:20px">全部</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" plain="false" onclick="doSearch('1')" style="margin-left:20px">已入库</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" plain="false" onclick="doSearch('2')" style="margin-left:20px">未入库</a>
		
	</div>
	<div region="center" border="false">
    	<table id="grid"></table>
	</div>
	
		
	
</body>
</html>	