<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>物品状态</title>
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
<script type="text/javascript">
	

	function doAdd(){
		$('#addDeptWindow').window("open");
	}
	function doDelete(){
		var rows=$("#grid").datagrid("getSelections");
		if(rows.length==0){
			$.messager.alert("提示信息","请选择需要删除的部门！","info");
			
		}else{
			$.messager.confirm("提示信息","你确定删除当前选中的部门吗？",function(r){
				if(r){
					var ids="";
					var array=new Array();
					for(var i=0;i<rows.length;i++){	
						var id = rows[i].dept_id;
						array.push(id);
					}
					ids=array.join(",");
					location.href = "${pageContext.request.contextPath}/deptAction_delete.action?ids="+ids;
				}
			})
		}
	}
	
	function doEdit(){
		var rows=$("#grid").datagrid("getSelections");
		if(rows.length==0){
			$.messager.alert("提示信息","请选择需要修改的部门！","info");
			
		}else if(rows.length>1){
			$.messager.alert("提示信息","一次只允许修改单行数据","info");
		}else{
			$.messager.confirm("提示信息","你确定修改当前选中的部门吗？",function(r){
				if(r){
					$("#editDeptWindow").window("open");
					$("#editDeptWindow").form("load",rows[0]);
				}
			})
		}
	}
	//工具栏
	var toolbar = [ {
		id : 'button-add',
		text : '增加',
		iconCls : 'icon-add',
		handler : doAdd
	}, {
		id : 'button-delete',
		text : '删除',
		iconCls : 'icon-cancel',
		handler : doDelete
	},{
		id : 'button-edit',
		text : '修改',
		iconCls : 'icon-edit',
		handler : doEdit
	}];
	// 定义列
	var columns = [ [ {
		field : 'dept_id',
		checkbox : true,
	},{
		field : 'dept_name',
		title : '部门名称',
		width : 200,
		align : 'center'
	}] ];
	
	$(function(){
		
		//保存验证
		$("#save").click(function(){
			//进行表单校验
			var v = $("#addDeptForm").form("validate");
			if(v){
				//校验通过，提交表单
				$("#addDeptForm").submit();
			}
		});
		//修改验证
		$("#edit").click(function(){
			//进行表单校验
			var v = $("#editDeptForm").form("validate");
			if(v){
				//校验通过，提交表单
				$("#editDeptForm").submit();
			}
		});

		// 先将body隐藏，再显示，不会出现页面刷新效果
		$("body").css({visibility:"visible"});
		
		// 取派员信息表格
		$('#grid').datagrid( {
			iconCls : 'icon-forward',
			fit : true,
			border : false,
			rownumbers : true,
			striped : true,
			pageList: [5,8,12],
			pagination : true,
			toolbar : toolbar,
			url : "${pageContext.request.contextPath}/deptAction_pageQuery.action",
			idField : 'dept_id',
			columns : columns,
			onDblClickRow : doDblClickRow
		});
		
		// 添加取派员窗口
		$('#addDeptWindow').window({
	        title: '添加部门',
	        width: 400,
	        modal: true,
	        shadow: true,
	        closed: true,
	        height: 200,
	        resizable:false
	    });
		// 添加取派员窗口
		$('#editDeptWindow').window({
	        title: '修改部门名称',
	        width: 400,
	        modal: true,
	        shadow: true,
	        closed: true,
	        height: 200,
	        resizable:false
	    });
		
	});

	function doDblClickRow(rowIndex, rowData){
		$("#editDeptWindow").window("open");
		
		$("#editDeptWindow").form("load",rowData);
	}
</script>	
</head>
<body class="easyui-layout" style="visibility:hidden;">
	<div region="center" border="false">
    	<table id="grid"></table>
	</div>
	<!-- 添加窗口 -->
	<div class="easyui-window" title="对部门进行添加" id="addDeptWindow" collapsible="false" minimizable="false" maximizable="false" style="top:70px;left:350px">
		<div region="north" style="height:50px;overflow:hidden;" split="false" border="false" >
			<div class="datagrid-toolbar">
				<a id="save" icon="icon-save" href="javascript:void(0)" class="easyui-linkbutton" plain="true" >保存</a>
			</div>
		</div>
		
		<div region="center" style="overflow:auto;padding:5px;" border="false">
			<form id="addDeptForm" action="${pageContext.request.contextPath }/deptAction_add.action" method="post">
				<table class="table-edit" width="80%" align="center">		
					<tr>
						<td>部门名称</td>
						<td><input type="text" name="dept_name" class="easyui-validatebox" required="true"/></td>
					</tr>
					</table>
			</form>
		</div>
	</div>
	<!-- 修改窗口 -->
	<div class="easyui-window" title="对部门进行修改" id="editDeptWindow" collapsible="false" minimizable="false" maximizable="false" style="top:70px;left:350px">
		<div region="north" style="height:31px;overflow:hidden;" split="false" border="false" >
			<div class="datagrid-toolbar">
				<a id="edit" icon="icon-save" href="javascript:void(0)" class="easyui-linkbutton" plain="true" >保存</a>
			</div>
		</div>
		
		<div region="center" style="overflow:auto;padding:5px;" border="false">
			<form id="editDeptForm" action="${pageContext.request.contextPath }/deptAction_edit.action" method="post">
			<input name="dept_id" type="hidden">
				<table class="table-edit" width="80%" align="center">
					<tr>
						<td>部门名称</td>
						<td><input type="text" name="dept_name" class="easyui-validatebox" required="true"/></td>
					</tr>
					</table>
			</form>
		</div>
	</div>
</body>
</html>	