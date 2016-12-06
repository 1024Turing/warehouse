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
		$('#addItemWindow').window("open");
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
						var id = rows[i].item_id;
						array.push(id);
					}
					ids=array.join(",");
					location.href = "${pageContext.request.contextPath}/itemAction_delete.action?ids="+ids;
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
					loadCode(rows[0]);
				}
			})
		}
	}

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
		
		$.post("${pageContext.request.contextPath}/gcodAction_findByPid",{"pId":"0"}, function(data){
			$(data).each(function(i,n){
				$(".firstcode").append("<option value='"+n.id+"'>"+n.name+"</option>");
			});
		},"json");
	
		
		
		
		//保存验证
		$("#save").click(function(){
			//进行表单校验
			var v = $("#addItemForm").form("validate");
			if(v){
				//校验通过，提交表单
				$("#addItemForm").submit();
			}
		});
		//修改验证
		$("#edit").click(function(){
			//进行表单校验
			var v = $("#editItemForm").form("validate");
			if(v){
				//校验通过，提交表单
				$("#editItemForm").submit();
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
			pageList: [5,10],
			pagination : true,
			toolbar : '#tb',
			url : "${pageContext.request.contextPath}/itemAction_pageQuery.action",
			idField : 'item_id',
			columns : columns,
			onDblClickRow : doDblClickRow
		});
		
		$('#addItemWindow').window({
	        title: '添加员工',
	        width: 400,
	        modal: true,
	        shadow: true,
	        closed: true,
	        height: 400,
	        resizable:false
	    });

		$('#editItemWindow').window({
	        title: '修改员工',
	        width: 400,
	        modal: true,
	        shadow: true,
	        closed: true,
	        height: 400,
	        resizable:false
	    });
		
	});

	function doDblClickRow(rowIndex, rowData){
		loadCode(rowData);
	}
	function loadCode(rowData){
		var firstcode=rowData.secondcode.substring(0,2);
		var secondcode=rowData.secondcode.substring(0,4);
		$("#efc").val(firstcode);
		$.post("${pageContext.request.contextPath}/gcodAction_findByPid",{"pId":firstcode}, function(data){
			$(data).each(function(i,n){
				$("#esc").append("<option value='"+n.id+"'>"+n.name+"</option>");
			});
			$("#esc").val(secondcode);
		},"json");
		
		
		$("#editItemWindow").window("open");
		
		$("#editItemWindow").form("load",rowData);
	}
	function doChange(obj){
		var pId=$(obj).val();
		var secondcode =$(obj).parent().parent().next().find("select");
		$(secondcode).empty();
		$(secondcode).append("<option >请选择</option>");
		$.post("${pageContext.request.contextPath}/gcodAction_findByPid",{"pId":pId}, function(data){
			$(data).each(function(i,n){
				$(secondcode).append("<option value='"+n.id+"'>"+n.name+"</option>");
			});
		},"json");
	}
</script>	
</head>

<body class="easyui-layout" style="visibility:hidden;">
	<div id="tb" style="padding:3px">
		<a id="button-add" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="doAdd()" plain="true">增加</a>
		<a id="button-delete" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doDelete()" plain="true">删除</a>
		<a id="button-edit" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="doEdit()" plain="true">修改</a>
	</div>
	<div region="center" border="false">
    	<table id="grid"></table>
	</div>
	<!-- 添加窗口 -->
	<div class="easyui-window" title="添加" id="addItemWindow" collapsible="false" minimizable="false" maximizable="false" style="top:30px;left:340px">
		<div region="north" style="height:50px;overflow:hidden;" split="false" border="false" >
			<div class="datagrid-toolbar">
				<a id="save" icon="icon-save" href="javascript:void(0)" class="easyui-linkbutton" plain="true" >保存</a>
			</div>
		</div>
		
		<div region="center" style="overflow:auto;padding:5px;" border="false">
			<form id="addItemForm" action="${pageContext.request.contextPath }/itemAction_add.action" method="post">
				<table class="table-edit" width="80%" align="center">		
					<tr class="title">
						<td colspan="2">物品信息</td>
					</tr>
					<!-- TODO 这里完善收派员添加 table -->
					<tr>
						<td>一级分类</td>
						<td>
							<select name= "firstcode"  onChange="doChange(this)" class="firstcode easyui-validatebox" required="true">
								<option value="">请选择</option>
							</select>
						
						</td>
					</tr>
					<tr>
						<td>二级分类</td>
						<td>
							<select name= "secondcode"  class="secondcode easyui-validatebox" required="true">
								<option value="">请选择</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>名称</td>
						<td><input type="text" name="goods_name" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>规格</td>
						<td><input type="text" name="standard" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>类型</td>
						<td><input type="text" name="type" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>计量单位</td>
						<td><input type="text" name="unit" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>数量</td>
						<td><input type="text" name="goods_count" class="easyui-validatebox" required="true" data-options="validType:'goods_count'" /></td>
					</tr>
					</table>
			</form>
		</div>
	</div>
	<!-- 修改窗口 -->
	<div class="easyui-window" title="修改" id="editItemWindow" collapsible="false" minimizable="false" maximizable="false" style="top:30px;left:340px">
		<div region="north" style="height:31px;overflow:hidden;" split="false" border="false" >
			<div class="datagrid-toolbar">
				<a id="edit" icon="icon-save" href="javascript:void(0)" class="easyui-linkbutton" plain="true" >保存</a>
			</div>
		</div>
		
		<div region="center" style="overflow:auto;padding:5px;" border="false">
			<form id="editItemForm" action="${pageContext.request.contextPath }/itemAction_edit.action" method="post">
			<input name="item_id" type="hidden">
				<table class="table-edit" width="80%" align="center">		
					<tr class="title">
						<td colspan="2">员工信息</td>
					</tr>
					<!-- TODO 这里完善收派员添加 table -->
					
					<tr>
						<td>一级分类</td>
						<td>
							<select name= "firstcode" id="efc" onChange="doChange(this)" class="firstcode easyui-validatebox" required="true">
								<option value="">请选择</option>
							</select>
						
						</td>
					</tr>
					<tr>
						<td>二级分类</td>
						<td>
							<select name= "secondcode" id="esc" class="secondcode easyui-validatebox" required="true">
								<option value="">请选择</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>名称</td>
						<td><input type="text" name="goods_name" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>规格</td>
						<td><input type="text" name="standard" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>类型</td>
						<td><input type="text" name="type" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>计量单位</td>
						<td><input type="text" name="unit" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>数量</td>
						<td><input type="text" name="goods_count" class="easyui-validatebox" required="true" data-options="validType:'goods_count'" /></td>
					</tr>
					</table>
			</form>
		</div>
	</div>
</body>
</html>	