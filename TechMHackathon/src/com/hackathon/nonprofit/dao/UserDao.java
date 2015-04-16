package com.hackathon.nonprofit.dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Random;

import com.hackathon.nonprofit.action.UserRegistrationAction;
import com.hackathon.nonprofit.entity.StudentBean;
import com.hackathon.nonprofit.utils.CommonUtil;
import com.hackathon.nonprofit.utils.DbUtil;


public class UserDao {

    private static Connection connection;

    public UserDao() {
        connection = DbUtil.getConnection();
    }
    
   

    /*public void addUser(User user) {
        try {
            PreparedStatement preparedStatement = connection
                    .prepareStatement("insert into users(firstname,lastname,dob,email) values (?, ?, ?, ? )");
            // Parameters start with 1
            preparedStatement.setString(1, user.getFirstName());
            preparedStatement.setString(2, user.getLastName());
            preparedStatement.setDate(3, new java.sql.Date(user.getDob().getTime()));
            preparedStatement.setString(4, user.getEmail());
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteUser(int userId) {
        try {
            PreparedStatement preparedStatement = connection
                    .prepareStatement("delete from users where userid=?");
            // Parameters start with 1
            preparedStatement.setInt(1, userId);
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateUser(User user) {
        try {
            PreparedStatement preparedStatement = connection
                    .prepareStatement("update users set firstname=?, lastname=?, dob=?, email=?" +
                            "where userid=?");
            // Parameters start with 1
            preparedStatement.setString(1, user.getFirstName());
            preparedStatement.setString(2, user.getLastName());
            preparedStatement.setDate(3, new java.sql.Date(user.getDob().getTime()));
            preparedStatement.setString(4, user.getEmail());
            preparedStatement.setInt(5, user.getUserid());
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<User>();
        try {
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery("select * from users");
            while (rs.next()) {
                User user = new User();
                user.setUserid(rs.getInt("userid"));
                user.setFirstName(rs.getString("firstname"));
                user.setLastName(rs.getString("lastname"));
                user.setDob(rs.getDate("dob"));
                user.setEmail(rs.getString("email"));
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return users;
    }

    public User getUserById(int userId) {
        User user = new User();
        try {
            PreparedStatement preparedStatement = connection.
                    prepareStatement("select * from users where userid=?");
            preparedStatement.setInt(1, userId);
            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                user.setUserid(rs.getInt("userid"));
                user.setFirstName(rs.getString("firstname"));
                user.setLastName(rs.getString("lastname"));
                user.setDob(rs.getDate("dob"));
                user.setEmail(rs.getString("email"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }*/
    
    
    
    public void getUserById(int userId) {
    	StudentBean user = new StudentBean();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("select * from department");
            
            ResultSet rs = preparedStatement.executeQuery();
            if(rs!=null && rs.next())
            {
            	System.out.println(rs.getString("dname"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
     
    
    
    public String addUser(UserRegistrationAction bean)	
	{
		String result="";
		
		Random rand = new Random();
		int num = rand.nextInt(9000000) + 1000000;
		
		bean.setMobCode(Integer.toString(num));
		
		CommonUtil util = new CommonUtil();
		String encryptedPass = util.crypt(bean.getPassword());
		
		
		try {
			
			connection = DbUtil.getConnection();        
			PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO USER (USER_ID,F_NAME,L_NAME,EMAIL_ID,USERNAME,STREET_ADDR,CITY,STATE,COUNTRY,PASSWORD,ZIP_CODE,MOB_NO,MOB_CODE,ACTIVE_FLAG,USER_TYPE) values (NULL,'"+bean.getFname()+"','"+bean.getLname()+"','"+bean.getEmail()+"','"+bean.getUserName()+"','"+bean.getStreetAddr()+"','"+bean.getCity()+"','"+bean.getState()+"','"+bean.getCountry()+"','"+encryptedPass+"','"+bean.getZipcode()+"','"+bean.getMobNo()+"','"+bean.getMobCode()+"','N','"+bean.getUserType()+"')");		
			//preparedStatement.executeQuery();
			
			preparedStatement.execute();
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
                		
		return bean.getMobCode();
		
	}
    
    
    public String getMobCode(String mobNo)
    {
    	String mobCode="";
    	
    	try {
            PreparedStatement preparedStatement = connection.
                    prepareStatement("SELECT * FROM USER WHERE MOB_NO=?");
            preparedStatement.setString(1, mobNo);
            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                mobCode=rs.getString("MOB_CODE");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

    	
    	
    	return mobCode;
    }
    
    
    public boolean isValidMobCode(String mobNo, String mobCode)
    {
    	boolean flag=false;
    	String userMobCode=null;
    	
    	PreparedStatement preparedStatement;
		try {
			preparedStatement = connection.
			        prepareStatement("SELECT * FROM USER WHERE MOB_NO=?");
		
        preparedStatement.setString(1, mobNo);
        ResultSet rs = preparedStatement.executeQuery();

        if (rs.next()) {
        	userMobCode=rs.getString("MOB_CODE");
        }
    	
        if(userMobCode.equalsIgnoreCase(mobCode))
        	flag=true;
        
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return flag;
    }
    
    
    public boolean updateUser(String mobNo)
    {
    	
    	boolean flag=false;    	
    	
    	PreparedStatement preparedStatement;
		try {
			preparedStatement = connection.
			        prepareStatement("UPDATE USER U SET U.ACTIVE_FLAG='Y' WHERE U.MOB_NO=?");
		
        preparedStatement.setString(1, mobNo);
        int a = preparedStatement.executeUpdate();
        
        if(a>0)
        {
        	flag=true;
        }
        
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return flag;
    }
    
    
    
    public boolean isValidUser(String userid, String password)    
    {
    	
    	boolean flag=false;
    	String userPass=null;
    	
    	PreparedStatement preparedStatement;
		try {
			preparedStatement = connection.
			        prepareStatement("SELECT * FROM USER WHERE USERNAME=?");
		
        preparedStatement.setString(1, userid);        
        
        CommonUtil util = new CommonUtil();
		String encryptedPass = util.crypt(password); 
        
        ResultSet rs = preparedStatement.executeQuery();

        if (rs.next()) {
        	userPass=rs.getString("PASSWORD");
        }
    	
        if(encryptedPass.equalsIgnoreCase(userPass))
        	flag=true;
        
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return flag;
    	
    }
    
    
    public String getUserType(String userid)    
    {
    	    	
    	String userType=null;
    	
    	PreparedStatement preparedStatement;
		try {
			preparedStatement = connection.
			        prepareStatement("SELECT * FROM USER WHERE USERNAME=?");
		
        preparedStatement.setString(1, userid);                        
        
        ResultSet rs = preparedStatement.executeQuery();

        if (rs.next()) {
        	userType=rs.getString("USER_TYPE");
        }
    	
        
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return userType;
    	
    }
    
    public ArrayList getEventList()    
    {
    	    	
    	ArrayList eventList=null;
    	
    	PreparedStatement preparedStatement;
		try {
			preparedStatement = connection.
			        prepareStatement("SELECT DISTINCT TITLE FROM EVENT;");                       
        
        ResultSet rs = preparedStatement.executeQuery();

        if (rs.next()) {
        	eventList.add(rs.getString("USER_TYPE"));
        }
    	
        
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return eventList;
    	
    }
    
    public static void main(String []args) {    	
        try {
        	
        	connection = DbUtil.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement("select * from user");
            
            
            ResultSet rs = preparedStatement.executeQuery();
            while(rs!=null && rs.next())
            {
            	System.out.println(rs.getString("EMAIL_ID"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    
    
    
}
