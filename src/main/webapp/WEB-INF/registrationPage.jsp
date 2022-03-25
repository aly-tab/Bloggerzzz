<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Registration Page</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>
	<div id="head">
    	<h1><a href="/">Bloggerzzz</a></h1>
    </div>
    <div id="register">
	    <h1>Register</h1>
	    
	    <form:form method="POST" action="/registration" modelAttribute="user">
	    	<table>
	    	<tbody>
	        <tr>
	           <td><form:label path="username">Username:</form:label></td>
	           <td><form:input path="username" class="register"/></td>
	        </tr>
	        <tr>
	           <td><form:label path="password">Password:</form:label></td>
	            <td><form:password path="password" class="register"/></td>
	        </tr>
	        <tr>
	            <td><form:label path="passwordConfirmation">Password Confirmation:</form:label></td>
	            <td><form:password path="passwordConfirmation" class="register"/></td>
	        </tr>
	        </tbody>
	        </table>
	        <input type="submit" value="Register" class="register-btn"/>
    	</form:form>
    	<p><form:errors path="user.*"/></p>
    </div>
</body>
</html>