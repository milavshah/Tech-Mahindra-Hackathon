package com.hackathon.nonprofit.action;

import java.util.ArrayList;
import java.util.Map;

import org.apache.struts2.dispatcher.SessionMap;
import org.apache.struts2.interceptor.SessionAware;

import sun.net.www.content.text.Generic;

import com.hackathon.nonprofit.dao.UserDao;
import com.opensymphony.xwork2.ActionSupport;

public class LoginAction extends ActionSupport implements SessionAware {
    private String username;
    private String password;
    SessionMap<String, String> sessionmap;
    
    public String execute() {
    	
    	UserDao dao = new UserDao();
    	
    	if(this.username!=null && this.password!=null && !"".equals(this.username) && !("").equals(this.password))
    	{
    	
        if (dao.isValidUser(this.username, this.password)) {
        	String userType = dao.getUserType(this.username);
        	sessionmap.put("username",this.username);
        	sessionmap.put("password",this.password);
        	sessionmap.put("usertype",userType);
            return "success";
        }
        else {
            addActionError(getText("error.login"));
            return "error";
        }
    	}
    	else
    	{
    		addActionError(getText("error.input.login"));
            return "error";
    	}
    }
 
    public String getUsername() {
        return username;
    }
 
    public void setUsername(String username) {
        this.username = username;
    }
 
    public String getPassword() {
        return password;
    }
 
    public void setPassword(String password) {
        this.password = password;
    }

	@Override
	public void setSession(Map map) {
		// TODO Auto-generated method stub
		
		sessionmap=(SessionMap)map;  
	    sessionmap.put("login","true");
	    
	}
	
	
	
	public String logout(){  
	    sessionmap.invalidate();  
	    return "success";  
	} 
	
}

