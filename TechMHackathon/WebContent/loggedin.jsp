<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
      <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Welcome</title>
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
                       <h2>Upcoming Events</h2>  
                      
                        
                        
                        <h4>Tech Mahindra i5 Hackathon; UT-Dallas; 02/06/2015 - 02/08/2015</h4>
                        <h4>Charity Football match for Girls Welfare; AT & T Stadium; 02/14/2015</h4>
                        <h4>Celebrity Fundraising event; CottonBowl Stadium; 02/15/2015</h4>
                    </div>
                </div>
                 <!-- /. ROW  -->
                 <hr />	 <script type="text/javascript">
  window.onload = function () {
    var chart= new CanvasJS.Chart("chartContainer", {
      
      title:{
        text: "Monthly revenue of 2014 in $"
      },

      data: [
      {
       type: "stepArea",  
      
       dataPoints: [

       { x: new Date(2014,02), y: 12000 },
       { x: new Date(2014,03), y: 18500 },
       { x: new Date(2014,04), y: 15000 },
       { x: new Date(2014,05), y: 11500 },
       { x: new Date(2014,06), y: 16750 },
       { x: new Date(2014,07), y: 19300 },
       { x: new Date(2014,08), y: 22800 },
       { x: new Date(2014,09), y: 27500 },
       { x: new Date(2014,10), y: 22750 },
       { x: new Date(2014,11), y: 19300 },
       { x: new Date(2014,12), y: 16800 },
       { x: new Date(2014,13), y: 14500 }
       ]
     }
     ]
   });
chart.render();
var chart1 = new CanvasJS.Chart("chartContainer1",
	    {
	      title:{
	      text: "Red for Students and Blue for Volunteers/Student Instructors"
	      },
	        data: [
	      {
	        type: "stackedColumn",
	        dataPoints: [
	        {  y: 15 , label: "May'14"},
	        {  y: 34, label: "Jun'14" },
	        {  y: 56, label: "Jul'14" },
	        {  y: 70, label: "Aug'14" },
	        {  y: 37, label: "Sept'14"},
	        {  y: 40, label: "Oct'14"},
	        {  y: 50, label: "Nov'14"},
	        {  y: 44, label: "Dec'14"}

	        ]
	      },  {
	        type: "stackedColumn",
	         dataPoints: [
	         {  y: 48 , label: "May'14"},
	         {  y: 85, label: "Jun'14" },
	         {  y: 76, label: "Jul'14" },
	         {  y: 115, label: "Aug'14" },
	         {  y: 124, label: "Sept'14"},
	         {  y: 156, label: "Oct'14"},
	         {  y: 200, label: "Nov'14"},
	         {  y: 119, label: "Dec'14"}

	        ]
	      }
	      ]
	    });

	    chart1.render();
}

 
  </script>
                  <div class="row">                     
                      
                              <div class="col-md-6 col-sm-12 col-xs-12">                     
                    <div class="panel panel-default">
                        <div class="panel-heading">
                          
                        </div>
                        <div class="panel-body">
                            <div id="chartContainer1" style="height: 300px; "></div>
                        </div>
                    </div>            
                </div> 
                      <div class="col-md-6 col-sm-12 col-xs-12">                     
                    <div class="panel panel-default">
                        <div class="panel-heading">
                           
                        </div>
                        <div class="panel-body">
                            <div id="chartContainer" style="height: 300px; "></div>
                        </div>
                    </div>            
                </div> 
                
          
       
    
             <!-- /. PAGE INNER  -->
            
         <!-- /. PAGE WRAPPER  -->
        </div></div></div></div>
        
        <script type="text/javascript" src="assets/js/canvasjs.min.js"></script>
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
