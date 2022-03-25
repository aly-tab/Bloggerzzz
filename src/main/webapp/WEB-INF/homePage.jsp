<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Home Page</title>
	<link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
	<div id="head">
		<div id="l">
	    	<h1>Logged in as <c:out value="${currentUser.username}"></c:out></h1>
	    </div>
	    <div id="link-btns">
		    <a href="/${currentUser.username}">Profile</a>
		    <a href="/view">Check Out Blogs</a>
		    <a href="/account/${currentUser.username}/${currentUser.id}">Account</a>
		    <div id="#home-btn">
		    <form id="logoutForm" method="POST" action="/logout">
		        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		        <input class="logout" type="submit" value="Logout" />
		    </form>
		    </div>
	    </div>
    </div>
    <div id="write">
		<form:form action="/createPost" method="post" modelAttribute="content">
			<form:hidden path="user" value="${user.id}"/> 
			<h1 class="text">Write a Post</h1>
			<p>Title</p>
			<form:input type="text" path="title" class="title"/>
			<p><form:errors path="title"/></p>
			<p>Content</p>
			<form:textarea path="text"></form:textarea>
			<p><form:errors path="text"/></p>
			<div>
				<input type="submit" value="Create" class="btn"/>
			</div>
			<p>${success}</p> 
		</form:form>   
	</div>
</body>
</html>