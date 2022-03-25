<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Bloggerzzz</title>
	<link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
	<div id="head">
		<c:choose>
		<c:when test="${loggedIn != null}">
		<div id="l">
			<h1>Logged in as <c:out value="${username}"/></h1>
		</div>
		<div id="link-btns">
		    <a href="/home">Home</a>
		    <a href="/${loggedIn.username}">Profile</a>
			<a href="/account/${loggedIn.username}/${loggedIn.id}">Account</a>
		    <div id="#btn-box">
		    <form id="logoutForm" method="POST" action="/logout">
		        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		        <input class="logout" type="submit" value="Logout" />
		    </form>
		    </div>
	    </div>
	    </c:when>
	    <c:otherwise>
	    	<div>
	    		<h1><a href="/">Bloggerzzz</a></h1>
	    	</div>
	    	<div id="loggedout-nav">
	    		<a href="/login">Login</a>
	    		<a href="/registration">Register</a>
	    	</div>
	    </c:otherwise>
	    </c:choose>
    </div>
    <div id="blogs">
		<h1>Check Out Blogs</h1>
		<div id="container">
			<c:forEach items="${users}" var="i" >	
				<c:choose>
				<c:when test="${i.username != username}">			
					<div class="username"><a href="/${i.username}"><c:out value="${i.username}"/></a></div>
				</c:when>
				</c:choose>
			</c:forEach>
		</div>
	</div>
</body>
</html>