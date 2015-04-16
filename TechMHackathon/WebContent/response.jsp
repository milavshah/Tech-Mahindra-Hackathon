<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- All three files required for Kandy  -->
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<script src="https://kandy-portal.s3.amazonaws.com/public/javascript/fcs/3.0.1/fcs.js"></script>
<script src="https://kandy-portal.s3.amazonaws.com/public/javascript/kandy/2.1.0/kandy.js"></script>




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



<script type="text/javascript">
    // this is called when page is done loading to set up (initialize) the KandyAPI.Phone    

       var mobileno='';
    	var mobilecode='';
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
    	//alert('login');
        KandyAPI.Phone.login("DAK48ccfbb3738c46eb80ad1e7e0153e7b7", "kaushal", "Kamesh@123");
    };

    logout = function() {
        KandyAPI.Phone.logout(function () {
            changeUIState('LOGGED_OUT');
        });
    };

    
    
    sendSMS = function() {
    	//alert('sendsms');
    	//alert($('#recipient').val());
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
        //window.location.href='Register.jsp';
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
    };
    
    
</script>
</head>


<body  style="width:500px;" >


 <% 

String mobno = (String) request.getAttribute("mobNo");
String mobcode = (String) request.getAttribute("mobCode");

System.out.println("sdasd: "+mobno+"asdasd:"+mobcode);

%>
<input type="hidden" value="<%= request.getAttribute("mobNo") %>" id='1'>
<input type="hidden" value="<%= request.getAttribute("mobCode") %>" id='2'>

<%-- <script type="text/javascript">
mobileno=<%=mobno%>;
alert('mo no is: '+mobileno);
mobilecode=<%=mobcode%>;
</script> --%>
<!-- <h2>Quick Start Sample App: Chat</h2> -->

<div id="loggedIn" style="display: none">
   <span id="loggedInAs"></span>. &nbsp;&nbsp;&nbsp;&nbsp;
    <input id="logoutBtn" type="button" value="Log Out" onclick="logout()" />
</div>
<br/>
<br/>
<div id="chat" style="display: none">
    <form id="imForm" >
    
        <div>
            Sender: <input id="sender" type="text" placeholder="phone number" value=""/><br/>
        </div>
        <div>
            Recipient: <input id="recipient" type="text" placeholder="phone number" value=""/>
        </div>
        <div>
            Message: <textarea id= "message" type="text" ></textarea>
        </div>
		
		<input type="button" id="loginbtn" onclick="login();return false;" value="Login"/>  <br/>
		
        <input type="button" id="send" onclick="sendSMS();return false;" value="Send"/>  <br/>
    </form>
    <div id="messages" style="width:500px"></div>
</div>

<%-- <jsp:forward page="Register.jsp">
<jsp:param name="firstName" value="Enter First Nam" />
  <jsp:param name="lastName" value="Enter Last Name" />
 </jsp:forward> --%>



<script type="text/javascript">

/* document.onload=function(){
alert('inside');
	document.getElementById('sender').value='14698038682';

document.getElementById('recipient').value='14698038682';
document.getElementById('message').value='asdaskdsakdasd';

document.getElementById('send').click();
};
 */


 $( document ).ready(function() {
	   // code here	   
	/* document.getElementById('sender').value='14698038682';

document.getElementById('recipient').value='14698038682';
document.getElementById('message').value='asdaskdsakdasd'; */

//alert('inside');

$("#loginbtn").click();
document.getElementById('sender').value='14698038682';
document.getElementById('recipient').value=document.getElementById('1').value;
document.getElementById('message').value=document.getElementById('2').value;




setTimeout(
		  function() 
		  {
			  $("#send").click();  //do something special			  
		  }, 1500);


setTimeout(
		  function() 
		  {
			  window.location.href='Register.jsp';			  
		  }, 1800);
		  
	});
 

		  
	
</script>
</body>




</html>




