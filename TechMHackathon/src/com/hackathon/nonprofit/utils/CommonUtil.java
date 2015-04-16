package com.hackathon.nonprofit.utils;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.hackathon.nonprofit.dao.UserDao;
import com.opensymphony.xwork2.ActionSupport;



public class CommonUtil extends ActionSupport{

	
	 private static MessageDigest digester;

	    static {
	        try {
	            digester = MessageDigest.getInstance("MD5");
	        }
	        catch (NoSuchAlgorithmException e) {
	            e.printStackTrace();
	        }
	    }
	
	
	 public  String crypt(String str) {
	        if (str == null || str.length() == 0) {
	            throw new IllegalArgumentException("String to encrypt cannot be null or zero length");
	        }

	        digester.update(str.getBytes());
	        byte[] hash = digester.digest();
	        StringBuffer hexString = new StringBuffer();
	        for (int i = 0; i < hash.length; i++) {
	            if ((0xff & hash[i]) < 0x10) {
	                hexString.append("0" + Integer.toHexString((0xFF & hash[i])));
	            }
	            else {
	                hexString.append(Integer.toHexString(0xFF & hash[i]));
	            }
	        }
	        return hexString.toString();
	    }
	
	 
	 public String searchMobCode()
	 {
		 String output="";
		 
		 HttpServletResponse response = ServletActionContext.getResponse();
		 HttpServletRequest request = ServletActionContext.getRequest();
		 
		 try {
			 	PrintWriter out = response.getWriter();
			 	String mobNo = request.getParameter("mobno");
			 	UserDao dao = new UserDao();
			 	output = dao.getMobCode(mobNo);
			 	out.print(output);
			 	out.flush();
			
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
		 
		 
		 return null;
	 }
	 
	 
	 public static void main(String[] args)
	 {
		 String a ="Kamesh@123";
		 String b="john123";
		 
		 
		 CommonUtil util = new CommonUtil();
		 System.out.println(util.crypt(a));
		 System.out.println(util.crypt(b));
		 
	 }
	 
	 
	 
	 
}
