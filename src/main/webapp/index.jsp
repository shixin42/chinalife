<%--
  Created by IntelliJ IDEA.
  User: ishikin
  Date: 14-3-16
  Time: 上午1:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
Hi
<form action="/chinalife/FileUpload" method="POST" enctype="multipart/form-data">
    Note:<input type="text" name="note"><br>
    File:<input type="file" name="upfile"><br>
    <input type="submit" value="press">to upload the file.
</form>
</body>
</html>
