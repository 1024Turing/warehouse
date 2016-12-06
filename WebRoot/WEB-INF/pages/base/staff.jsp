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
	

	function doAdd(){
		$('#addStaffWindow').window("open");
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
						var id = rows[i].stf_id;
						array.push(id);
					}
					ids=array.join(",");
					location.href = "${pageContext.request.contextPath}/staffAction_delete.action?ids="+ids;
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
					$("#editStaffWindow").window("open");
					$("#editStaffWindow").form("load",rows[0]);
				}
			})
		}
	}
	//工具栏
	var toolbar =
		
		
		 [ {
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
		field : 'stf_id',
		checkbox : true,
	},{
		field : 'stf_name',
		title : '姓名',
		width : 120,
		align : 'center'
	},{
		field : 'stf_gender',
		title : '性别',
		width : 120,
		align : 'center',
		formatter : function(data,row, index){
			if(data=="1"){
				return "男";
			}else{
				return "女";
			}
		}
	},{
		field : 'stf_birth',
		title : '生日',
		width : 120,
		align : 'center'
	},{
		field : 'stf_phone',
		title : '手机号码',
		width : 120,
		align : 'center'
	},{
		field : 'id_card',
		title : '身份证号',
		width : 180,
		align : 'center'
	},{
		field : 'stf_email',
		title : '邮箱',
		width : 120,
		align : 'center'
	},{
		field : 'dept',
		title : '所属部门',
		width : 120,
		align : 'center'
	},{
		field : 'position',
		title : '职位',
		width : 120,
		align : 'center'
	},{
		field : 'pst',
		title : '状态',
		width : 120,
		align : 'center'
	}
	] ];
	
	$(function(){
		
		//扩展校验规则,对手机号进行校验
		var reg=/^1[3|4|5|7|8|][0-9]{9}$/;
		$.extend($.fn.validatebox.defaults.rules,{
			telephone:{
				validator:function(value,param){
					return reg.test(value);
				},
				message: "手机号格式不正确"
			}
		});
		//扩展校验规则,对身份证号进行校验
		var reg2=/^[1|2|3|4|5|7|6|8|9|][0-9]{16}[0-9|X|]$/;
		$.extend($.fn.validatebox.defaults.rules,{
			id_card:{
				validator:function(value,param){
					return reg2.test(value);
				},
				message: "身份证格式不正确"
			}
		});
		//加载部门
		$.post("${pageContext.request.contextPath}/deptAction_findAll", function(data){
			$(data).each(function(i,n){
				$("#sdept").append("<option value='"+n.dept_name+"'>"+n.dept_name+"</option>");
				$("#edept").append("<option value='"+n.dept_name+"'>"+n.dept_name+"</option>");
				$("#dept").append("<option value='"+n.dept_name+"'>"+n.dept_name+"</option>");
				$("#dept[value='${deptCriteria}']").prop("selected","selected");
			});
			
		},"json");
		//加载职位
		$.post("${pageContext.request.contextPath}/positionAction_findAllUse", function(data){
			$(data).each(function(i,n){
				$("#sposition").append("<option value='"+n.pos_name+"'>"+n.pos_name+"</option>");
				$("#eposition").append("<option value='"+n.pos_name+"'>"+n.pos_name+"</option>");
				$("#position").append("<option value='"+n.pos_name+"'   >"+n.pos_name+"</option>");
				
				$("#position[value='${posCriteria}']").prop("selected","selected");
			});
			
		},"json");
		//加载状态
		$.post("${pageContext.request.contextPath}/personstAction_findAll", function(data){
			$(data).each(function(i,n){
				$("#spst").append("<option value='"+n.pst_state+"'>"+n.pst_state+"</option>");
				$("#epst").append("<option value='"+n.pst_state+"'>"+n.pst_state+"</option>");
				$("#pst").append("<option value='"+n.pst_state+"'>"+n.pst_state+"</option>");
				$("#pst[value='${pstCriteria}']").prop("selected","selected");
			});
			
		},"json");
		
		
		//保存验证
		$("#save").click(function(){
			//进行表单校验
			var v = $("#addStaffForm").form("validate");
			if(v){
				//校验通过，提交表单
				$("#addStaffForm").submit();
			}
		});
		//修改验证
		$("#edit").click(function(){
			//进行表单校验
			var v = $("#editStaffForm").form("validate");
			if(v){
				//校验通过，提交表单
				$("#editStaffForm").submit();
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
			pageList: [2,5],
			pagination : true,
			toolbar : '#tb',
			url : "${pageContext.request.contextPath}/staffAction_pageQuery.action",
			idField : 'stf_id',
			columns : columns,
			onDblClickRow : doDblClickRow
		});
		
		// 添加取派员窗口
		$('#addStaffWindow').window({
	        title: '添加员工',
	        width: 400,
	        modal: true,
	        shadow: true,
	        closed: true,
	        height: 430,
	        resizable:false
	    });
		// 添加取派员窗口
		$('#editStaffWindow').window({
	        title: '修改员工',
	        width: 400,
	        modal: true,
	        shadow: true,
	        closed: true,
	        height: 430,
	        resizable:false
	    });
		
	});

	function doDblClickRow(rowIndex, rowData){
		$("#editStaffWindow").window("open");
		
		$("#editStaffWindow").form("load",rowData);
	}
	function doSearch(){
		$('#grid').datagrid('load',{
			deptCriteria: $('#dept').val(),
			posCriteria: $('#position').val(),
			pstCriteria:$('#pst').val()
		});
	}
</script>	
</head>

<body class="easyui-layout" style="visibility:hidden;">
	<div id="tb" style="padding:3px">
		<a id="button-add" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="doAdd()" plain="true">增加</a>
		<a id="button-delete" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doDelete()" plain="true">删除</a>
		<a id="button-edit" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="doEdit()" plain="true">修改</a>
		<span style="margin-left:20px">部门:</span>
			<select id="dept"  >
				<option value="">请选择</option>
			</select>
		<span style="margin-left:20px">职位 :</span>
			<select id="position" >
				<option value="">请选择</option>
			</select>
		<span style="margin-left:20px">状态:</span>
			<select id="pst" >
				<option value="">请选择</option>
			</select>
		<a href="javascript:void(0)" class="easyui-linkbutton" plain="true" onclick="doSearch()" style="margin-left:20px">查询</a>
	</div>
	<div region="center" border="false">
    	<table id="grid"></table>
	</div>
	<!-- 添加窗口 -->
	<div class="easyui-window" title="对部门进行添加" id="addStaffWindow" collapsible="false" minimizable="false" maximizable="false" style="top:20px;left:340px">
		<div region="north" style="height:50px;overflow:hidden;" split="false" border="false" >
			<div class="datagrid-toolbar">
				<a id="save" icon="icon-save" href="javascript:void(0)" class="easyui-linkbutton" plain="true" >保存</a>
			</div>
		</div>
		
		<div region="center" style="overflow:auto;padding:5px;" border="false">
			<form id="addStaffForm" action="${pageContext.request.contextPath }/staffAction_add.action" method="post">
				<table class="table-edit" width="80%" align="center">		
					<tr class="title">
						<td colspan="2">员工信息</td>
					</tr>
					<!-- TODO 这里完善收派员添加 table -->
					
					<tr>
						<td>姓名</td>
						<td><input type="text" name="stf_name" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>性别</td>
						<td><select name="stf_gender">
								<option value="1" >男</option>
								<option value="0" >女</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>生日</td>
						<td>
							<input type="text" name="stf_birth" onclick="J.calendar.get({dir:'right'});"  readonly="readonly" class="easyui-validatebox" required="true"/>
						</td>
					</tr>
					<tr>
						<td>手机号码</td>
						<td><input type="text" name="stf_phone" class="easyui-validatebox" required="true" data-options="validType:'telephone'" /></td>
					</tr>
					<tr>
						<td>邮箱</td>
						<td><input type="text" name="stf_email" class="easyui-validatebox" required="true" data-options="validType:'email'" /></td>
					</tr>
					<tr>
						<td>身份证号</td>
						<td><input type="text" name="id_card" class="easyui-validatebox" required="true" data-options="validType:'id_card'" /></td>
					</tr>
					<tr>
						<td>所属部门</td>
						<td>
							<select name="dept" id="sdept">
								<option value="">请选择</option>
							</select>
						
						</td>
					</tr>
					<tr>
						<td>职位</td>
						<td>
							<select name="position" id="sposition">
								<option value="">请选择</option>
							</select>
						</td>
					</tr>
					
					<tr>
						<td>状态</td>
						<td>
							<select name="pst" id="spst">
								<option value="">请选择</option>
							</select>
						</td>
					</tr>
					</table>
			</form>
		</div>
	</div>
	<!-- 修改窗口 -->
	<div class="easyui-window" title="对部门进行修改" id="editStaffWindow" collapsible="false" minimizable="false" maximizable="false" style="top:20px;left:340px">
		<div region="north" style="height:31px;overflow:hidden;" split="false" border="false" >
			<div class="datagrid-toolbar">
				<a id="edit" icon="icon-save" href="javascript:void(0)" class="easyui-linkbutton" plain="true" >保存</a>
			</div>
		</div>
		
		<div region="center" style="overflow:auto;padding:5px;" border="false">
			<form id="editStaffForm" action="${pageContext.request.contextPath }/staffAction_edit.action" method="post">
			<input name="stf_id" type="hidden">
				<table class="table-edit" width="80%" align="center">		
					<tr class="title">
						<td colspan="2">员工信息</td>
					</tr>
					<!-- TODO 这里完善收派员添加 table -->
					
					<tr>
						<td>姓名</td>
						<td><input type="text" name="stf_name" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>性别</td>
						<td><select name="stf_gender">
								<option value="1">男</option>
								<option value="0">女</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>生日</td>
						<td>
							<input type="text" name="stf_birth" onclick="J.calendar.get({dir:'right'});"  readonly="readonly" class="easyui-validatebox" required="true"/>
						</td>
					</tr>
					<tr>
						<td>手机号码</td>
						<td><input type="text" name="stf_phone" class="easyui-validatebox" required="true" data-options="validType:'telephone'" /></td>
					</tr>
					<tr>
						<td>邮箱</td>
						<td><input type="text" name="stf_email" class="easyui-validatebox" required="true" data-options="validType:'email'" /></td>
					</tr>
					<tr>
						<td>身份证号</td>
						<td><input type="text" name="id_card" class="easyui-validatebox" required="true" data-options="validType:'id_card'" /></td>
					</tr>
					<tr>
						<td>所属部门</td>
						<td>
							<select name="dept" id="edept">
								<option value="">请选择</option>
							</select>
						
						</td>
					</tr>
					<tr>
						<td>职位</td>
						<td>
							<select name="position" id="eposition">
								<option value="">请选择</option>
							</select>
						</td>
					</tr>
					
					<tr>
						<td>状态</td>
						<td>
							<select name="pst" id="epst">
								<option value="">请选择</option>
							</select>
						</td>
					</tr>
					</table>
			</form>
		</div>
	</div>
</body>
</html>	