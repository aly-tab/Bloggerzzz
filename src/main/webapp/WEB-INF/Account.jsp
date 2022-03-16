<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Bloggerzzz</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>
	<div id="head">
		<div>
			<h1>Logged in as <c:out value="${user.username}"></c:out></h1>
		</div>
		<div id="link-btns">
			<a href="/home">Home</a>
			<a href="/${user.username}">Profile</a>
			<a href="/view">Check Out Blogs</a>
			<div id="#btn-box">
			<form id="logoutForm" method="POST" action="/logout">
		        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		        <input class="logout" type="submit" value="Logout" />
		    </form>
		    </div>
	    </div>
    </div>
    
    <div id="account"> 
    	<h1>Account Info</h1>   
    	<p>Username: <c:out value="${user.username}"/></p>
    	<p>Password: hidden</p>
		<a href="/deleteUserAccount">Delete Account</a>
	</div>
</body>
</html>