package com.hackathon.nonprofit.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;

import javax.net.ssl.HttpsURLConnection;

import org.json.JSONArray;
import org.json.JSONObject;


public class HttpClient {
	public static void main(String[] args) {
		  try {
	 											
			new HttpClient().testIt();
	 
		  }  catch (Exception e) {
	 
			e.printStackTrace();
		  }
	 
		}









	
	private void testIt(){
		 
	      String https_url = "https://api.kandy.io/v1.1/domains/users/accesstokens?key=DAK48ccfbb3738c46eb80ad1e7e0153e7b7&user_id=kaushal&user_password=Kamesh@123";
	      URL url;
	      try {
	 
		     url = new URL(https_url);
		     HttpsURLConnection con = (HttpsURLConnection)url.openConnection();
	 
	 
		     //dump all the content
		    String user_access_token= print_content(con);
		    
		    
		    String address_url="https://api.kandy.io/v1.1/users/addressbooks/personal?key="+user_access_token+"&name=kaushal&mobile_numer=14694529289";
		    
		    
		    url = new URL(address_url);
		     con = (HttpsURLConnection)url.openConnection();
	 
	 
		     //dump all the content
		     add_record(con);
		    
	 
	      } catch (MalformedURLException e) {
		     e.printStackTrace();
	      } catch (IOException e) {
		     e.printStackTrace();
	      }
	 
	   }
	 




	private String print_content(HttpsURLConnection con){
		
		String projectname="";
		if(con!=null){
	 
			
		try {
	 
			
		   System.out.println("****** Content of the URL ********");			
		   BufferedReader br = 
			new BufferedReader(
				new InputStreamReader(con.getInputStream()));
	 
		   String input;
		   
		
		   
			
		   String jsondata="";
		   while ((input = br.readLine()) != null){
			   jsondata+=input;
		      System.out.println(input);
		   }
		   br.close();
		   
		   JSONObject obj;
		try {
			obj = new JSONObject(jsondata);
	
			JSONObject data = obj.getJSONObject("result");
			 projectname = data.getString("user_access_token");
			
			System.out.println(projectname);
			
			
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
			
	 
		} catch (IOException e) {
		   e.printStackTrace();
		}
	 
	       }
	 
		return projectname;
	   }

	
	
	
	
	
	
private String add_record(HttpsURLConnection con){
		
		String projectname="";
		if(con!=null){
	 
			
		try {
	 
			
		   System.out.println("****** Content of the URL ********");			
		   BufferedReader br = 
			new BufferedReader(
				new InputStreamReader(con.getInputStream()));
	 
		   String input;
		   
		
		   
			
		   String jsondata="";
		   while ((input = br.readLine()) != null){
			   jsondata+=input;
		      System.out.println(input);
		   }
		   br.close();
		   
		   JSONObject obj;
		try {
			obj = new JSONObject(jsondata);
	
			/*JSONObject data = obj.getJSONObject("result");
			 projectname = data.getString("user_access_token");
			
			System.out.println(projectname);*/
			
			
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
			
	 
		} catch (IOException e) {
		   e.printStackTrace();
		}
	 
	       }
	 
		return projectname;
	   }



}
