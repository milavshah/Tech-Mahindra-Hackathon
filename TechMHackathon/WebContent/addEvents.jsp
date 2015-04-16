<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
      <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Events</title>
	<!-- BOOTSTRAP STYLES-->
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
     <!-- FONTAWESOME STYLES-->
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
        <!-- CUSTOM STYLES-->
    <link href="assets/css/custom.css" rel="stylesheet" />
     <!-- GOOGLE FONTS-->
   <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
</head>
<body>
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
               <!--  <nav class="navbar-default navbar-side" role="navigation">
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
            
        </nav>   -->
        
        
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
                     <h2>Add an event</h2>   
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
                            Enter Event Details
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-md-6">
                                    
                                    <s:form action="addevent.action" method="post">
                                        <div class="form-group">
                                            <label>Event Title</label>
                                    <input class="form-control" name="title" type="text"/>
                                        </div>
                                        <div class="form-group">
                                            <label>Event Description</label>
                                    <input class="form-control" name="desc" type="text"/>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label>Event Location</label>
                                    <input class="form-control" name="location" type="text"/>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label>Phone number of contact person</label>
                                    <input class="form-control" name="contact" type="text"/>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label>Event Date</label>
                                    <input class="form-control" name="date" type="text"/>
                                        </div>
                                        
                                       <!--  <button type="submit" class="btn btn-default">Submit Button</button>
                                        <button type="reset" class="btn btn-primary">Reset Button</button> -->
                                        <s:submit cssClass="btn btn-success " method="execute" key="label.donor.submit" align="center" />
                                        
									</s:form>
                                  
                                    
                                  
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
         <!-- /. PAGE WRAPPER  -->
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
