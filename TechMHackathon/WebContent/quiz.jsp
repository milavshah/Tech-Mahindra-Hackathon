<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib prefix="s" uri="/struts-tags"%>
<head>
      <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Take Quiz</title>
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
padding: 15px 50px 5px 50px;
float: right;
font-size: 16px;">  <%String s=(String)session.getAttribute("login"); 
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
                     <h2>Quiz</h2>   
                        <h5>Quiz contains 10 Multiple Choice Questions.Total time for the Quiz is 10 Minutes.You can finish the exam at any time.Read the question carefully before answering.You can change your answers before submitting.Good luck for the test.
                       </h5>
                    </div>
                </div>
                 <!-- /. ROW  -->
                 <hr />
                 <!-- Form Elements -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            
                    	</div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-md-6">
                 				<form role="form">
		<!-- Q1 -->							<fieldset disabled="disabled">
                                            <div class="form-group">
                                                <label for="disabledSelect"></label>
                                                <input class="form-control" id="Q1" type="text"  value="1. What is the following problem an example of? 4+6=6+4 " disabled />
                                            </div>
											</fieldset>
											<div class="form-group">
                  
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR1" id="OA1" value="A. Communicative property" />A. Communicative property
                                                </label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR1" id="OB1" value="B. Distributive property "/>B. Distributive property
                                                </label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR1" id="OC1" value="C. Associative property"/>C. Associative property
                                                </label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR1" id="OD1" value="D. None of these"/>D. None of these
                                                </label>
                                            </div>
                                        	</div>
			<!-- Q2 -->						<fieldset disabled="disabled">
                                            <div class="form-group">
                                                <label for="disabledSelect"></label>
                                                <input class="form-control" id="Q2" type="text" value="2. How much is the following Roman numeral: MMDCX? " disabled />
                                            </div>
											</fieldset>
											<div class="form-group">
                  
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR2" id="OA2" value="A. 256 " />A. 256 
                                                </label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR2" id="OB2" value="B. 2,610 "/>B. 2,610
                                                </label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR2" id="OC2" value="C. 2,526 "/>C. 2,526
                                                </label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR2" id="OD2" value="D. None of these"/>D. None of these
                                                </label>
                                            </div>
                                        	</div>									        
                        <!-- Q3 -->         <fieldset disabled="disabled">
                                            <div class="form-group">
                                                <label for="disabledSelect"></label>
                                                <input class="form-control" id="Q3" type="text" value="3. How much is 3 to the 3rd power?" disabled />
                                            </div>
											</fieldset>
											<div class="form-group">
                  
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR3" id="OA3" value="A. 9 " />A. 9
                                                </label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR3" id="OB3" value="B. 27"/>B. 27
                                                </label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR3" id="OC3" value="C. 81 "/>C. 81
                                                </label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR3" id="OD3" value="D. 243"/>D. 243
                                                </label>
                                            </div>
                                        	</div>									        
            <!-- Q4 -->                    	<fieldset disabled="disabled">
                                            <div class="form-group">
                                                <label for="disabledSelect"></label>
                                                <input class="form-control" id="Q4" type="text" value="4. This problem is an example of which property: 2x(4+5)=2x4 + 2x5 " disabled />
                                            </div>
											</fieldset>
											<div class="form-group">
                  
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR4" id="OA4" value=" A. Associative property " />A. Associative property
                                                </label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR4" id="OB4" value="B. Distributive property "/>B. Distributive property
                                                </label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR4" id="OC4" value="C. Communicative property "/>C. Communicative property
                                                </label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR4" id="OD4" value="D. none of these"/>D. none of these
                                                </label>
                                            </div>
                                        	</div>									        
                        <!-- Q5 -->         <fieldset disabled="disabled">
                                            <div class="form-group">
                                                <label for="disabledSelect"></label>
                                                <input class="form-control" id="Q5" type="text" value = "5. How is 0.125 written as a percentage?"  disabled />
                                            </div>
											</fieldset>
											<div class="form-group">
                  
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR5" id="OA5" value="A. 12.5% " />A. 12.5%
                                                </label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR5" id="OB5" value="B. 125% "/>B. 125%
                                                </label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR5" id="OC5" value="C. 1.25% "/>C. 1.25% 
                                                </label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR5" id="OD5" value="D. 0.125%"/>D. 0.125%
                                                </label>
                                            </div>
                                        	</div>									        
                        <!-- Q6 -->         <fieldset disabled="disabled">
                                            <div class="form-group">
                                                <label for="disabledSelect"></label>
                                                <span  id="Q6" disabled >
                                                6. What is the range for the following set of numbers: [4, 5, 1, 8, 44, 8, 17, 9, 18]?
                                                </span>
                                            </div>
											</fieldset>
											<div class="form-group">
                  
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR6" id="OA6" value="A. 12.5 " />A. 12.5
                                                </label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR6" id="OB6" value="B. 9"/>B. 9
                                                </label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR6" id="OC6" value=" C. 43 "/>C. 43 
                                                </label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR6" id="OD6" value="D. 54"/>D. 54
                                                </label>
                                            </div>
                                        	</div>									        
                        <!-- Q7 -->         <fieldset disabled="disabled">
                                            <div class="form-group">
                                                <label for="disabledSelect"></label>
                                                <input class="form-control" id="Q7" type="text" value="7. What does the term 'median' mean? "  disabled />
                                            </div>
											</fieldset>
											<div class="form-group">
                  
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR7" id="OA7" value=" A. The sum of the greatest and least values in any given set " />A. The sum of the greatest and least values in any given set 
                                                </label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR7" id="OB7" value=" B. The average of the middle two values "/>B. The average of the middle two values 
                                                </label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR7" id="OC7" value="C. The difference of the middle two values "/>C. The difference of the middle two values 
                                                </label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR7" id="OD7" value="D. None of these"/>D. None of these
                                                </label>
                                            </div>
                                        	</div>									        
                        <!-- Q8 -->         <fieldset disabled="disabled">
                                            <div class="form-group">
                                                <label for="disabledSelect"></label>
                                                <span>
                                                8. If there are 2,000 pounds in a ton, then approximately how many tons are there in 18,230 pounds?
                                                </span>
                                                <!-- <input class="form-control" id="Q8" type="text" value="8. If there are 2,000 pounds in a ton, then approximately how many tons are there in 18,230 pounds?" disabled /> -->
                                            </div>
											</fieldset>
											<div class="form-group">
                  
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR8" id="OA8" value="A. 18,000 " />A. 18,000
                                                </label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR8" id="OB8" value="B. 9 "/>B. 9
                                                </label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR8" id="OC8" value="C. 900 "/>C. 900
                                                </label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR8" id="OD8" value="D. 180"/>D. 180
                                                </label>
                                            </div>
                                        	</div>									        
                        <!-- Q9 -->         <fieldset disabled="disabled">
                                            <div class="form-group">
                                                <label for="disabledSelect"></label>
                                                <span>
                                                9. Which of the following two numbers satisfies the following equation: a x 7 = c
                                                </span>
                                                <!-- <input class="form-control" id="Q9" type="text" value="9. Which of the following two numbers satisfies the following equation: a x 7 = c"  disabled /> -->
                                            </div>
											</fieldset>
											<div class="form-group">
                  
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR9" id="OA9" value=" A. a=3, c=49" />A. a=3, c=49
                                                </label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR9" id="OB9" value=" B. a=7, c=21 "/>B. a=7, c=21
                                                </label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR9" id="OC9" value=" C. a=9, c=63 "/>C. a=9, c=63
                                                </label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR9" id="OD9" value="D. a=7, c=49"/>D. a=7, c=49
                                                </label>
                                            </div>
                                        	</div>									        
                        <!-- Q10 -->        <fieldset disabled="disabled">
                                            <div class="form-group">
                                                <label for="disabledSelect"></label>
                                                <input class="form-control" id="Q10" type="text" value="10. What is the best answer to the following problem: |" disabled />
                                            </div>
											</fieldset>
											<div class="form-group">
                  
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR10" id="OA10" value=" A. 5" />A. 5
                                                </label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR10" id="OB10" value=" B. -15"/>B. -1
                                                </label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR10" id="OC10" value="C. -5 "/>C. -5
                                                </label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="OR10" id="OD10" value="D. 15"/>D. 15
                                                </label>
                                            </div>
                                        	</div>
                                        	<button type="submit" class="btn btn-danger">Submit Button</button>
                                        	<button type="reset" class="btn btn-danger">Reset Button</button>
                  				</form>
                                </div>
                            </div>
                        </div>
                    </div>
                     <!-- End Form Elements -->
                      <!-- /. PAGE INNER  -->
            </div>
         <!-- /. PAGE WRAPPER  -->
        </div>
     <!-- /. WRAPPER  -->
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
     