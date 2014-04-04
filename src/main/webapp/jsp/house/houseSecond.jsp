<%--
  Created by IntelliJ IDEA.
  User: Chao.Cui.VWED
  Date: 14-4-1
  Time: 下午4:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <c:import url="/template/importedFiles.html" />
    <script type="application/javascript" language="JavaScript">
        $(function()
        {
            $("#lifeService").removeClass("active");
            $("#houseBuying").addClass("active");
        })
    </script>
</head>
<body>
<!--navigation for top area-->
<%@ include file="/template/header.jsp"%>
</body>
</html>
