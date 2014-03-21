<%@ page import="java.io.PrintWriter" %>
<%--
  Created by IntelliJ IDEA.
  User: shixin
  Date: 3/20/14
  Time: 10:01 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isErrorPage="true" %>
<html>
<head>
    <title>Error Page</title>
</head>
<body>
<h1>Error:</h1>
<%=exception%>
<h2>stack track:</h2>
<%
    exception.printStackTrace(new PrintWriter(out));
%>
</body>
</html>
