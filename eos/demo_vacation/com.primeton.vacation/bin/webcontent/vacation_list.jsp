<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2015-09-01 15:22:11
  - Description:
-->
<head>
<title>请假单列表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <script src="<%= request.getContextPath() %>/vacation/js/renders.js" type="text/javascript"></script>
    <%@include file="/common/idata/iDataCommon.jsp" %>
</head>
<body style="width:100%;height:100%;">
	<div style="width:95%;height:100%;margin: 0px auto;">
		    <div style="width:100%;">
		    	<div id="formSearch">
			        <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
			            <table style="width:100%;">
			                <tr>
			                    <td style="width:100%;">
			                        <a name="add" class="nui-button" iconCls="icon-add" onclick="add()">增加</a>
			                        <a name="edit" class="nui-button" iconCls="icon-edit" onclick="edit()">编辑</a>
			                        <a name="delete" class="nui-button" iconCls="icon-remove" onclick="remove()">删除</a>
			                        <a name="view" class="nui-button" iconCls="icon-expand" onclick="view()">查看</a>
			                        <a name="ask4Approval" class="nui-button" iconCls="icon-goto" onclick="submit()">提交审批</a>     
			                        <a name="approval" class="nui-button" iconCls="icon-user" onclick="approve()">审批</a>   
			                        <a name="view" class="nui-button" iconCls="icon-zoomin" onclick="treeView()">查看树形结构图</a>     
			                    </td>
			                    <td style="white-space:nowrap;">
			                    	<input class="nui-hidden" name="criteria._entity" value="com.primeton.vacation.vacation.TVacation"/>
			                    	<input class="nui-hidden" name="criteria._expr[0]._op" value="like"/>
			                    	<input class="nui-hidden" name="criteria._expr[0]._likerule" value="all">
			                    	<input class="nui-hidden" name="criteria._expr[0]._property" value="applicant">
			                        <input name="criteria._expr[0]._value" class="nui-textbox" emptyText="请输入申请人" style="width:150px;"/>   
			                        <a class="nui-button" iconCls="icon-search"onclick="search()">查询</a>
			                        <a class="nui-button" iconCls="icon-remove" onclick="clear()">清除</a>
			                    </td>
			                </tr>
			            </table>           
			        </div>
		        </div>
		    </div>
	
		    <div id="datagrid1" class="nui-datagrid" style="width:100%;height:35%;" allowResize="true" allowSortColumn="true"
		        url="com.primeton.vacation.vacation.queryVacation.biz.ext"  dataField="vacations" multiSelect="true" 
		        onselectionchanged="onSelectChanged" sortField="createtime" sortOrder="desc" pageSize="5">
		        <div property="columns">
		            <div type="checkcolumn" ></div>
		            <div field="state" width="30" headerAlign="center" align="center" allowSort="true" renderer="onStateRender">状态</div>           
		            <div field="applicant" width="40" headerAlign="center" align="center" allowSort="true">申请人</div>    
		            <div field="type" width="30" headerAlign="center" align="center" allowSort="true" renderer="onTypeRender">类型</div>       
		            <div field="starttime" width="120" dateFormat="yyyy-MM-dd HH:mm:ss" align="center" headerAlign="center" allowSort="true">开始时间</div>
		            <div field="endtime" width="120" dateFormat="yyyy-MM-dd HH:mm:ss" align="center" headerAlign="center" allowSort="true">结束时间</div>
		            <div field="createtime" width="120" dateFormat="yyyy-MM-dd HH:mm:ss" align="center" headerAlign="center" allowSort="true">申请时间</div>
		            <div field="remark" width="120" headerAlign="center" allowSort="true">备注</div>    
		        </div>
		    </div>
		    
	    <div id="report" class="nui-panel" style="width:100%;height:65%;" maskOnLoad="false"
	    	showCollapseButton="false" bodyStyle="padding:0;" expanded="true" showHeader="false" style="border:none;">
		</div>
	</div>

	<script type="text/javascript">
    	nui.parse();
    	
    	var grid = nui.get("datagrid1");
    	var searchForm = new nui.Form("#formSearch");
    	
    	var viewParams = [{name: "showtoolbar" , value:false}, 
    		{name: "refresh", value: true},];
    	var reportUrl = iDataUtil.getResourceUrl("I402881f013838944014f9398568500fc", viewParams);
    	
    	$(function() {
    		search();
    		nui.get("report").setUrl(reportUrl);
    	});
    	
 		function add() {
            nui.open({
                url: "<%=request.getContextPath() %>/vacation/vacation_add.jsp",
                title: "新增请假单", width: 500, height: 250,
                onload: function () {
                    var iframe = this.getIFrameEl();
                    var data = { action: "new"};
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function (action) {
                    search();
                }
            });
        }
        
        function edit() {
        	var row = grid.getSelected();
        	
        	if(!row) return;
        
			nui.open({
                url: "<%=request.getContextPath() %>/vacation/vacation_add.jsp",
                title: "编辑请假单", width: 500, height: 250,
                onload: function () {
                    var iframe = this.getIFrameEl();
                    iframe.contentWindow.SetData({vacation: row});
                },
                ondestroy: function (action) {
                    search();
                }
            });
        }
        
 		function view() {
			var row = grid.getSelected();
            
            if(!row){
    	   		nui.alert("请选中一条记录","系统提示", function(action){});
    	   		return;
        	}
		
			nui.open({
                url: "<%=request.getContextPath() %>/vacation/vacation_view.jsp",
                title: "查看请假单", width: 500, height: 200, showModal: false,
                onload: function () {
                    var iframe = this.getIFrameEl();
                    var data = { vacation: row};
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function (action) {
                }
            });
		}
		
		function treeView() {
			nui.open({
                url: "<%=request.getContextPath() %>/vacation/vacation_treeview.jsp",
                title: "查看请假单", width: 250, height: 350, showModal: false,
                onload: function () {
                    var iframe = this.getIFrameEl();
                    var data = { vacation: row};
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function (action) {
                }
            });
		}
		
		function approve() {
			var row = grid.getSelected();
            
            if(!row){
    	   		nui.alert("请选中要审批的请假单","系统提示", function(action){});
    	   		return;
        	}
		
			nui.open({
                url: "<%=request.getContextPath() %>/vacation/vacation_approval.jsp",
                title: "审批请假单", width: 500, height: 320, showModal: true,
                onload: function () {
                    var iframe = this.getIFrameEl();
                    var data = { vacation: row};
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function (action) {
                	if(action != "cancel") {
	                	search();
	                	nui.alert("审批成功!");
                	}
                }
            });
		}
        
        function submit() {
			var row = grid.getSelected();
            
            if(!row) return;
		
			var json = nui.encode({vacation: row});
        	nui.confirm("确定提交请假单？", "确定？",
	            function (action) {            
	                if (action == "ok") {
	                    nui.ajax({
			                url: "com.primeton.vacation.vacation.askForApproval.biz.ext",
			                data: json,
			                type: 'POST',
			                cache: false,
			                contentType: 'text/json',
			                success: function (text) {
			                	search();
			                	nui.alert("操作成功!");
			                },
			                error: function (jqXHR, textStatus, errorThrown) {
			                    alert(jqXHR.responseText);
			                }
			            });
	                } 
	            }
        	);
        }
        
        function remove() {
        	var rows = grid.getSelecteds();
        	
        	if(!rows) return;
        	
        	var json = {vacations: rows};
        	nui.confirm("确定删除记录？", "确定？",
	            function (action) {            
	                if (action == "ok") {
	                    nui.ajax({
			                url: "com.primeton.vacation.vacation.deleteVacations.biz.ext",
			                data: json,
			                type: 'POST',
			                cache: false,
			                contentType: 'text/json',
			                success: function (text) {
			                	search();
			                	nui.alert("操作成功!");
			                },
			                error: function (jqXHR, textStatus, errorThrown) {
			                    alert(jqXHR.responseText);
			                }
			            });
	                } 
	            }
        	);
        }
        
        function onStateRender(e) {
			for (var i = 0, l = vacationStates.length; i < l; i++) {
                var g = vacationStates[i];
                if (g.id == e.value) return g.text;
            }
            return "";
        }
        
        function onTypeRender(e) {
        	for (var i = 0, l = vacationTypes.length; i < l; i++) {
                var g = vacationTypes[i];
                if (g.id == e.value) return g.text;
            }
            return "";
        }
    	
    	function search() {
            var data = searchForm.getData();
            grid.load(data);
            reloadReport();
        }
        
        function clear() {
        	searchForm.clear();
        	search();
        }
        
        function reloadReport() {
    		nui.get("report").load(reportUrl);
        }
        
        function onSelectChanged() {
        	var row = grid.getSelected();
        	
        	if(!row) {
        		setButtonsEnable(1, 1, 1, 1, 1, 1);
        		return;
        	}
        	
        	switch(row.state) {
        		case 0: setButtonsEnable(1, 1, 1, 1, 1, 0);break;
        		case 1: setButtonsEnable(1, 0, 0, 1, 0, 1);break;
        		case 2: 
        		case 3: setButtonsEnable(1, 0, 0, 1, 0, 0);break;
        	}
        }
        
        function setButtonsEnable(add, edit, del, view, ask4Approval, approval) {
        	var buttons = {
        		"btnAdd": nui.getbyName("add"),
        		"btnEdit": nui.getbyName("edit"),
        		"btnDelete": nui.getbyName("delete"),
        		"btnView": nui.getbyName("view"),
        		"btnAsk4Approval": nui.getbyName("ask4Approval"),
        		"btnApprove": nui.getbyName("approval")
        	};
        	if(add) buttons.btnAdd.enable(); else buttons.btnAdd.disable();
        	if(edit) buttons.btnEdit.enable(); else buttons.btnEdit.disable();
        	if(del) buttons.btnDelete.enable(); else buttons.btnDelete.disable();
        	if(view) buttons.btnView.enable(); else buttons.btnView.disable();
        	if(ask4Approval) buttons.btnAsk4Approval.enable(); else buttons.btnAsk4Approval.disable();
        	if(approval) buttons.btnApprove.enable(); else buttons.btnApprove.disable();
        }
    </script>
</body>
</html>