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
			<a href="/account/${user.username}/${user.id}">Account</a>
			<div id="#btn-box">
			<form id="logoutForm" method="POST" action="/logout">
		        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		        <input class="logout" type="submit" value="Logout" />
		    </form>
		    </div>
	    </div>
    </div>
    
    <div id="write">    
		<form:form action="/updatePost/${username}/${content.id}" method="post" modelAttribute="content">
			<form:hidden path="user" value="${user.id}"/> 
			<h1 class="text">Edit Post</h1>
			<p>Title</p>
			<form:input path="title" class="title" value="${content.title}"/>
			<p><form:errors path="title"/></p>
			<p>Content</p>
			<form:textarea path="text" value="${content.text}"></form:textarea>
			<form:errors path="text"/>
			<div>
				<input type="submit" value="Update" class="btn"/>
			</div>
	    	<p>${success}</p>
		</form:form> 
		<a href="/delete/${user.username}/${content.id}">Delete</a>
	</div>
</body>
</html>