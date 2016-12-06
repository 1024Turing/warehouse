<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>物品分类</title>
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
<!-- 导入ztree类库 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/js/ztree/zTreeStyle.css"
	type="text/css" />
<script
	src="${pageContext.request.contextPath }/js/ztree/jquery.ztree.all-3.5.js"
	type="text/javascript"></script>
<script
	src="${pageContext.request.contextPath }/js/easyui2/locale/easyui-lang-zh_CN.js"
	type="text/javascript"></script>
  <script type="text/javascript">
	$(function(){
		// 先将body隐藏，再显示，不会出现页面刷新效果
		$("body").css({visibility:"visible"});
		
		var url = "${pageContext.request.contextPath}/gcodAction_queryTree.action";
		$.post(url,{},function(data){
			//1、定义一个ztree设置的属性,启用简单格式的json数据描述节点数据
			var setting3 = {
					data: {
						simpleData: {
							enable: true//启用简单格式的json数据描述节点数据
						}
					},
					callback: {
						//为ztree节点绑定单击事件
						onClick: function(event, treeId, treeNode){		
							$("#tId").val(treeNode.id);
							$("#pId").val(treeNode.id);
						}
					}
			};
			//3、调用ztree的API动态创建一个ztree
			$.fn.zTree.init($("#treeMenu"), setting3, data);
		});
		$('#addGcodWindow').window({
	        title: '添加分类',
	        width: 400,
	        modal: true,
	        shadow: true,
	        closed: true,
	        height: 200,
	        resizable:false
	    });
		$('#editGcodWindow').window({
	        title: '修改分类',
	        width: 400,
	        modal: true,
	        shadow: true,
	        closed: true,
	        height: 200,
	        resizable:false
	    });
		$("#add").click(function(){
			
			var pid=$("#pId").val();
			if(pid==null || pid.length==0){
				$.messager.alert("提示信息","请选择分类节点！","info");
			}else if(pid.length==4){
				$.messager.alert("提示信息","该分类节点无法添加","info");
			}else{
				$("#addGcodWindow").window("open");
			}
		});
		$("#button-edit").click(function(){
			var tid=$("#tId").val();
			if(tid==null || tid.length==0) {
				$.messager.alert("提示信息","请选择修改的节点！","info");
			}else{
				$("#editGcodWindow").window("open");
			}
		});
		$("#button-delete").click(function(){
			var tid=$("#tId").val();
			if(tid==null || tid.length==0){
				$.messager.alert("提示信息","请选择删除的节点！","info");
			}else{
				$.messager.confirm("提示信息","你确定修改当前选中的部门吗？",function(r){
					if(r){
						location.href = "${pageContext.request.contextPath}/gcodAction_delete.action?id="+tid;
					}
				})
			}
		});
		//保存验证
		$("#save").click(function(){
			//进行表单校验
			var v = $("#addGcodWindow").form("validate");
			if(v){
				//校验通过，提交表单
				
				$("#addGcodForm").submit();
				
			}
		});
		$("#edit").click(function(){
			//进行表单校验
			var v = $("#editGcodWindow").form("validate");
			if(v){
				//校验通过，提交表单
				$("#editGcodForm").submit();
			}
		});
		
	});
	

 </script> 	
<style type="text/css">
	.ztree *{
		font-size:16px;
	}
</style>

  </head>

  <body class="easyui-layout" style="visibility:hidden;">
  		<div data-options="region:'north'" style="height:40px ;background-color:grey;">
		</div>
		<div title="分类" style="width: 230px" data-options="region:'west'">	
			<ul id="treeMenu" class="ztree"></ul>			
		</div>
		<div data-options="region:'center'">
			<div class="easyui-layout" fit="true">
						<div region="north"  border="true" style="height:42px;">
							<div style="position:relative;top:7px">
							<a id="add" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" style="margin-left:10px">增加</a>
							<a id="button-delete" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" style="margin-left:10px">删除</a>
							<a id="button-edit" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" style="margin-left:10px">修改</a>
							</div>
						</div>
						<div region="center" border="true">
							<div class="easyui-window" title="添加窗口" id="addGcodWindow" collapsible="false" minimizable="false" maximizable="false" style="top:70px;left:350px">
								<div region="north" style="height:50px;overflow:hidden;" split="false" border="false" >
									<div class="datagrid-toolbar">
										<a id="save" icon="icon-save" href="javascript:void(0)" class="easyui-linkbutton" plain="true" >保存</a>
									</div>
								</div>
								
								<div region="center" style="overflow:auto;padding:5px;" border="false">
									<form id="addGcodForm" action="${pageContext.request.contextPath }/gcodAction_add.action" method="post">
										<input id="pId" type="hidden"  name="id" />
										<table class="table-edit" width="80%" align="center">		
											<tr>
												<td>分类名称</td>
												<td><input type="text" name="name" class="easyui-validatebox" required="true"/></td>
											</tr>
											</table>
									</form>
								</div>
							</div>
							
							<!-- 修改窗口 -->
							<div class="easyui-window" title=" 修改窗口" id="editGcodWindow" collapsible="false" minimizable="false" maximizable="false" style="top:70px;left:350px">
								<div region="north" style="height:50px;overflow:hidden;" split="false" border="false" >
									<div class="datagrid-toolbar">
										<a id="edit" icon="icon-save" href="javascript:void(0)" class="easyui-linkbutton" plain="true" >保存</a>
									</div>
								</div>
								
								<div region="center" style="overflow:auto;padding:5px;" border="false">
									<form id="editGcodForm" action="${pageContext.request.contextPath }/gcodAction_edit.action" method="post">
										<input id="tId" type="hidden"  name="id" />
										<table class="table-edit" width="80%" align="center">		
											<tr>
												<td>分类名称</td>
												<td><input type="text" name="name" class="easyui-validatebox" required="true"/></td>
											</tr>
											</table>
									</form>
								</div>
							</div>
						</div><!--  -->
					</div>
		</div>
	
		
    
  </body>
</html>
