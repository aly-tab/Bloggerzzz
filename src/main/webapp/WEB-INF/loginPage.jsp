<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login Page</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>
	<div id="head">
    	<h1><a href="/">Bloggerzzz</a></h1>
    </div>

    <c:if test="${logoutMessage != null}">
        <c:out value="${logoutMessage}"></c:out>
    </c:if>
    <div id="login">
    <h1>Login</h1>
    <form method="POST" action="/login">
    	<table>
    	<tbody>
        <tr>
            <td><label for="username">Username</label></td>
            <td><input class="login"  type="text" id="username" name="username"/></td>
        </tr>
        <tr>
            <td><label for="password">Password</label></td>
            <td><input class="login"  type="password" id="password" name="password"/></td>
        </tr>
        </tbody>
        </table>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <input class="login-btn" type="submit" value="Login"/>
    </form>
    <c:if test="${errorMessage != null}">
        <c:out value="${errorMessage}"></c:out>
    </c:if>
    </div>
</body>
</html>