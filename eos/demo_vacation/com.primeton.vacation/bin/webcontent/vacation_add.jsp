<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2015-09-01 14:53:45
  - Description:
-->
<head>
<title>vacation_add</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <script src="<%= request.getContextPath() %>/vacation/js/renders.js" type="text/javascript"></script>
</head>
<body>
    <form id="formVacation" method="post" >
        <input name="vacation.id" id="vacationid" class="nui-hidden" />
        
        <div style="padding-left:11px;padding-bottom:5px;">
            <table style="table-layout:fixed;">
                <tr>
                    <td style="width:70px;">申请人：</td>
                    <td style="width:150px;">    
                        <input name="vacation.applicant" class="nui-textbox" required="true"  emptyText="请输入申请人"/>
                    </td>
                    <td style="width:70px;">类型：</td>
                    <td style="width:150px;">    
                    	<input name="vacation.type" data="vacationTypes" class="nui-combobox" valueField="id" textField="text"
                    		required="true" emptyText="请选择请假类型"/>
                    </td>

                </tr>
                <tr>
                    <td >开始时间：</td>
                    <td >
                        <input name="vacation.starttime" format="yyyy-MM-dd HH:mm" showTime="true" class="nui-datepicker" required="true"/>
                    </td>
                    <td >结束时间：</td>
                    <td >    
						<input name="vacation.endtime" format="yyyy-MM-dd HH:mm" showTime="true" class="nui-datepicker" required="true"/>
                    </td>
                </tr>
               
                <tr>
                    <td colspan="4">备注：</td>
                </tr>    
                <tr>
                    <td colspan="4" style="padding:0px;">    
                        <input class="nui-textarea" name="vacation.remark" style="width: 430px;"/>
                    </td>
                </tr>       
            </table>
        </div>
        
        <div style="text-align:center;padding:10px;">               
            <a class="nui-button" onclick="onOk" style="width:60px;margin-right:20px;">确定</a>       
            <a class="nui-button" onclick="onCancel" style="width:60px;">取消</a>       
        </div>        
    </form>

	<script type="text/javascript">
    	nui.parse();
    	
    	var formVacation = new nui.Form("#formVacation");
    	
    	function SetData(data) {
    		// 获取从其他页面传递来的数据
    		console.log(data);
    		formVacation.setData(data);
    	}
    	
    	function onOk() {
    		saveData();
    	}
    	
		function saveData() {
            var o = formVacation.getData();  
            console.log(nui.encode(o));
            var bizUrl = "com.primeton.vacation.vacation.saveVacation.biz.ext";  
            
            formVacation.validate();
            var json = nui.encode(o);
            
            nui.ajax({
                url: bizUrl,
                data: json,
                type: 'POST',
                cache: false,
                contentType: 'text/json',
                success: function (text) {
                    CloseWindow("save");
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText);
                    CloseWindow();
                }
            });
        }
        
		function CloseWindow(action) {
			if (window.CloseOwnerWindow)
				return window.CloseOwnerWindow(action);
			else
				window.close();
		}

		function cancel() {
			CloseWindow("cancel");
		}
    	
    	function onCancel() {
			cancel();
		}
    </script>
</body>
</html>
