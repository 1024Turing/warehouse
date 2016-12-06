<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	href="${pageContext.request.contextPath }/js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui/ext/portal.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/css/default.css">	
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/easyui/ext/jquery.portal.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/easyui/ext/jquery.cookie.js"></script>
<script
	src="${pageContext.request.contextPath }/js/easyui/locale/easyui-lang-zh_CN.js"
	type="text/javascript"></script>
<!-- 导入ztree类库 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/js/ztree/zTreeStyle.css"
	type="text/css" />
<script
	src="${pageContext.request.contextPath }/js/ztree/jquery.ztree.all-3.5.js"
	type="text/javascript"></script>	
<script type="text/javascript">
	$(function(){
		// 数据表格属性
		$("#grid").datagrid({
			toolbar : [
				{
					id : 'add',
					text : '添加角色',
					iconCls : 'icon-add',
					handler : function(){
						location.href='${pageContext.request.contextPath}/page_admin_role_add.action';
					}
				},          
				{
					id : 'del',
					text : '删除',
					iconCls : 'icon-cancel',
					handler : doDelete
				}           
			],
			iconCls : 'icon-forward',
			fit : true,
			border : false,
			rownumbers : true,
			striped : true,
			pageList: [5,10],
			pagination : true,
			idField : 'role_id',
			
			
			
			
			onDblClickRow : doDblClickRow,
			url : '${pageContext.request.contextPath}/roleAction_pageQuery.action',
			columns : [[
				{
					field : 'role_id',
					checkbox : true
				},
				{
					field : 'role_name',
					title : '名称',
					width : 200
				}, 
				{
					field : 'role_desc',
					title : '描述',
					width : 200
				} 
			]]
		});
	});
	
	
	function doDelete(){
		var rows=$("#grid").datagrid("getSelections");
		if(rows.length==0){
			$.messager.alert("提示信息","请选择需要删除的角色！","info");
			
		}else{
			$.messager.confirm("提示信息","你确定删除当前选中的角色吗？",function(r){
				if(r){
					var ids="";
					var array=new Array();
					for(var i=0;i<rows.length;i++){	
						var id = rows[i].role_id;
						array.push(id);
					}
					ids=array.join(",");
					location.href = "${pageContext.request.contextPath}/roleAction_delete.action?role_ids="+ids;
				}
			})
		}
	}
	function doDblClickRow(rowIndex, rowData){
		window.location.href="${pageContext.request.contextPath}/roleAction_editPre.action?role_id="+rowData.role_id;
	}
</script>	
</head>
<body class="easyui-layout">
	<div data-options="region:'center'">
		<table id="grid"></table>
	</div>
</body>
</html>