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

	
	function doEdit(){
		var rows=$("#grid").datagrid("getSelections");
		if(rows.length==0){
			$.messager.alert("提示信息","请选择需要修改的用户！","info");
			
		}else if(rows.length>1){
			$.messager.alert("提示信息","一次只允许修改单行数据","info");
		}else{
			$.messager.confirm("提示信息","你确定修改当前选中的部门吗？",function(r){
				if(r){
					$("#editUserWindow").window("open");
					$("#editUserWindow").form("load",rows[0]);
				}
			})
		}
	}
	//工具栏
	var toolbar = [ {
		id : 'button-edit',
		text : '修改',
		iconCls : 'icon-edit',
		handler : doEdit
	}];
	// 定义列
	var columns = [ [ {
		field : 'user_id',
		checkbox : true,
	}, {
		field : 'staff',
		title : '用户名',
		width : 200,
		align : 'center',
		formatter: function(value,row,index){
		if (row.staff){
			return row.staff.stf_name;
		} else {
			return value;
		}
		}


	}, {
		field : 'user_code',
		title : '用户账号',
		width : 200,
		align : 'center'
	}] ];
	
	$(function(){
		

		//修改验证
		$("#edit").click(function(){
			//进行表单校验
			var v = $("#editUserForm").form("validate");
			if(v){
				//校验通过，提交表单
				$("#editUserForm").submit();
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
			url : "${pageContext.request.contextPath}/userAction_pageQuery.action",
			
			idField : 'user_id',
			columns : columns,
			onDblClickRow : doDblClickRow
		});
		
		
		// 添加取派员窗口
		$('#editUserWindow').window({
	        title: '选择单位',
	        width: 400,
	        modal: true,
	        shadow: true,
	        closed: true,
	        height: 200,
	        resizable:false
	    });
		
	});
	
	function doDblClickRow(rowIndex, rowData){
		$("#editUserWindow").window("open");
		var staff=rowData.staff;
		var stf_name=staff.stf_name;
		$("#stf_name").val(stf_name);
		
		var roleList=rowData.roleList;
		var checkboxs=$("#roleTD :checkbox");
		for(var i=0;i<checkboxs.length;i++){
			$(checkboxs[i]).prop("checked",false);
			for(var j=0;j<roleList.length;j++){
				//$(checkboxs[j]).prop("checked",false);
				if(roleList[j].role_id==$(checkboxs[i]).val()){
					$(checkboxs[i]).prop("checked",true);
				}
			}  
		}
		$("#editUserForm").form("load",rowData);
	}
	
</script>	
</head>
<body class="easyui-layout" style="visibility:hidden;">
	  
	
	<div region="center" border="false">
    	<table id="grid"></table>
	</div>
	
	<!-- 修改窗口 -->
	<div class="easyui-window" title="对部门进行修改" id="editUserWindow" collapsible="false" minimizable="false" maximizable="false" style="top:70px;left:350px">
		<div region="north" style="height:31px;overflow:hidden;" split="false" border="false" >
			<div class="datagrid-toolbar">
				<a id="edit" icon="icon-save" href="javascript:void(0)" class="easyui-linkbutton" plain="true" >保存</a>
			</div>
		</div>
		
	 <div region="center" style="overflow:auto;padding:5px;" border="false">
			<form id="editUserForm" action="${pageContext.request.contextPath }/userAction_edit.action" method="post">
			<input name="user_id" type="hidden">
				<table class="table-edit" width="80%" align="center">
					<tr>
						<td>用户名</td>
						<td><input type="text" id="stf_name" readonly="readonly" /></td>
					</tr>
					<tr>
		           		<td>选择角色:</td>
		           		<td colspan="3" id="roleTD">
		           			<script type="text/javascript">
		           				$(function(){
		           					//页面加载完成后，发送ajax请求
		           					$.post('${pageContext.request.contextPath}/roleAction_listajax.action',{},
		           							function(data){
		           								for(var i =0;i<data.length;i++){
		           									var id = data[i].role_id;
		           									var name = data[i].role_name;
		           									$("#roleTD").append('<input id="'+id+'" name="roleIds" type="checkbox" value="'+id+'"><label for="'+id+'">'+name+'</label>');
		           								}
		           							}
		           					);
		           				});
		           			</script>
		           		</td>
	           		</tr>
				</table>
			</form>
		</div>
	</div> 
</body>
</html>	