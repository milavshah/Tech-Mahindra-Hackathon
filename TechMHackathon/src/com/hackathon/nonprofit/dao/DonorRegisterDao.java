package com.hackathon.nonprofit.dao;

import java.sql.Connection;
import java.util.Random;

import com.hackathon.nonprofit.action.DonorRegistrationAction;
import com.hackathon.nonprofit.utils.DbUtil;

public class DonorRegisterDao {
	
	
	private Connection connection;

    public DonorRegisterDao() {
        connection = DbUtil.getConnection();
    }
	
	public String addDonor(DonorRegistrationAction bean)	
	{
		String result="";
		
		Random rand = new Random();
		int num = rand.nextInt(9000000) + 1000000;
		
		
		return result;
		
		
		
	}

}
