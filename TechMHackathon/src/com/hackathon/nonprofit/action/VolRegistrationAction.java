package com.hackathon.nonprofit.action;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;


import com.hackathon.nonprofit.dao.VolDao;
import com.opensymphony.xwork2.ActionSupport;

public class VolRegistrationAction extends ActionSupport {


	private String isMonday;
	private String isTuesday;
	private String isWednesday;
	private String isThursday;
	private String isFriday;
	private String isSaturday;
	private String isSunday;
	private String userName;
	
	private String studentId;
	
	
	
	
	
	private String eventTitle;
	private String eventDesc;
	private String eventLocation;
	private String contact;
	private String eventDate;
	
	
	
	
	public String getEventTitle() {
		return eventTitle;
	}


	public void setEventTitle(String eventTitle) {
		this.eventTitle = eventTitle;
	}


	public String getEventDesc() {
		return eventDesc;
	}


	public void setEventDesc(String eventDesc) {
		this.eventDesc = eventDesc;
	}


	public String getEventLocation() {
		return eventLocation;
	}


	public void setEventLocation(String eventLocation) {
		this.eventLocation = eventLocation;
	}


	public String getContact() {
		return contact;
	}


	public void setContact(String contact) {
		this.contact = contact;
	}


	public String getEventDate() {
		return eventDate;
	}


	public void setEventDate(String eventDate) {
		this.eventDate = eventDate;
	}


	public String getStudentId() {
		return studentId;
	}


	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}


	public String getUserName() {
		return userName;
	}


	public void setUserName(String userName) {
		this.userName = userName;
	}


	public String getIsMonday() {
		return isMonday;
	}


	public void setIsMonday(String isMonday) {
		this.isMonday = isMonday;
	}


	public String getIsTuesday() {
		return isTuesday;
	}


	public void setIsTuesday(String isTuesday) {
		this.isTuesday = isTuesday;
	}


	public String getIsWednesday() {
		return isWednesday;
	}


	public void setIsWednesday(String isWednesday) {
		this.isWednesday = isWednesday;
	}


	public String getIsThursday() {
		return isThursday;
	}


	public void setIsThursday(String isThursday) {
		this.isThursday = isThursday;
	}


	public String getIsFriday() {
		return isFriday;
	}


	public void setIsFriday(String isFriday) {
		this.isFriday = isFriday;
	}


	public String getIsSaturday() {
		return isSaturday;
	}


	public void setIsSaturday(String isSaturday) {
		this.isSaturday = isSaturday;
	}


	public String getIsSunday() {
		return isSunday;
	}


	public void setIsSunday(String isSunday) {
		this.isSunday = isSunday;
	}


	public String execute() {
		
		HttpServletRequest request = ServletActionContext.getRequest();
		VolDao dao = new VolDao();
		
		
		HttpSession session = request.getSession();
		String userName = (String)session.getAttribute("username");
		
		
		this.setIsMonday("N");
		this.setIsTuesday("N");
		this.setIsWednesday("N");
		this.setIsThursday("N");
		this.setIsFriday("N");
		this.setIsSaturday("N");
		this.setIsSunday("N");
		this.setUserName(userName);
		
		String[] days=request.getParameterValues("days");
		
		for(int i=0;i<days.length;i++)
		{
			if(days[i].equals("1"))
				this.setIsMonday("Y");
			
			if(days[i].equals("2"))
				this.setIsTuesday("Y");
			
			if(days[i].equals("3"))
				this.setIsWednesday("Y");
			
			if(days[i].equals("4"))
				this.setIsThursday("Y");
			
			if(days[i].equals("5"))
				this.setIsFriday("Y");
			
			if(days[i].equals("6"))
				this.setIsSaturday("Y");
			
			if(days[i].equals("7"))
				this.setIsSunday("Y");
			
				
		}
		
		
		dao.registerVolunteer(this);
		return "success";
	}


	
	public String addEvent()
	{
		
		HttpServletRequest request = ServletActionContext.getRequest();
		VolDao dao = new VolDao();
		
		VolRegistrationAction bean = new VolRegistrationAction();
		bean.setEventTitle(request.getParameter("title"));
		bean.setEventDesc(request.getParameter("desc"));
		bean.setEventLocation(request.getParameter("location"));
		bean.setEventDate(request.getParameter("date"));
		bean.setContact(request.getParameter("contact"));
		dao.addEvent(bean);
		
		return "success";
		
	}

}
