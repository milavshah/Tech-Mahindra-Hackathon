<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<title>Cobrowsing User</title>
 <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Register yourself</title>
	<!-- BOOTSTRAP STYLES-->
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
     <!-- FONTAWESOME STYLES-->
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
        <!-- CUSTOM STYLES-->
    <link href="assets/css/custom.css" rel="stylesheet" />
     <!-- GOOGLE FONTS-->
   <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />

<!-- All four files required for Kandy Cobrowsing -->
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<script src="https://kandy-portal.s3.amazonaws.com/public/javascript/fcs/3.0.1/fcs.js"></script>
<script src="https://kandy-portal.s3.amazonaws.com/public/javascript/kandy/2.1.0/kandy.js"></script>
<script src="https://kandy-portal.s3.amazonaws.com/public/javascript/cobrowse/1.0.1/kandy.cobrowse.min.js"></script>

<script language = "JavaScript">
// called when page is done loading to set up (initialize) the KandyAPI.Phone
var sessions = {};
var currentUser;
var currentSession;

loginAnonymous = function() {
    if ($("#domainApiId").val() === '') {
        alert("Please enter Domain API Key.")
    } else {
        KandyAPI.loginAnonymous(
            $("#domainApiId").val(),
            function (results) {
                changeUIState('NO_SESSION');
                currentUser = results.full_user_id;
                $('#user_id').text(currentUser);
            },
            function (msg, code) {
                alert("Error loggin anonymous user(" + code + "): " + msg);
            }
        );
    }
};

loginUser = function() {
    KandyAPI.login(
        $("#domainApiId").val(),
        $("#loginUserName").val(),
        $("#loginPassword").val(),
        function(results) {
            changeUIState('NO_SESSION');
            currentUser = results.full_user_id;
            $('#user_id').text(currentUser);
        },
        function(msg, code) {
            alert("Error loggin in:(" + code + "): " + msg);
        }
    );
};

getOpenSessionsCreatedByUser = function() {
    KandyAPI.Session.getOpenSessionsCreatedByUser(
        function(result) {
            processSessionList(result.sessions);
        },
        function(msg, code) {
            alert("Error getting session info(" + code + "): " + msg);
        }
    );
};

processSessionList = function(sessionList, alertWhenNone) {
    $("#sessions").empty();

    if (sessionList.length > 0) {
        var i=0;
        for (i=0; i < sessionList.length; ++i) {
            sessions[sessionList[i].session_id] = sessionList[i];
            $("#sessions").append('<option value="'+ sessionList[i].session_id +'">' + sessionList[i].session_id +'</option>');
        }
        loadSessionDetails();
    } else {
        changeUIState('NO_SESSION');
        sessions = [];
        clearSessionDetails();
        if (alertWhenNone === undefined || alertWhenNone === null || alertWhenNone)
            alert('No sessions.')
    }

}

onSessionUserJoinRequest = function(notification) {
    changeUIState('SESSION_PARTICIPANT');
    
    //Auto Approve users who wants to join
    KandyAPI.Session.acceptJoinRequest(notification.session_id, notification.full_user_id);
};

var listeners = {
    'onUserJoinRequest': onSessionUserJoinRequest
};

createSession = function() {
    KandyAPI.Session.create(
        { //config
            session_type: $("#create_session_type").val(),
            user_first_name: $("#create_user_first_name").val(),
            user_last_name: $("#create_user_last_name").val()
        },
        function(result) {  // success
            getOpenSessionsCreatedByUser();
            alert("Session created.");
            KandyAPI.Session.activate(result.session_id);
        },
        function(msg, code) {  // failure
            alert("Error creating session (" + code + "): " + msg);
        }
    );
};

deleteSession = function() {
    KandyAPI.Session.terminate(
        currentSession.session_id,
        function() {
            getOpenSessionsCreatedByUser(false);
        },
        function(msg, code) {
            alert("Error deleting session (" + code + "): " + msg);
        }
    );
};

loadSessionDetails = function() {
    currentSession = sessions[$("#sessions").val()];
    $('#session_type').text(currentSession.session_type);
    $('#session_status').text(currentSession.session_status);

    KandyAPI.Session.setListeners(currentSession.session_id, listeners);
    
    changeUIState('SESSION_ADMIN');

};

startCoBrowseUser = function() {
    changeUIState('COBROWSING_STARTED');
    KandyAPI.CoBrowse.startBrowsingUser(currentSession.session_id);
};

stopCoBrowseUser = function() {
    changeUIState('COBROWSING_STOPPED');
    KandyAPI.CoBrowse.stopBrowsingUser();
}

changeUIState = function(state) {
    switch (state) {
        case 'LOGGED_OUT':
            $("#loginForm").show();
            $("#userDetails").hide();
            $('#loggedIn').hide();
            break;
        case 'NO_SESSION':
            $("#loginForm").hide();
            $("#userDetails").show();
            $('#loggedIn').show();
            $("#sessionsLoaded").hide();
            $("#noSessionsLoaded").show();
            $("#createSession").show();
            $(".admin").hide();
            $(".participant").hide();
            $('.nonparticipant').hide();
            break;
        case 'SESSION_ADMIN':
            $("#sessionsLoaded").show();
            $("#noSessionsLoaded").hide();
            $("#session_role").text("Administrator");
            $("#createSession").hide();
            $(".participant").hide();
            $('.nonparticipant').hide();
            $(".admin").show();
            break;
        case 'SESSION_PARTICIPANT':
            $("#sessionsLoaded").show();
            $("#noSessionsLoaded").hide();
            $("#session_role").text("Participant");
            $("#createSession").hide();
            $(".admin").hide();
            $('.nonparticipant').hide();
            $(".participant").show();
            break;
        case 'SESSION_NONPARTICIPANT':
            $("#sessionsLoaded").show();
            $("#noSessionsLoaded").hide();
            $("#session_role").text("Non-participant");
            $("#createSession").show();
            $(".admin").hide();
            $(".participant").hide();
            $('.nonparticipant').show();
            break;
        case 'COBROWSING_STARTED':
            $("#startCoBrowse").hide();
            $("#stopCoBrowse").show();
            break;
        case 'COBROWSING_STOPPED':
            $("#startCoBrowse").show();
            $("#stopCoBrowse").hide();
            break;
    }
};

clearSessionDetails = function() {
    $('#session_type').text("");
    $('#session_status').text("");
};

$("#sessionSelect" ).change(function() {
    loadSessionDetails();
});


</script>
</head>

<body>





<input type="hidden" value="<%= (String)session.getAttribute("username") %>" id='1'>
<input type="hidden" value="<%= (String)session.getAttribute("password") %>" id='2'>

<div id="wrapper">
        <nav class="navbar navbar-default navbar-cls-top " role="navigation" style="margin-bottom: 0">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="index.html">Tech Mahindra</a> 
            </div>
   <div style="color: white;
float: right;
font-size: 14px;"> <%String s=(String)session.getAttribute("login");  
if(s!=null && !s.equals("")){  %>
    <h5>Howdy, <%=(String)session.getAttribute("username")%>...!</h5>
    <a href="<s:url action="logout"/>">Click here to logout</a>
    <%}else{ %>
    
    <script type="text/javascript">
    window.location.href='/TechMHackathon';
    </script>
    <%} %></div></nav>   
           <!-- /. NAV TOP  -->
                <nav class="navbar-default navbar-side" role="navigation">
         
            
        </nav>
        <%
           String type=(String)session.getAttribute("usertype");
           if(type.equalsIgnoreCase("1")){%>
               <%@include file="Left_panle.jsp" %>
               <%}
           else if (type.equalsIgnoreCase("2")){
                %>
                
                <%@include file="left_panel_student.jsp" %>
                <%}
           else{
           %>
                <%@include file="left_panel_admin.jsp" %>
                <%} %>
        <!-- /. NAV SIDE  -->
        <div id="page-wrapper" >
            <div id="page-inner">
                <div class="row">
                    <div class="col-md-12">
                     <h2>Start CoBrowsing</h2>   
                        <h5>Welcome <%=(String)session.getAttribute("username")%> , Love to see you back. </h5>
                       
                    </div>
                </div>
                 <!-- /. ROW  -->
                 <hr />
               <div class="row">
                <div class="col-md-12">
                    <!-- Form Elements -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            CoBrowsing
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-md-6">
                                    
<!-- <div id="loggedIn" style="display:none">
     
     <input id="logoutBtn" type="button" value="Log Out" onclick="logout();return false;" style="width:90px;height:23px;"/>
 </div> -->
 
 <form id="loginForm" style="display: none">
    Project API Key: <input id="domainApiId" type="text" value="DAK48ccfbb3738c46eb80ad1e7e0153e7b7"/>
    <br/>
    UserName: <input id="loginUserName" type="text" value=""/>
    <br/>
    Password: <input id="loginPassword" type="password" value=""/>
    <br/>
    <br/>
    <input id="userloginBtn" type="button" value="User Log in" onclick="loginUser();return false;"/>
    <!-- <input id="annonloginBtn" type="button" value="AnonymousLog in" onclick="loginAnonymous();return false;"/> -->
</form>
 <!-- <form id="loginForm" style="display: none">
    Project API Key: <input id="domainApiId" type="text" style="width:200px;margin-bottom:1px;" value="DAK48ccfbb3738c46eb80ad1e7e0153e7b7"/><br/>
    Username: <input id="loginId" type="text" value="" style="width:200px;margin:0 0 1px 64px;" /><br/>
    Password: <input id="passwd" type="password" value="" style="width:200px;margin-left:41px;"/><br/>
    <input id="loginBtn" type="button" value="Log in" onclick="login();return false;" style="width:90px;height:23px;margin:5px "/>
</form> -->

<div id="loggedIn" style="display:none">

    <div id="userDetails">
        <span style="font-weight:bold">User ID: </span><span id="user_id"></span><br/>
    </div>
    <br/>
    <hr style="clear:both"/>
    <div style="font-weight:bold">Session Loading & Selection:</div>
    <br/>
    <button class="btn btn-danger square-btn-adjust" onclick="getOpenSessionsCreatedByUser()">Get My Open Sessions</button>
    <br/><br/>
    <div id="noSessionsLoaded">
        No sessions loaded.<br/>
        <br/>
    </div>
    <div id="sessionsLoaded" style="display:none;margin-left:20px">
        <div id="sessionSelect">
            Select Session: <select id="sessions" style="" onchange="loadSessionDetails()"></select>
        </div>
        <div id="sessionDetails" style="margin-left:110px">
            Type: <span id="session_type"></span><br/>
            Status: <span id="session_status"></span><br/>
            <br/>
        </div>
        <span class="admin">
            <button class="btn btn-danger square-btn-adjust" onclick="deleteSession()">Delete Selected Session</button>
        </span>
        <div class="participant admin">
            <div id="startCoBrowse">
                <button class="btn btn-danger square-btn-adjust" onclick="startCoBrowseUser()">Start Co-Browsing</button>
            </div>
            <div id="stopCoBrowse" style="display: none;">
                <button class="btn btn-danger square-btn-adjust" onclick="stopCoBrowseUser()">Stop Co-Browsing</button>
            </div>
        </div>
    </div>
    <hr style="clear:both"/>
    
    <div id="createSession">
        <div style="font-weight:bold;">Session Creation:</div>
        <div style="float:left">
            Session Type
            <input type="text" id="create_session_type" value="support" />
        </div>
        <div style="margin-left:20px;float:left">
            User First Name
            <input type="text" id="create_user_first_name" value="User" />
            <br/>
            User Last Name
            <input type="text" id="create_user_last_name" value="One" />
        </div>
        <div style="clear:both">
            <button class="btn btn-danger square-btn-adjust" onclick="createSession()">Create Session</button>
        </div>
    </div>
</div>                                                                
                                </div>
                            </div>
                        </div>
                    </div>
                     <!-- End Form Elements -->
                </div>
            </div>
    </div>
             <!-- /. PAGE INNER  -->
            </div>
            
            
        
<!-- SCRIPTS -AT THE BOTOM TO REDUCE THE LOAD TIME-->
    <!-- JQUERY SCRIPTS -->
    <script src="assets/js/jquery-1.10.2.js"></script>
      <!-- BOOTSTRAP SCRIPTS -->
    <script src="assets/js/bootstrap.min.js"></script>
    <!-- METISMENU SCRIPTS -->
    <script src="assets/js/jquery.metisMenu.js"></script>
      <!-- CUSTOM SCRIPTS -->
    <script src="assets/js/custom.js"></script>
    
    <script type="text/javascript">


document.getElementById('loginUserName').value=document.getElementById('1').value;
document.getElementById('loginPassword').value=document.getElementById('2').value;
setTimeout(
		  function() 
		  {
			  $("#userloginBtn").click();  //do something special			  
		  }, 800);
</script>
</body>
</html>