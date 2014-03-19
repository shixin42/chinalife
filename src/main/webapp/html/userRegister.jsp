<%--
  Created by IntelliJ IDEA.
  User: Chao.Cui.VWED
  Date: 14-3-19
  Time: 下午3:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="../css/bootstrap.css" rel="stylesheet" type="text/css"/>
    <link href="../css/bootstrap-theme.css" rel="stylesheet" type="text/css"/>
    <script src="../js/jquery-1.10.1.js" type="text/javascript"></script>
    <script src="../js/bootstrap.js" type="text/javascript"></script>
    <script src="../js/jquery.cookie.js" type="text/javascript"></script>
    <script type="application/javascript" language="JavaScript">
    </script>

</head>
<body>
<!--navigation for top area-->
<%@ include file="header.jsp"%>
<div class="container">
    <div class="row clearfix">
        <div class="col-md-5">
            <div class="modal-body">
                <form role="form" id="userLogonForm" class="form-horizontal"  action="../register" method="post">
                    <div class="form-group">
                        <label for="user_nickname" class="control-label col-md-2">用户名</label>
                        <div class="col-md-10">
                            <input type="email" class="form-control" id="user_nickname" placeholder="请输入用户名">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="user_email" class="control-label col-md-2">邮箱地址</label>
                        <div class="col-md-10">
                            <input type="email" class="form-control" id="user_email" placeholder="请输入邮箱地址">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="user_pwd" class="control-label col-md-2">密码</label>
                        <div class="col-md-10">
                            <input type="password" class="form-control" id="user_pwd" placeholder="请输入密码">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="userPasswordAgain" class="control-label">密码确认</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="userPasswordAgain" placeholder="请再输入一次">
                        </div>
                    </div>
                    <div class="radio form-horizontal">
                        <div class="radio">
                            <label>
                                <input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" checked>
                                商家用户
                            </label>
                        </div>
                        <div class="radio">
                            <label>
                                <input type="radio" name="optionsRadios" id="optionsRadios2" value="option2">
                                个人用户
                            </label>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-default btn-lg">注册用户</button>
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
