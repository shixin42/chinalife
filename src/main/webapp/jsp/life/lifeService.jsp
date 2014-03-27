<%--
  Created by IntelliJ IDEA.
  User: Chao.Cui.VWED
  Date: 14-3-18
  Time: 上午11:34
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
            $("#houseBuying").removeClass("active");
            $("#lifeService").addClass("active");
        })
    </script>
</head>
<body>
<!--navigation for top area-->
<%@ include file="/template/header.jsp"%>
this is lifeServicePage
</body>
</html>
