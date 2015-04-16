<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<title>Welcome</title>
</head>
 
<body>
<%String s=(String)session.getAttribute("login");  
if(s!=null && !s.equals("")){  %>
    <h2>Howdy, <s:property value="username" />...!</h2>
    
    
    <a href="<s:url action="logout"/>">Click here to logout</a>
    <%}else{ %>
    
    <script type="text/javascript">
    window.location.href='/TechMHackathon';
    </script>
    <%} %>
</body>
</html>