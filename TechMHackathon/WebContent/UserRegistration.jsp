<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
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

</head>
<body>
<s:actionerror/>
    <div class="container">
        <div class="row text-center  ">
            <div class="col-md-12">
                <br /><br />
                <h2>NPO : Register</h2>
               
                <h5>( Register yourself to get access )</h5>
                 <br />
            </div>
        </div>
         <div class="row">
               
                <div class="col-md-4 col-md-offset-4 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                        <strong>  New User ? Register Yourself </strong>  
                            </div>
                            <div class="panel-body" align="center">
                                <s:form action="donorreg.action" method="post">
<br/>
                                        <div class="form-group input-group">
                                            <input type="text" name="fname" class="form-control" placeholder="Your First Name" />
                                        </div>
                                        <div class="form-group input-group">
                                            <input type="text" name="lname" class="form-control" placeholder="Your Last Name" />
                                        </div>
                                     <div class="form-group input-group">
                                            <input type="text" name="userName" class="form-control" placeholder="Desired Username" />
                                        </div>
                                         <!-- <div class="form-group input-group">
                                            <span class="input-group-addon">@</span>
                                            <input type="text" class="form-control" placeholder="Your Email" />
                                        </div> -->
                                      <div class="form-group input-group">
                                            <input type="password" name="password" class="form-control" placeholder="Enter Password" />
                                        </div>
                                        <div class="form-group input-group">
                                            <input type="text" name="streetaddr" class="form-control" placeholder="Street Address" />
                                        </div>
                                        <div class="form-group input-group">
                                            <input type="text" name="city" class="form-control" placeholder="City" />
                                        </div>
                                        <div class="form-group input-group">
                                            <input type="text" name="state" class="form-control" placeholder="State" />
                                        </div>
                                        <div class="form-group input-group">
                                            <input type="text" name="country" class="form-control" placeholder="Country" />
                                        </div>
                                        <div class="form-group input-group">
                                            <input type="text" name="zipcode" class="form-control" placeholder="Zipcode" />
                                        </div>
                                        <div class="form-group input-group">
                                            <input type="text" name="mobNo" class="form-control" placeholder="Mobile Number" />
                                        </div>
                                        <div class="form-group input-group">
                                            <input type="text" name="email" class="form-control" placeholder="Email"/>
                                        </div>
                                        
                                         <div class="form-group input-group">
                                           
                                           <select required="required" name="userType">
                                           <option value="">Select User type</option>
                                           <option value="1">Volunteer</option>
                                           <option value="2">Student</option>
                                           </select>
                                            
                                        </div>
                                     
                                    <s:submit cssClass="btn btn-success " method="execute" key="label.donor.submit" align="center" />
                                    <hr />
                                    Already Registered ?  <a href="Login.jsp" >Login here</a>
</s:form>
                            </div>
                           
                        </div>
                    </div>
                
                
        </div>
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
   
</body>
</html>
