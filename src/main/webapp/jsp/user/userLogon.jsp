<%--
  Created by IntelliJ IDEA.
  User: Chao.Cui.VWED
  Date: 14-3-18
  Time: 下午5:22
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
//            $("#userLogonForm").validate({
//                rules: {
//                    nickname : "required",
//                    password : "required"
//                },
//                messages: {
//                    nickname: "you need to enter the status of the house",
//                    password : "you need to enter the status of the house"
//                }
//            })
        })
        function changeImg()
        {
            now = new Date();
            $("#code").src="/chinalife/template/captcha.jsp?code="+now.getTime();
        }
    </script>
</head>
<body>
<!--navigation for top area-->
<%@ include file="/template/header.jsp"%>
<div class="container">
    <div class="row clearfix">
        <div class="col-md-8">
            <%@ include file="/template/logon.jsp"%>
        </div>
        <div class="col-md-4"></div>
    </div>
</div>
</body>
</html>
