<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

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
		
		$.post("${pageContext.request.contextPath}/gcodAction_findByPid",{"pId":"0"}, function(data){
			$(data).each(function(i,n){
				$(".firstcode").append("<option value='"+n.id+"'>"+n.name+"</option>");
			});
		},"json");
		
		
	});
	function doDelete(obj){
		var allTr=$("#tab tr");
		if(allTr.length>2){
			$(obj).parent().parent().remove();
		}	
	}
	function doAdd(){
		$("#clone-tab tr").eq(1).clone(true).appendTo("#tab");
	}
	function doSave(){
		var v = $("#initForm").form("validate");
		if(v){
			//校验通过，提交表单
			$("#initForm").submit();
		}
	}
	function doChange(obj){
		var pId=$(obj).val();
		var secondcode =$(obj).parent().next().children("select");
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
	<form id="initForm" action="${pageContext.request.contextPath}/inputAction_init.action" method="post">
	    <div title="初始化填写" data-options="region:'north'" style="height:138px ;background-color:;">
	    	<div style="margin-left:20px;margin-top:6px">
	    		<span>操作人 :</span><input type="text" name="in_name" value="${staff.stf_name }" ><br>
	    		<span>说     明 :</span><textarea style="resize: none;width:250px;height:38px" name="in_details"></textarea><br>	    		
	    		<div style="margin-top:10px;">
		    	<a id="button-save" onclick="doSave()" style="margin-left:30px;" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
		    	<a id="button-add" onclick="doAdd()" style="margin-left:50px;" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加</a>
		    	</div>
	    	</div>
		</div>
		<div title="物品栏" style="" data-options="region:'center'">
			<table border="" id="tab">
				<tr>
					<th colspan="2">分类</th>
					<th>名称</th>
					<th>规格</th>
					<th>型号</th>
					<th>计量单位</th>
					<th>数量</th>
					<th>删除</th>
					
				</tr>
				<tr >
					<td>
						<select name= "firstcode" onChange="doChange(this)" class="firstcode easyui-validatebox" required="true">
							<option value="">请选择</option>
						</select>
					</td>
					<td>
						<select name= "secondcode" class="easyui-validatebox" required="true">
							<option value="">请选择</option>
						</select>
					</td>
					<td><input type="text" name= "goods_name"></td>
					<td><input type="text" name= "standard"></td>
					<td><input type="text" name= "type"></td>
					<td><input type="text" name= "unit"></td>
					<td><input type="text" name= "goods_count"></td>
					<td>
						<a id="" onclick="doDelete(this)" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">删除</a>
						
					</td>
				</tr>
			</table>	
		</div>
	</form>	
	
	
	<table border="" id="clone-tab" style="display:none;">
			<tr>
					<th colspan="2">分类</th>
					<th>名称</th>
					<th>规格</th>
					<th>型号</th>
					<th>计量单位</th>
					<th>数量</th>
					<th>删除</th>
					
				</tr>
				<tr >
					<td>
						<select name= "firstcode" onChange="doChange(this)" class="firstcode easyui-validatebox" required="true">
							<option value="">请选择</option>
						</select>
					</td>
					<td>
						<select name= "secondcode" class="secondcode easyui-validatebox" required="true">
							<option value="">请选择</option>
						</select>
					</td>
					<td><input type="text" name= "goods_name"></td>
					<td><input type="text" name= "standard"></td>
					<td><input type="text" name= "type"></td>
					<td><input type="text" name= "unit"></td>
					<td><input type="text" name= "goods_count"></td>
					<td>
						<a id="" onclick="doDelete(this)" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">删除</a>
						
					</td>
				</tr>		
  </body>
</html>
