<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="s" uri="/struts-tags"%>
 <html>
 <head>
     <title>Make a Video Call</title>
     <!-- All three files required for Kandy  -->
     <script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
     <script src="https://kandy-portal.s3.amazonaws.com/public/javascript/fcs/3.0.1/fcs.js"></script>
     <script src="https://kandy-portal.s3.amazonaws.com/public/javascript/kandy/2.1.0/kandy.js"></script>



	<meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Free Bootstrap Admin Template : Binary Admin</title>
	<!-- BOOTSTRAP STYLES-->
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
     <!-- FONTAWESOME STYLES-->
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
        <!-- CUSTOM STYLES-->
    <link href="assets/css/custom.css" rel="stylesheet" />
     <!-- GOOGLE FONTS-->
   <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />

     <script language = "JavaScript">
         // we need to save the callId so we can interact with the call later.
         var callId = null;
         var audio = null;

         setupAudio = function() {
             ringInAudioSrcs = [
                 {src: 'https://kandy-portal.s3.amazonaws.com/public/sounds/ringin.mp3', type: 'audio/mp3'},
                 {src: 'https://kandy-portal.s3.amazonaws.com/public/sounds/ringin.ogg', type: 'audio/ogg'}
             ];
             ringOutAudioSrcs = [
                 {src: 'https://kandy-portal.s3.amazonaws.com/public/sounds/ringout.mp3', type: 'audio/mp3'},
                 {src: 'https://kandy-portal.s3.amazonaws.com/public/sounds/ringout.ogg', type: 'audio/ogg'}
             ];
             msgInAudioSrcs = [
                 {src: 'https://kandy-portal.s3.amazonaws.com/public/sounds/msgin.mp3', type: 'audio/mp3'},
                 {src: 'https://kandy-portal.s3.amazonaws.com/public/sounds/msgin.ogg', type: 'audio/ogg'}
             ];

             audio = {
                 ringIn: $('<audio/>', {loop: 'loop', id: 'ringInAudio'})[0],
                 ringOut: $('<audio/>', {loop: 'loop', id: 'ringOutAudio'})[0],
                 msgIn: $('<audio/>', {id: 'msgInAudio'})[0]
             };

             // setup Msg sources
             for (var i = 0; i < msgInAudioSrcs.length; i++) {
                 audio.msgIn.appendChild($('<source/>', msgInAudioSrcs[i])[0]);
             }

             // setup RingIn sources
             for (var i = 0; i < ringInAudioSrcs.length; i++) {
                 audio.ringIn.appendChild($('<source/>', ringInAudioSrcs[i])[0]);
             }

             // setup RingOut sources
             for (var i = 0; i < ringOutAudioSrcs.length; i++) {
                 audio.ringOut.appendChild($('<source/>', ringOutAudioSrcs[i])[0]);
             }
         };

         // this is called when page is done loading to set up (initialize) the KandyAPI.Phone
         setup = function() {
             setupAudio();

             // initialize KandyAPI.Phone, passing a config JSON object that contains listeners (event callbacks)
             KandyAPI.Phone.setup({
                 remoteVideoContainer: $('#theirVideo')[0],
                 localVideoContainer: $('#myVideo')[0],

                 // respond to Kandy events...
                 listeners: {
                     loginsuccess: function () {
                         KandyAPI.Phone.updatePresence(0);
                         changeUIState('READY_FOR_CALLING');
                     },
                     loginfailed: function () {
                         alert("Login failed");
                     },
                     callinitiated: function(call) {
                         audio.ringOut.play();
                         callId = call.getId();
                     },
                     callinitiatefailed: function(call) {

                     },
                     oncall: function (call) {
                         audio.ringOut.pause();
                         changeUIState("ON_CALL");
                     },
                     callended: function(call) {
                         audio.ringOut.pause();
                         callId = null;
                         $('#theirVideo').empty();
                         changeUIState('READY_FOR_CALLING');
                     }
                 }
             });
         };

         login = function() {
        	 KandyAPI.Phone.login($("#domainApiId").val(), $("#loginId").val(), $('#passwd').val());
             //KandyAPI.Phone.login("DAK48ccfbb3738c46eb80ad1e7e0153e7b7", "kaushal", "Kamesh@123");
         };

         logout = function() {
             KandyAPI.Phone.logout(function () {
                 changeUIState('LOGGED_OUT');
             });
         };

         makeCall = function() {
             KandyAPI.getLastSeen([$('#callOutUserId').val()],
                 function(results) {
                     //alert("That user last seen: " + JSON.stringify(results));
                 },
                 function() {

                 }
             );
             KandyAPI.Phone.makeCall($('#callOutUserId').val(), true);
             changeUIState('CALLING');
         };

         endCall = function(call) {
             KandyAPI.Phone.endCall(callId);
             changeUIState('READY_FOR_CALLING');
         };

         changeUIState = function(state) {
             switch (state) {
                 case 'LOGGED_OUT':
                     $('#logInForm').show();
                     $('#loggedIn').hide();
                     $("#callOut").hide();
                     $("#calling").hide();
                     $('#onCall').hide();
                     break;
                 case 'READY_FOR_CALLING':
                     $('#logInForm').hide();
                     $('#loggedIn').show();
                     $('#callOut').show();
                     $('#calling').hide();
                     $('#onCall').hide();
                     $('#loggedInAs').text($('#logInId').val());
                     break;
                 case 'CALLING':
                     $('#logInForm').hide();
                     $('#callOut').hide();
                     $('#calling').show();
                     $('#onCall').hide();
                     break;
                 case 'ON_CALL':
                     $('#logInForm').hide();
                     $('#callOut').hide();
                     $('#calling').hide();
                     $('#onCall').show();
                     break;
             }
         };

     </script>

     <style>
         #videos {width:675px}
         #theirVideo {background-color:darkslategray;width:334px;height:250px;display:inline-block;}
         #myVideo {background-color:darkslategray;width:100px;height:100px;display:inline-block;margin-bottom: 120px}
         #meLabel {width:340px;text-align:right;display:inline-block}
         #callOutUserId {width: 160px}
     </style>

 </head>


 <body onload="setup();" >
 

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
                     <h2>Start video conference with available volunteers</h2>   
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
                            Video Conference
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-md-6">
                                    
<!-- <div id="loggedIn" style="display:none">
     
     <input id="logoutBtn" type="button" value="Log Out" onclick="logout();return false;" style="width:90px;height:23px;"/>
 </div> -->
 
 <!-- <form id="logInForm">
     Project API Key: <input id="domainApiId" type="text" style="width:200px;margin-bottom:1px;" value=""/><br/>
     Username: <input id="logInId" type="text" style="width:200px;margin:0 0 1px 64px;" value="" placeholder="username (e.g. user1)"/><br/>
     Password: <input id="passwd" type="password" style="width:200px;margin-left:41px;" value=""/><br/>
     <input id="loginBtn" type="button" value="Log in" onclick="login();return false;" style="width:90px;height:23px;margin:5px 0px 5px 110px;"/>
 </form> -->
 <form id="loginForm" style="display: none">
    Project API Key: <input id="domainApiId" type="text" style="width:200px;margin-bottom:1px;" value="DAK48ccfbb3738c46eb80ad1e7e0153e7b7"/><br/>
    Username: <input id="loginId" type="text" value="" style="width:200px;margin:0 0 1px 64px;" /><br/>
    Password: <input id="passwd" type="password" value="" style="width:200px;margin-left:41px;"/><br/>
    <input id="loginBtn" type="button" value="Log in" onclick="login();return false;" style="width:90px;height:23px;margin:5px "/>
</form>

<div id="callOut" style="display:none" >
     <br/>
     User to call: <input id="callOutUserId" type="text" value="" placeholder="username@domain.com"/>
     <input id="callBtn" type="button" value="Call" onclick="makeCall()" style="width:90px;height:23px;"/><br/><br/>
 </div>

    <span id="calling" style="display:none">
        Calling...<input type="button" value="End Call" onclick="endCall()" style="width:90px;height:23px;"/>
    </span>

    <span id="onCall" style="display:none">
        You're connected! <input type="button" value="End Call" onclick="endCall()" style="width:90px;height:23px;"/>
    </span>
</br>
</br>

 <div id="videos">
     They:<span id="meLabel">You:</span>
     <span id="theirVideo" style="display:inline-block"></span>
     <span id="myVideo"></span>
 </div>
                               
                                    <br />

                                 
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






 <script src="assets/js/jquery-1.10.2.js"></script>
      <!-- BOOTSTRAP SCRIPTS -->
    <script src="assets/js/bootstrap.min.js"></script>
    <!-- METISMENU SCRIPTS -->
    <script src="assets/js/jquery.metisMenu.js"></script>
      <!-- CUSTOM SCRIPTS -->
    <script src="assets/js/custom.js"></script>
    
    
    
    <script type="text/javascript">


document.getElementById('loginId').value=document.getElementById('1').value;
document.getElementById('passwd').value=document.getElementById('2').value;
setTimeout(
		  function() 
		  {
			  $("#loginBtn").click();  //do something special			  
		  }, 800);
</script>
</body>
</html>
