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
        })
        function userLogonJS()
        {
            var username = $("#exampleInputEmail1").val();
            var password = $("#exampleInputPassword1").val();
            $("#userLogonForm").submit();
        }
    </script>
</head>
<body>
<!--navigation for top area-->
<%@ include file="/template/header.jsp"%>
<div class="container">
    <div class="row clearfix">
        <div class="col-md-5">
            <div class="modal-body">
                <form role="form" id="userLogonForm"  action="/chinalife/login" method="post">
                    <%--<label class="label-danger" id="returnMsg">错误信息<%=session.getAttribute("user")%></label>--%>
                    <div class="form-group">
                        <label for="user_nickname">用户名</label><input class="form-control" id="user_nickname" name="nickname" type="text" placeholder="邮箱地址"/>
                    </div>
                    <div class="form-group">
                        <label for="user_pwd">密码</label><input class="form-control" id="user_pwd" name="password" type="password" placeholder="密码"/>
                    </div>
                    <div class="checkbox ">
                        <label><input type="checkbox" id="checkRememberBox" value="12"/> Check me out</label>
                    </div> <button type="submit" class="btn btn-primary" onclick="userLogonJS();">Submit</button>
                </form>
            </div>
        </div>
        <div class="col-md-5">
        </div>
        <div class="col-md-2"></div>
    </div>
</div>
</body>
</html>
