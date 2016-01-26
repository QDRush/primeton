/**
 * 
 */
package com.primeton.vacation;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.eos.foundation.data.DataObjectUtil;
import com.eos.system.annotation.Bizlet;
import com.primeton.workflow.commons.utility.CalenderUtil;

import commonj.sdo.DataObject;

/**
 * @author Feng Zhou
 * @date 2015-09-04 13:56:29
 *
 */
@Bizlet("VacationTreeService")
public class VacationTreeService {

	public static HashMap<Integer, String> vacationTypeMap = new HashMap<Integer, String>() {
		{
			put(0, "年假");
			put(1, "年假");
			put(2, "病假");
			put(3, "探亲假");
			put(4, "婚假");
		}
	};
	
	/**
	 * 获取日期之间相隔的天数
	 */
	private static String getIntervalDays(Date startTime, Date endTime) {
		DecimalFormat df = new DecimalFormat("0.0");   
		long timestampInterval = endTime.getTime() - startTime.getTime();
		double daysInterval = timestampInterval / (1000.0 * 3600.0 * 24.0);
		
		return df.format(daysInterval);
	}
	
	/**
	 * @param vacations
	 * @return
	 * @author Feng Zhou
	 */
	@Bizlet("请假单持久化对象转换为树结构")
	public static DataObject[] adaptTree(DataObject[] vacations) {
		DataObject[] vacationTree = null;
		List<DataObject> doList = new ArrayList<DataObject>();
		List<String> applicantList = new ArrayList<String>();
		
		if(vacations == null || vacations.length == 0) return null;
		
		// 获取所有请假申请人
		String varApplicant;
		for(DataObject dobj : vacations) {
			varApplicant = dobj.getString("applicant");
			if(!applicantList.contains(varApplicant)) {
				applicantList.add(varApplicant);
			}
		}
		
		// 创建父节点
		for(String applicant : applicantList) {
			DataObject node = DataObjectUtil.createDataObject("com.primeton.vacation.vacation.VacationTree");
			node.setString("id", applicant);
			node.setString("text", applicant);
			doList.add(node);
		}

		// 创建子节点
		Date tempStartDate = null;
		Date tempEndDate = null;
		for(DataObject dobj : vacations) {
			DataObject node = DataObjectUtil.createDataObject("com.primeton.vacation.vacation.VacationTree");
			
			node.setString("id", dobj.getString("id"));
			tempStartDate = dobj.getDate("starttime");
			tempEndDate = dobj.getDate("endtime");
			node.setString("text", vacationTypeMap.get(dobj.getInt("type")) + " " + getIntervalDays(tempStartDate, tempEndDate) + "天");
			node.setString("pid", dobj.getString("applicant"));
			
			doList.add(node);
		}
		
		// 转换为数组
		vacationTree = doList.toArray(new DataObject[doList.size()]);
		
		return vacationTree;
	}

}
