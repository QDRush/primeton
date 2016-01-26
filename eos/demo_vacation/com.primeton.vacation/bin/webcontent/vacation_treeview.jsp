<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2015-09-04 14:11:52
  - Description:
-->
<head>
<title>请假单树形展示</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="width:90%;height:95%;">
	<div class="nui-div">
	    <ul id="tree1" class="nui-tree" url="com.primeton.vacation.vacation.getEmpVacationTree.biz.ext" 
	    	style="width:100%;padding:5px;height:100;" showTreeIcon="true" textField="text" idField="id" parentField="pid" resultAsTree="false"  
	        dataField="vacationTree" >
	    </ul>
    </div>
	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>