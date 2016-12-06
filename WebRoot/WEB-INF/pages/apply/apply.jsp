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
	function goBack()
	{
	  window.history.back();
	}
	function doSave(){
		var v = $("#applyForm").form("validate");
		if(v){
			//校验通过，提交表单
			$("#applyForm").submit();
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
 
  <style type="text/css">
 	table
  {
  border-collapse:collapse;
  }
 </style> 	 	
  </head>
  
<body class="easyui-layout" style="visibility:hidden;">

	<form id="applyForm" action="${pageContext.request.contextPath}/applyAction_save.action" method="post">
	    <div title="申请单填写" data-options="region:'north'" style="height:140px ;background-color:;">
	    	<div style="margin-left:20px;margin-top:6px">
	    		
	    		<span>申请人 :</span><input type="text" name="ao_name" value="${user.staff.stf_name }" ><br>
	    		<span>说     明 :</span><textarea style="resize: none;width:250px;height:38px" name="ao_details"></textarea><br>	    		
	    		<div style="margin-top:5px;">
		    	<a id="button-save" onclick="doSave()" style="margin-left:30px;" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
		    	<a id="button-add" onclick="doAdd()" style="margin-left:50px;" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加</a>
		    	<a id="button-back" onclick="goBack()" style="margin-left:50px;" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back'">返回</a>
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
					<td><input type="text" name= "goods_name" class="easyui-validatebox" required="true" ></td>
					<td><input type="text" name= "standard" class="easyui-validatebox" required="true" ></td>
					<td><input type="text" name= "type" class="easyui-validatebox" required="true" ></td>
					<td><input type="text" name= "unit" class="easyui-validatebox" required="true" ></td>
					<td><input type="text" name= "goods_count" class="easyui-validatebox" required="true" data-options="validType:'goods_count'" /></td>
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
						<td><input type="text" name= "goods_name" class="easyui-validatebox" required="true" ></td>
					<td><input type="text" name= "standard" class="easyui-validatebox" required="true" ></td>
					<td><input type="text" name= "type" class="easyui-validatebox" required="true" ></td>
					<td><input type="text" name= "unit" class="easyui-validatebox" required="true" ></td>
					<td><input type="text" name= "goods_count" class="easyui-validatebox" required="true" data-options="validType:'goods_count'" /></td>
					<td>
						<a id="" onclick="doDelete(this)" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">删除</a>
						
					</td>
				</tr>		
  </body>
</html>
