<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<title>
Complete your registration</title>
<!-- All three files required for Kandy  -->
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<script src="https://kandy-portal.s3.amazonaws.com/public/javascript/fcs/3.0.1/fcs.js"></script>
<script src="https://kandy-portal.s3.amazonaws.com/public/javascript/kandy/2.1.0/kandy.js"></script>

<script language = "JavaScript">
    // this is called when page is done loading to set up (initialize) the KandyAPI.Phone
    setup = function() {

        // initialize KandyAPI.Phone, passing a config JSON object that contains listeners (event callbacks)
        KandyAPI.Phone.setup({
            // respond to Kandy events...
            listeners: {
                loginsuccess: function () {
                    changeUIState('LOGGED_IN');
                },
                loginfailed: function () { alert("Login failed");}
            }
        });
    };

    login = function() {
        KandyAPI.Phone.login("DAK48ccfbb3738c46eb80ad1e7e0153e7b7", "kaushal", "Kamesh@123");
    };

    logout = function() {
        KandyAPI.Phone.logout(function () {
            changeUIState('LOGGED_OUT');
        });
    };

    sendSMS = function() {
        var uuid = KandyAPI.Phone.sendSMS(
                $('#recipient').val(),
                $('#sender').val(),
                $('#message').val(),
                function() {
                    $('#messages').append();
                    $('#imMessageToSend').val('');
                },
                function(message, status) {
                    alert("IM send failed");
                }
        );
    };

    changeUIState = function(state) {
        switch (state) {
            case 'LOGGED_OUT':
                $('#loggedInAs').val('');
                $("#loginForm").show();
                $("#loggedIn").hide();
                $("#chat").hide();
                break;
            case 'LOGGED_IN':
                $('#loggedInAs').text($('#logInId').val());
                $("#loginForm").hide();
                $("#loggedIn").show();
                $("#chat").show();
                break;
        }
    }
    
    
    
    

	$(document).ready(function() { 
    $("#resend").click(function(event){
    	alert('resend');
    	
    $.ajax({
        type: 'POST',
        url:'search.action?mobno='+ document.getElementById('recipient').value,
        success: function(data){
       // console.log(stringify(data));
       setData(data);
        }});
    });
    
    
    function setData(data)
    {
    	alert('data is: '+data);
    	document.getElementById('message').value='Please enter following code :'+data+' to complete your registration';
    	sendSMS();
    }
    });
</script>

<style>
    #domainApiId{width:200px;margin-bottom:1px}
    #logInId{width:200px;margin:0 0 1px 64px;}
    #passwd{width:200px;margin-left: 41px;}
    #loginBtn{width:90px;height:23px;margin:5px 0 5px 110px;}
    .imUsername{display:inline-block; width:100px}
    #imMessageToSend{width:175px}
    #messages{border: solid black 1px}
    .imMessage{display:inline-block; width:275px}
    #logoutBtn{width:90px;height:23px;}
</style>
</head>

<body onload="login()" style="width:500px;">
<h2>Complete Your Registration</h2>

<br/>
<br/>
<div id="chat">

<s:actionerror />

    <s:form action="completereg.action" method="post">    
    <div>
    If you have not received your verification code, please enter your mobile number and press Resend Button
    </div>   
    
    <div style="display: none">
            Sender: <input id="sender" type="text" placeholder="phone number" value="14694529289"/><br/>
        </div>
        
        <div>
            Enter your mobile number: <input id="recipient" name="recipient" type="text" placeholder="phone number" value="" required="required"/>
        </div>
        
        <div>
            Enter your mobile code: <input id="mobcode" name="mobcode" type="text" placeholder="phone number" value="" required="required"/>
        </div>
        <div style="display: none">
            Message: <textarea id= "message" type="text" ></textarea>
        </div>

        <input type="button" id="resend" value="Resend Verification Code"/>  <br/>
        <s:submit method="execute" key="label.complete" align="center" /> 
    </s:form>
    <div id="messages" style="width:500px"></div>
</div>
</body>
</html>
