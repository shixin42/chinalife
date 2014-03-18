<%--
  Created by IntelliJ IDEA.
  User: Chao.Cui.VWED
  Date: 14-3-18
  Time: 上午11:14
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
        $(function()
        {
            $("#lifeService").removeClass("active");
            $("#houseBuying").addClass("active");
        })
    </script>
</head>
<body>
<!--navigation for top area-->
<%@ include file="header.jsp"%>
<div class="container">
    <div class="row clearfix">
        <div class="col-md-3 column">
            <ul class="nav nav-pills nav-stacked">
                <li><a href="#home" data-toggle="tab">房屋出售</a></li>
                <li><a href="#profile" data-toggle="tab">房屋出租</a></li>
                <li><a href="#messages" data-toggle="tab">新房+land</a></li>
                <li><a href="#settings" data-toggle="tab">短租房</a></li>
            </ul>
        </div>
        <div class="col-md-9 column">
            <!-- Tab panes -->
            <div class="tab-content">
                <div class="tab-pane active" id="home">搜索条件</div>
                <div class="tab-pane" id="profile">搜索条件</div>
                <div class="tab-pane" id="messages">搜索条件</div>
                <div class="tab-pane" id="settings">搜索条件</div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
