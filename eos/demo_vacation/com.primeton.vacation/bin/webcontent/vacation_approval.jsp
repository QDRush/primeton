<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2015-09-01 16:45:42
  - Description:
-->
<head>
<title>请假单审批</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>
	<div id="tabsVacation" class="nui-tabs" style="width:100%;height:220px;" activeIndex="0" plain="true">
	  <div title="请假单信息" name="tabVacation" url="<%=request.getContextPath() %>/vacation/vacation_view.jsp" maskOnLoad="true"></div>
	  <div title="审批">
		审批意见:<br />
		<input name="comments" class="nui-textarea" style="width:100%; height: 120px;" required="true"/>
	  </div>
	</div>
	  	
  	<div style="text-align:center;padding:10px;height:30px;">               
        <a class="nui-button" onclick="approve(1)" style="width:60px;margin-right:20px;">通过</a>
        <a class="nui-button" onclick="approve(0)" style="width:60px;margin-right:20px;">驳回</a>       
        <a class="nui-button" onclick="onCancel" style="width:60px;">取消</a>       
	</div> 

	<script type="text/javascript">
    	nui.parse();
    	
    	var tabsVacation = nui.get("tabsVacation");
    	var vacationData;
    	
    	$(function() {
    		var tabVacation = tabsVacation.getTab("tabVacation");
    		tabVacation.onload = function(e) {
    			if(vacationData) {
	    			var iframe = tabsVacation.getTabIFrameEl(e.tab);
	    			iframe.contentWindow.SetData(vacationData);
    			}
    		};
    	});
    	
    	/**
    	 * @param result 审批结果（1：审批通过, 0：审批不通过）
		 */
    	function approve(result) {
    	
    		var comments = nui.getbyName("comments").getValue();
    		var approvalStatus = result;
    		var json = nui.encode(vacationData) +  nui.encode({comments: comments, approvalStatus: approvalStatus});
    		
    		nui.ajax({
                url: "com.primeton.vacation.vacation.arppoveVacation.biz.ext",
                data: json,
                type: 'POST',
                cache: false,
                contentType: 'text/json',
                success: function (text) {
            		CloseWindow();
                }
            });
    	}
    	
    	function onCancel() {
    		CloseWindow("cancel");
    	}
    	
    	function SetData(data) {
    		vacationData = nui.clone(data);
    	}
    	
		function CloseWindow(action) {
			if (window.CloseOwnerWindow)
				return window.CloseOwnerWindow(action);
			else
				window.close();
		}
    </script>
</body>
</html>