<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
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
				<h1>Logged in as <c:out value="${loggedIn.username}"/></h1>
			</div>
			<div id="link-btns">
				<a href="/home">Home</a>
				<c:choose>
					<c:when test="${loggedIn.username != user.username}">
						<a href="/${loggedIn.username}">Profile</a>
					</c:when>
				</c:choose>
				<a href="/view">Check Out Blogs</a>
 				<a href="/account/${user.username}/${user.id}">Account</a>
				<div id="btn-box">
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
	    		<a href="/view">Check Out Blogs</a>
	    		<a href="/login">Login</a>
	    		<a href="/registration">Register</a>
	    	</div>
	    </c:otherwise>
	    </c:choose>
    </div>
    <div id="content">
		<h1>${user.username}</h1>
		<c:forEach items="${allContents}" var="i" >	
			<div class="post">
				<h3><c:out value="${i.title}"/></h3>				
				<div id="overflow"><pre><c:out value="${i.text}"/></pre></div>
				<p>Posted: <fmt:formatDate value="${user.createdAt}" type="date" pattern="dd-MMM-yyyy"/></p>
				<a href="/postView/${user.username}/${i.id}">View</a>
				<c:choose>
					<c:when test="${loggedIn.id == user.id}">
						<a href="/editPost/${user.username}/${i.id}">Edit</a> <a href="/delete/${user.username}/${i.id}">Delete</a>
					</c:when>
				</c:choose>
			</div>
		</c:forEach>
	</div>
</body>
</html>