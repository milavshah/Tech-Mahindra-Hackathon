package com.hackathon.nonprofit.action;

import org.apache.struts2.ServletActionContext;

import com.hackathon.nonprofit.dao.UserDao;
import com.opensymphony.xwork2.ActionSupport;
import javax.servlet.http.HttpServletRequest;

public class UserRegistrationAction extends ActionSupport {
	
	private String fname;
	private String lname;
	private String streetAddr;
	private String zipcode;
	private String mobNo;
	private String city;
	private String state;
	private String country;
	private String email;
	private String userName;
	private String password;
	private String mobCode;
	private String userType;
	


	public String getUserType() {
		return userType;
	}



	public void setUserType(String userType) {
		this.userType = userType;
	}



	public String getMobCode() {
		return mobCode;
	}



	public void setMobCode(String mobCode) {
		this.mobCode = mobCode;
	}



	public String getUserName() {
		return userName;
	}



	public void setUserName(String userName) {
		this.userName = userName;
	}



	public String getPassword() {
		return password;
	}



	public void setPassword(String password) {
		this.password = password;
	}



	public String getFname() {
		return fname;
	}



	public void setFname(String fname) {
		this.fname = fname;
	}



	public String getLname() {
		return lname;
	}



	public void setLname(String lname) {
		this.lname = lname;
	}



	public String getStreetAddr() {
		return streetAddr;
	}



	public void setStreetAddr(String streetAddr) {
		this.streetAddr = streetAddr;
	}



	public String getZipcode() {
		return zipcode;
	}



	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}



	public String getMobNo() {
		return mobNo;
	}



	public void setMobNo(String mobNo) {
		this.mobNo = mobNo;
	}



	public String getCity() {
		return city;
	}



	public void setCity(String city) {
		this.city = city;
	}



	public String getState() {
		return state;
	}



	public void setState(String state) {
		this.state = state;
	}



	public String getCountry() {
		return country;
	}



	public void setCountry(String country) {
		this.country = country;
	}



	public String getEmail() {
		return email;
	}



	public void setEmail(String email) {
		this.email = email;
	}



	public String execute() {
		 		
		try 
		{							
			
			HttpServletRequest request = ServletActionContext.getRequest();
		
			int errCount=0;
        if (this.fname.equals("") || this.fname==null) {       
            addActionError(getText("donor.error.fname"));
            errCount++;
        }
        
        
        if (this.mobNo.equals("") || this.mobNo==null) {       
            addActionError(getText("donor.error.mobNo"));
            errCount++;
        }
        
        if (this.email.equals("") || this.email==null) {       
            addActionError(getText("donor.error.email"));
            errCount++;
        }
        
        if(errCount>0)
        	return "error";
        else 
        {        	
        		UserDao userdao = new UserDao();
        		String mobCode = userdao.addUser(this);
        		
        		request.setAttribute("mobNo", this.mobNo);
        		request.setAttribute("mobCode", "Please enter the following code : "+mobCode+" to complete your registration process");
        		return "success";
        		
        	
        }
                
        
		}  catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
    }
	
	
	public String completeReg()
	{
		try
		{
			int errCount=0;
			UserDao dao = new UserDao();
			HttpServletRequest request = ServletActionContext.getRequest();
			String mobCode = request.getParameter("mobcode");
			String recipient = request.getParameter("recipient");
			
			if(dao.isValidMobCode(recipient, mobCode))
			{
				dao.updateUser(recipient);
			}
			else
			{
				addActionError(getText("donor.error.mobCode"));
	            errCount++;
			}
			if(errCount>0)
				return "error";
			else
				return "success";
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}
 
	

}
