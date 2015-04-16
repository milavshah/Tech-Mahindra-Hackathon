<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
    <!-- All three files required for Kandy  -->
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
    <script src="https://kandy-portal.s3.amazonaws.com/public/javascript/fcs/3.0.1/fcs.js"></script>
    <script src="https://kandy-portal.s3.amazonaws.com/public/javascript/kandy/2.1.0/kandy.js"></script>



 <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Start a Chat</title>
	<!-- BOOTSTRAP STYLES-->
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
     <!-- FONTAWESOME STYLES-->
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
        <!-- CUSTOM STYLES-->
    <link href="assets/css/custom.css" rel="stylesheet" />
     <!-- GOOGLE FONTS-->
   <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
   
    <script language = "JavaScript">
        // this is called when page is done loading to set up (initialize) the KandyAPI.Phone
        setup = function() {

            // initialize KandyAPI.Phone, passing a config JSON object that contains listeners (event callbacks)
            KandyAPI.Phone.setup({
                // respond to Kandy events...
                listeners: {
                    loginsuccess: function () {
                        KandyAPI.Phone.updatePresence(0);
                        changeUIState('LOGGED_IN');
                        loadContacts();
                        loadContacts1();
                        setInterval(getIms, 500);
                    },
                    loginfailed: function () {
                        alert("Login failed");
                    },
                    presencenotification: function (userId, state, description, activity) {
                        // HTML id can't contain @ and jquery doesn't like periods (in id)
                        var id_attrib = '#presence_' + userId.replace(/[.@]/g,'_');
                        $(id_attrib).text(description);

                    }
                }
            });
        };

        login = function() {
        
            KandyAPI.Phone.login($("#domainApiId").val(), $("#loginId").val(), $('#passwd').val());
        };

        logout = function() {
            KandyAPI.Phone.logout(function () {
                changeUIState('LOGGED_OUT');
            });
        };

        loadContacts = function() {
            var contactListForPresence = [];
            KandyAPI.Phone.retrievePersonalAddressBook(
                    function(results) {
                        // clear out the current address book list
                        $("#myContacts div:not(:first)").remove();
                        var div = null;
                        if (results.length == 0) {
                            div = "<div class='noresults'>-- No Contacts --</div>";
                            $('#myContacts').append(div);
                        } else {

                            for (i = 0; i < results.length; i++) {

                                contactListForPresence.push({full_user_id: results[i].contact_user_name});

                                var user_id = null;
                                if (results[i].contact_user_name)
                                    user_id = results[i].contact_user_name;
                                else
                                    user_id = results[i].full_user_id;

                                var id_attrib = user_id.replace(/[.@]/g,'_');

                              /*   $('#myContacts').append(
                                    // HTML id can't contain @ and jquery doesn't like periods (in id)
                                    "<div id='uid_" + id_attrib + "'>" +
                                    "<span class='userid'>" + user_id + "</span>" +
                                    "<span id='presence_" + id_attrib + "' class='presence'></span>" +
                                    "<input class='removeBtn' type='button' value='Remove' " +
                                    " onclick='removeFromContacts(\"" + results[i].contact_id +"\")'>" +
                                    "<input class='lastSeenBtn' type='button' value='Start Chat' " +
                                    " onclick='chat(\"" + user_id +"\")'>" +
                                    "</div>"
                                ); */
                                
                                $('#myContacts').append(
                                        // HTML id can't contain @ and jquery doesn't like periods (in id)
                                        "<div id='uid_" + id_attrib + "'>" +
                                        "<span class='userid'>" + user_id + "</span>" +
                                        "<span id='presence_" + id_attrib + "' class='presence'></span>" +
                                       
                                        "<input class='btn btn-danger square-btn-adjust' type='button' value='Start Chat' " +
                                        " onclick='chat(\"" + user_id +"\")'>" +
                                        "</div>"
                                    );
                            }
                            KandyAPI.Phone.watchPresence(contactListForPresence);
                        }
                    },
                    function() {
                        alert("Error");
                    }
            );
        };

        var userIdToAddToContacts = null;  // need access to this in anonymous function below
        addToContacts = function(userId) {
            userIdToAddToContacts = userId;

            // HTML id can't contain @ and jquery doesn't like periods (in id)
            if ($('#uid_' + userId.replace(/[.@]/g,'_')).length > 0) {
                alert("This person is already in your contact list.")
            } else {
                // get and AddressBook.Entry object for this contact
                KandyAPI.Phone.searchDirectoryByUserName(
                        userId,
                        function (results) {
                            for (var i = 0; i < results.length; ++i) {
                                if (results[i].user_id === userIdToAddToContacts) {
                                    contact = {
                                        contact_email: results[i].user_email,
                                        contact_first_name: results[i].user_first_name,
                                        contact_last_name: results[i].user_last_name,
                                        contact_nickname: results[i].user_first_name,
                                        contact_user_name: results[i].full_user_id
                                    }

                                     KandyAPI.Phone.addToPersonalAddressBook(
                                            contact,
                                            loadContacts, // function to call on success
                                            function (message) { alert("Error: " + message); }
                                    );
                                    break;
                                }
                            }
                        },
                        function (statusCode) {
                            alert("Error getting contact details: " + statusCode )
                        }
                );
            }
        };

        removeFromContacts = function(userName) {
            KandyAPI.Phone.removeFromPersonalAddressBook(userName,
                    loadContacts,  // function to call on success
                    function(){alert("Error");}
            );
        };

        chat = function(userName) {
        	 var element1 = document.getElementById('chat');
             element1.style.display = 'block';
             //alert(userName);
            var element = document.getElementById('imToContact');
            element.value = userName; 
            /* var setter= document.getElementById('sendTo');
            setter.value=userName; */
        };

        searchDirectoryByUserName = function () {
            KandyAPI.Phone.searchDirectoryByUserName(
                    $('#searchUserName').val(),
                    function(results) {
                        // clear out the results, but not the first line (results title)
                        $("#dirSearchResults div:not(:first)").remove();
                        var div = null;
                        if (results.length == 0) {
                            div = "<div class='noresults'>-- No Matches Found --</div>";
                            $('#dirSearchResults').append(div);
                        } else {
                            for (var i = 0; i < results.length; i++) {
                                $('#dirSearchResults').append(
                                                "<div>" +
                                                "<span class='userId'>" + results[i].full_user_id + "</span>" +
                                                "<input type='button' value='Add Contact' onclick='addToContacts(\"" +
                                                results[i].user_id + "\")' />" +
                                                "</div>"
                                );
                            }
                        }
                    },
                    function(val) {alert('Error');}
            );
        };

        myStatusChanged = function(status) {
            KandyAPI.Phone.updatePresence(status);
        };

        changeUIState = function(state) {
            switch (state) {
                case 'LOGGED_OUT':
                	$('#loggedInAs').val('');
                    $("#loginForm").show();
                    $("#topRow").hide();
                    $('#contactsAndDirSearch').hide();
                    $("#dirSearchResults div:not(:first)").remove();
                    $("#myContacts div:not(:first)").remove();
                    $('#messages').empty();
                    $("#imToContact").empty();
                    $("#chat").hide();
                    break;
                case 'LOGGED_IN':
                	$('#loggedInAs').text($('#logInId').val());
                    $("#loginForm").hide();
                    $("#topRow").show();
                    $("#directorySearch").show();
                    $('#contactsAndDirSearch').show();
                    break;
            }
        }
        
        loadContacts1 = function() {
            KandyAPI.Phone.retrievePersonalAddressBook(
                    function(results) {
                        var div = null;
                        if (results.length == 0) {
                            $("#imToContact").empty();
                        } else {
                            for (i = 0; i < results.length; i++) {
                                $('#imToContact').append(
                                        '<option value="' + results[i].contact_user_name  + '">' + results[i].contact_user_name +'</option>'
                                );
                            }
                        }
                    },
                    function() {
                        alert("Error");
                    }
            );
        };

        sendIm = function() {
            var uuid = KandyAPI.Phone.sendIm($('#imToContact').val(), $('#imMessageToSend').val(),
                    function(result) {
                        $('#messages').append('<div>' +
                                '<span class="imUsername">' + "you" + '</span>' +
                                '<span class="imMessage">' + $('#imMessageToSend').val() + '</span>' +
                                '</div>');
                        $('#imMessageToSend').val('');
                    },
                    function(message, status) {
                        alert("IM send failed");
                    }
            );
        };

        getIms = function() {
            KandyAPI.Phone.getIm(
                    function(data) {
                        var i = 0;
                        for (i = 0; i < data.messages.length; ++i) {
                            var msg = data.messages[i];
                            if (msg.messageType == 'chat') {
                                var username = data.messages[i].sender.user_id;
                                var msg = data.messages[i].message.text;

                                $('#messages').append('<div>' +
                                        '<span class="imUsername">' + username + '</span>' +
                                        '<span class="imMessage">' + msg + '</span>' +
                                        '</div>');
                            } else {
                                //alert("received " + msg.messageType + ": ");
                            }
                        }
                    },
                    function() {
                        alert("error receiving IMs");
                    }
            )
        };
    </script>

    <style>
        #loginId{width:200px}
        #passwd{width:170px}
        #myContacts {width:400px;border: 1px solid black}
        #myContactsTitle{text-align:center; text-decoration: underline}
        #directorySearch{margin-top:20px}
        #dirSearchTitle{text-align:center; text-decoration:underline}
        #dirSearchResults {background-color:lightgray; width:400px;border: 1px solid black}
        .userid {width:190px; display:inline-block}
        .presence {width:130px;display:inline-block}
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

<body onload="setup();">

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
          <!--       <nav class="navbar-default navbar-side" role="navigation">
            <div class="sidebar-collapse">
                <ul class="nav" id="main-menu">
				<li class="text-center">
                    <img src="assets/img/find_user.png" class="user-image img-responsive"/>
					</li>
				
					
                    <li>
                        <a class="active-menu"  href="index.html"><i class="fa fa-dashboard fa-3x"></i> Dashboard</a>
                    </li>
                     <li>
                        <a  href="donate.jsp"><i class="fa fa-desktop fa-3x"></i>Donate</a>
                    </li>
                    <li>
                        <a  href="registerVolunteer.jsp"><i class="fa fa-qrcode fa-3x"></i>Register for Volunteering</a>
                    </li>
                    <li>
                        <a   href="kandyCall.jsp"><i class="fa fa-square-o fa-3x"></i> Call Volunteer</a>
                    </li>
                    
                    <li  >
                        <a   href="clientchat.jsp"><i class="fa fa-square-o fa-3x"></i> Chat with Volunteer</a>
                    </li>
                    	
                </ul>
               
            </div>
            
        </nav>  --> 
        <!-- /. NAV SIDE  -->
        
        
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
        
        
        
        <div id="page-wrapper" >
            <div id="page-inner">
                <div class="row">
                    <div class="col-md-12">
                     <h2>Start chat with available volunteers</h2>   
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
                            Chat with one of following volunteers
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-md-6">
                                    

<div id="topRow" style="display:none">
    My status: <select id="myPresence" class="dropDown" onchange="myStatusChanged($('#myPresence').val())" style="height:22px;">
    <option value="0" selected>Available</option>
    <option value="1">Unavailable</option>
    <option value="2">Away</option>
    <option value="3">Out To Lunch</option>
    <option value="4">Busy</option>
    <option value="5">On Vacation</option>
    <option value="6">Be Right Back</option>
</select>
</div>
<div id="loggedIn" style="display:none">
   <span id="loggedInAs"></span>. &nbsp;&nbsp;&nbsp;&nbsp;
    <input id="logoutBtn" type="button" value="Log Out" onclick="logout()" />
</div>
<form id="loginForm" style="display: none">
    Project API Key: <input id="domainApiId" type="text" style="width:200px;margin-bottom:1px;" value="DAK48ccfbb3738c46eb80ad1e7e0153e7b7"/><br/>
    Username: <input id="loginId" type="text" value="" style="width:200px;margin:0 0 1px 64px;" /><br/>
    Password: <input id="passwd" type="password" value="" style="width:200px;margin-left:41px;"/><br/>
    <input id="loginBtn" type="button" value="Log in" onclick="login();return false;" style="width:90px;height:23px;margin:5px "/>
</form>

<div id="contactsAndDirSearch" style="display: none">
<br />
    <div id="myContacts">
        <div id="myContactsTitle">My Contacts</div>
    </div>

    <!-- <form id="directorySearch" style="display:none" onsubmit="return false;">
        User: <input id="searchUserName" type="text" value=""/>
        <input type="submit" value="Search" onclick="searchDirectoryByUserName();return false;" style="width:90px;height:23px;"/>
        (blank enter for wildcard)      
    </form>

    <div id="dirSearchResults">
        <div id="dirSearchTitle">Directory Search Results</div>
    </div> -->
</div>
</br>
</br>
<div id="chat">
    <form id="imForm" onsubmit="return false;">
        <div>
            Contact: <select id="imToContact"/></select>
            <!-- Contact: <input type="text" id ="sendTo" value=""/>  -->
        </div>
        <br />
        <div>
            Message: <textarea id= "imMessageToSend" type="text" ></textarea>
        </div>
		<br />
        <input type="submit" class="btn btn-danger square-btn-adjust" onclick="sendIm();return false;" value="Send" align="center"/>  <br/>
    </form>
    <br />
    <div id="messages" style="width:500px"></div>
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


//document.getElementById('loginBtn').click();

document.getElementById('loginId').value=document.getElementById('1').value;
document.getElementById('passwd').value=document.getElementById('2').value;
setTimeout(
		  function() 
		  {
			  $("#loginBtn").click();  //do something special			  
		  }, 500);
</script>

</body>
</html>
