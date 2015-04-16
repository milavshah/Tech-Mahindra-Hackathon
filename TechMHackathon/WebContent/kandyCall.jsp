<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
      <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Make a Call</title>
	<!-- BOOTSTRAP STYLES-->
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
     <!-- FONTAWESOME STYLES-->
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
        <!-- CUSTOM STYLES-->
    <link href="assets/css/custom.css" rel="stylesheet" />
     <!-- GOOGLE FONTS-->
   <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
    <script src="https://kandy-portal.s3.amazonaws.com/public/javascript/fcs/3.0.1/fcs.js"></script>
    <script src="https://kandy-portal.s3.amazonaws.com/public/javascript/kandy/2.1.0/kandy.js"></script>

    <script language = "JavaScript">
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
                        audio.ringOut.pause();
                        callId = null;
                        changeUIState('READY_FOR_CALLING');
                        alert("Call failed to start");
                    },
                    oncall: function (call) {
                        audio.ringOut.pause();
                        changeUIState("ON_CALL");
                    },
                    callended: function(call) {
                        audio.ringOut.pause();
                        callId = null;
                        changeUIState('READY_FOR_CALLING');
                    }
                }
            });
        };

        login = function() {
            KandyAPI.Phone.login("DAK48ccfbb3738c46eb80ad1e7e0153e7b7", "kaushal", "Kamesh@123");
        };

        logout = function() {
            if (callId) {
                endCall();
            }
            KandyAPI.Phone.logout(function () {
                changeUIState('LOGGED_OUT');
            });
        };

        makeCall = function() {
            KandyAPI.Phone.makePSTNCall($('#callOutUserId').val(), $('#callerId').val());
            changeUIState('CALLING');
        };

        sendTones = function() {
            KandyAPI.Phone.sendDTMF(callId,  $('#tones').val());
        };

        endCall = function() {
            KandyAPI.Phone.endCall(callId);
            changeUIState('READY_FOR_CALLING');
        };

        changeUIState = function(state) {
            switch (state) {
                case 'LOGGED_OUT':
                    $("#loginForm").show();
                    $("#logOut").hide();
                    $("#callOut").hide();
                    $("#calling").hide();
                    $('#onCall').hide();
                    break;
                case 'READY_FOR_CALLING':
                    $("#loginForm").hide();
                    $("#logOut").show();
                    $('#callOut').show();
                    $('#calling').hide();
                    $('#onCall').hide();
                    $('#currentUser').text($('#loginId').val());
                    break;
                case 'CALLING':
                    $("#loginForm").hide();
                    $("#logOut").hide();
                    $('#callOut').hide();
                    $('#calling').show();
                    $('#onCall').hide();
                    break;
                case 'ON_CALL':
                    $("#loginForm").hide();
                    $("#logOut").hide();
                    $('#callOut').hide();
                    $('#calling').hide();
                    $('#onCall').show();
                    break;
            }
        }
    </script>
</head>
<body onload="setup();login();">
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
    <%} %></div>
        </nav>   
           <!-- /. NAV TOP  -->
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
                     <h2>Make a Voice Call</h2>   
                        <h5>Welcome <%=(String)session.getAttribute("username")%> , Love to see you back. </h5>
                     <div id="callOut" style="display:none" >
    <br/>User to call:
    <input id="callOutUserId" type="text" value="14694529289" placeholder="e.g. 14075550100"/> &nbsp;
    <input id="callBtn" type="button" class="btn btn-danger square-btn-adjust" value="Call" onclick="makeCall()" style="width:90px;height:23px;"/><br/>
    </div>
<div id="calling" style="display:none">
    Calling...
    <input type="button" value="End Call" onclick="endCall()" style="width:90px;height:23px;"/>
</div>
<div id="onCall" style="display:none">
    You're connected!<br/><br/>

    <!-- Tones to Send:
    <input id="tones" type="text" value="" placeholder="e.g. 1 or 1# or 332*2#"/> &nbsp;
    <input id="sendTonesBtn" type="button" value="Send" onclick="sendTones()" style="width:90px;height:23px;"/><br/>
    <br/> -->
    <input type="button" value="End Call" onclick="endCall()" style="width:90px;height:23px;"/>

</div>   
                       
                    </div>
                </div>
                 <!-- /. ROW  -->
                 <hr />
               
    </div>
             <!-- /. PAGE INNER  -->
            </div>
         <!-- /. PAGE WRAPPER  -->
        </div>
     <!-- /. WRAPPER  -->
    <!-- SCRIPTS -AT THE BOTOM TO REDUCE THE LOAD TIME-->
    <!-- JQUERY SCRIPTS -->
    <script src="assets/js/jquery-1.10.2.js"></script>
      <!-- BOOTSTRAP SCRIPTS -->
    <script src="assets/js/bootstrap.min.js"></script>
    <!-- METISMENU SCRIPTS -->
    <script src="assets/js/jquery.metisMenu.js"></script>
      <!-- CUSTOM SCRIPTS -->
    <script src="assets/js/custom.js"></script>
    
   
</body>
</html>
