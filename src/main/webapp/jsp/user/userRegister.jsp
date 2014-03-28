<%--
  Created by IntelliJ IDEA.
  User: Chao.Cui.VWED
  Date: 14-3-19
  Time: 下午3:00
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
            $("#userRegisterForm").validate({
                rules: {
                    nickname : "required",
                    email : {
                        required : true,
                        email : true
                    },
                    password : {
                        required : true,
                        minlength : 6
                    },
                    passwordAgain: {
                        required: true,
                        minlength: 6,
                        equalTo: "#password"
                    }
                },
                messages: {
                    nickname: "请输入用户名或邮箱",
                    password: {
                        required: "请输入密码",
                        minlength: jQuery.format("密码不能小于{0}个字符")
                    },
                    passwordAgain: {
                        required: "请输入确认密码",
                        minlength: "确认密码不能小于{0}个字符",
                        equalTo: "两次输入密码不一致不一致"
                    }
                }
            })
        })
    </script>
</head>
<body>
<!--navigation for top area-->
<%@ include file="/template/header.jsp" %>
<div class="container">
    <div class="row clearfix">
        <div class="col-md-10">
            <c:import url="/template/register.jsp" />
        </div>
        <div class="col-md-2"></div>
    </div>
</div>
</body>
</html>
