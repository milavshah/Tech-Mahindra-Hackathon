<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
    <title>Multiple Calls</title>
    <!-- All three files required for Kandy  -->
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
    <script src="https://kandy-portal.s3.amazonaws.com/public/javascript/fcs/3.0.1/fcs.js"></script>
    <script src="https://kandy-portal.s3.amazonaws.com/public/javascript/kandy/2.1.0/kandy.js"></script>
    
    
	<meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Answer Multi Video Call</title>
	<!-- BOOTSTRAP STYLES-->
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
     <!-- FONTAWESOME STYLES-->
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
        <!-- CUSTOM STYLES-->
    <link href="assets/css/custom.css" rel="stylesheet" />
     <!-- GOOGLE FONTS-->
   <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />

    <script language="JavaScript">
        // we need to save the callId so we can interact with the call later.
        calls = [];

        setupAudio = function() {
            ringInAudioSrcs = [
                {src: 'http://mobilering.net/uploads/ringtones/1337474279_game_of_thrones.mp3', type: 'audio/mp3'},
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

        // called when page is done loading to initialize KandyAPI
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
                        $('#loggedIn').show();
                        $('#logInForm').hide();
                        $('#loggedInAs').text($('#logInId').val());
                    },
                    loginfailed: function () {
                        alert("Login failed");
                    },
                    callincoming: function (call, isAnonymous) {
                        audio.ringIn.play();
                        calls[call.getId()] = call;

                        var callerName = call.callerName;

                        var html = '<div class="callContainer" data-call-id="' + call.getId() + '" style="border:solid 1px black;">Incoming Call from ' + callerName;
                        html += '&nbsp;&nbsp;<input class="answerBtn" data-call-id="' + call.getId() + '" type="button" value="Answer" onclick="answerVideoCall(\'' + call.getId() + '\')" style="width:90px;height:23px;"/>';
                        html += '<input class="holdBtn" data-call-id="' + call.getId() + '" type="button" value="Hold" style="display:none;width:90px;height:23px;"/>';
                        html += '<input class="endBtn" data-call-id="' + call.getId() + '" type="button" value="End" style="display:none;width:90px;height:23px;"/>';
                        html += '</div>';

                        $(html).appendTo($('#someonesCalling'));
                    },
                    // when an incoming call is connected
                    callanswered: function (call, isAnonymous) {
                        audio.ringIn.pause();
                        var callId = call.getId();

                        for (key_name in calls){
                            if(key_name != callId){
                                holdCall(key_name);
                            }
                        }
                        var answerBtn = $('.answerBtn[data-call-id="'+callId+'"]');
                        answerBtn.hide();

                        var holdBtn = $('.holdBtn[data-call-id="'+callId+'"]');
                        holdBtn.bind('click', function(){
                            holdCall(callId);
                        });
                        holdBtn.show();

                        var endBtn = $('.endBtn[data-call-id="'+callId+'"]');
                        endBtn.bind('click', function(){
                            endCall(callId);
                        });
                        endBtn.show();
                    },
                    callended: function (call) {
                        audio.ringIn.pause();

                        $('.callContainer[data-call-id="'+call.getId()+'"]').remove();
                        delete calls[call.getId()];
                    }
                }
            });
        };

        login = function() {
           // KandyAPI.Phone.login("DAK48ccfbb3738c46eb80ad1e7e0153e7b7", "kartik", "Kamesh@123");
        	KandyAPI.Phone.login($("#domainApiId").val(), $("#loginId").val(), $('#passwd').val());
        };

        logout = function () {
            for (key_name in calls){
                endCall(key_name);
            }

            KandyAPI.Phone.logout(function () {
                $('#loggedIn').hide();
                $('#logInForm').show();
            });
        };

        answerVideoCall = function (callId) {
            KandyAPI.Phone.answerCall(callId, true);
        };

        makeCall = function () {
            KandyAPI.Phone.makeCall($('#callOutUserId').val(), true);
        };

        holdCall = function(callId){
            var holdBtn = $('.holdBtn[data-call-id="'+callId+'"]');

            holdBtn.val('Unhold');
            holdBtn.unbind('click').bind('click', function(){
                unHoldCall(callId);
            });

            KandyAPI.Phone.holdCall(callId);
        };

        unHoldCall = function(callId){
            var holdBtn = $('.holdBtn[data-call-id="'+callId+'"]');

            for (key_name in calls){
                if(key_name != callId){
                    holdCall(key_name);
                }
            }

            holdBtn.val('Hold');
            holdBtn.unbind('click').bind('click', function(){
                holdCall(callId);
            });

            KandyAPI.Phone.unHoldCall(callId);
        };

        endCall = function (callId) {
            KandyAPI.Phone.endCall(callId);
        };

    </script>

    <style>
        .callContainer {padding: 5px;}
        #videos {width:695px}
        #theirVideo {background-color:darkslategray;width:334px;height:250px;display:inline-block;}
        #myVideo {background-color:darkslategray;width:100px;height:100px;display:inline-block;margin-bottom: 120px}
        #meLabel {width:340px;text-align:right;display:inline-block}
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

<div id="loggedIn" style="display:none">
    <%-- <span id="loggedInAs"></span>.
    <input id="logoutBtn" type="button" value="Log Out" onclick="logout();return false;"
           style="width:90px;height:23px;"/> --%>
    <hr>
    <br/>

    <div id="someonesCalling">
    </div>

    <br/>
    <br/>

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

<!-- <h2>Quick Start Sample App: Multiple Calls</h2>
This sample application demonstrates the code for answering multiple video calls with Kandy.
<br/>
<hr>
<br/>

<form id="logInForm">
    Project API Key: <input id="domainApiId" type="text" style="width:200px;margin-bottom:1px;" value=""/><br/>
    Username: <input id="logInId" type="text" style="width:200px;margin:0 0 1px 64px;" value=""  placeholder="username (e.g. user1)"/><br/>
    Password: <input id="passwd" type="password" style="width:200px;margin-left:41px;" value=""/><br/>
    <input id="loginBtn" type="button" value="Log in" onclick="login();return false;"
           style="width:90px;height:23px;margin:5px 0 5px 110px;"/>
</form>

<div id="loggedIn" style="display:none">
    <span id="loggedInAs"></span>.
    <input id="logoutBtn" type="button" value="Log Out" onclick="logout();return false;"
           style="width:90px;height:23px;"/>
    <hr>
    <br/>

    <div id="someonesCalling">
    </div>

    <br/>
    <br/>

    <div id="videos">
        Them:<span id="meLabel">Me:</span>
        <span id="theirVideo" style="display:inline-block"></span>
        <span id="myVideo"></span>
    </div> -->
</div>
</body>
</html>
