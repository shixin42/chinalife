<%--
  Created by IntelliJ IDEA.
  User: Chao.Cui.VWED
  Date: 14-3-18
  Time: 上午11:14
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
<div class="container">
    <div class="row clearfix">
        <div class="col-md-3 column">
            <div class="panel panel-default panel-primary">
                <div class="panel-heading">房屋出售</div>
                <div class="panel-body">
                    <p>...</p>
                </div>
            </div>
        </div>
        <div class="col-md-9 column">
            <div class="tabbable" id="tabs-253394">
                <ul class="nav nav-tabs">
                    <li class="active">
                        <a href="#panel-908308" data-toggle="tab">中介</a>
                    </li>
                    <li>
                        <a href="#panel-175615" data-toggle="tab">个人</a>
                    </li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane active" id="panel-908308">
                        <div class="col-md-12 column">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="thumbnail">
                                        <img alt="300x200" src="/chinalife/img/4.jpg"/>
                                        <div class="caption">
                                            <h4>
                                                Thumbnail label
                                            </h4>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="thumbnail">
                                        <img alt="300x200" src="/chinalife/img/5.jpg" />
                                        <div class="caption">
                                            <h4>
                                                Thumbnail label
                                            </h4>
                                            <p>
                                                价格
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="thumbnail">
                                        <img alt="300x200" src="/chinalife/img/6.jpg" />
                                        <div class="caption">
                                            <h4>
                                                Thumbnail label
                                            </h4>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane" id="panel-175615">
                        <p>
                            Howdy, I'm in Section 2.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
