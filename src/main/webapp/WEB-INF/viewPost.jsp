<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Bloggerzzz</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>
	<div id="head">
		<c:choose>
		<c:when test="${loggedIn != null}">
			<div>
				<h1>Logged in as <c:out value="${loggedIn.username}"/></h1>
			</div>
	   		<div id="link-btns">
				<a href="/${user.username}">Back</a>
				<a href="/home">Home</a>
				<c:choose>
					<c:when test="${loggedIn.username != user.username}">
						<a href="/${loggedIn.username}">Profile</a>
					</c:when>
				</c:choose>
				<a href="/view">Check Out Blogs</a>
				<a href="/account/${user.username}/${user.id}">Account</a>
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
		    	<a href="/${user.username}">Back</a>
		    	<a href="/view">Check Out Blogs</a>
		    	<a href="/login">Login</a>
		    	<a href="/registration">Register</a>
	    	</div>
	    </c:otherwise>
	    </c:choose>
    </div>
    <div id="viewPost">
    <h1><c:out value="${user.username}"/></h1>
    	<div class="viewContent">
		    <h3><c:out value="${content.title}"/></h3>
		    <div id="fullText">
				<pre><c:out value="${content.text}" /></pre>
			</div>
			<p>Posted: <fmt:formatDate value="${user.createdAt}" type="date" pattern="dd-MMM-yyyy"/></p>
			<c:choose>
			<c:when test="${loggedIn.id == user.id}">
				<a href="/editPost/${user.username}/${content.id}">Edit</a> <a href="/delete/${user.username}/${content.id}">Delete</a>
			</c:when>
			</c:choose>
		</div>
	</div>
</body>
</html>