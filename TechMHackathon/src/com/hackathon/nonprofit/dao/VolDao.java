package com.hackathon.nonprofit.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.hackathon.nonprofit.action.VolRegistrationAction;
import com.hackathon.nonprofit.utils.DbUtil;

public class VolDao {

	
	
	 private static Connection connection;

	    public VolDao() {
	        connection = DbUtil.getConnection();
	    }
	    
	public void registerVolunteer(VolRegistrationAction volReg)
	{
		
		try {
			
			
			
			connection = DbUtil.getConnection();
			
			String userId="";
			PreparedStatement preparedStatement = connection.
                    prepareStatement("SELECT * FROM USER WHERE USERNAME=?");
            preparedStatement.setString(1, volReg.getUserName());
            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
            	userId=rs.getString("USER_ID");
            }
            
			 preparedStatement = connection.prepareStatement("INSERT INTO VOLUNTEER_SCH VALUES (?,?,?,?,?,?,?,?,1,1)");		
			
			 preparedStatement.setString(1, userId);
			 preparedStatement.setString(2, volReg.getIsMonday());
			 preparedStatement.setString(3, volReg.getIsTuesday());
			 preparedStatement.setString(4, volReg.getIsWednesday());
			 preparedStatement.setString(5, volReg.getIsThursday());
			 preparedStatement.setString(6, volReg.getIsFriday());
			 preparedStatement.setString(7, volReg.getIsSaturday());
			 preparedStatement.setString(8, volReg.getIsSunday());
			
			preparedStatement.executeUpdate();
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        	
		
	}
	
	
	
	
	public void addEvent(VolRegistrationAction bean)	
	{
	
		try
		{
		connection = DbUtil.getConnection();
		
		PreparedStatement preparedStatement = null;
		preparedStatement = connection.prepareStatement("INSERT INTO EVENT(TITLE,SUMMARY,ADDRESS,PHONE_NO,EVENT_DATE) VALUES (?,?,?,?,?)");		
		
		 preparedStatement.setString(1, bean.getEventTitle());
		 preparedStatement.setString(2, bean.getEventDesc());
		 preparedStatement.setString(3, bean.getEventLocation());
		 preparedStatement.setString(4, bean.getContact());
		 preparedStatement.setString(5, bean.getEventDate());
		 
		 preparedStatement.executeUpdate();
	
		 
		 
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	}
	
	
}
