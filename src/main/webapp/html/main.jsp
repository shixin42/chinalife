<%--
  Created by IntelliJ IDEA.
  User: Chao.Cui.VWED
  Date: 14-3-16
  Time: 下午11:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title></title>
    <link href="../css/bootstrap.css" rel="stylesheet" type="text/css"/>
    <link href="../css/bootstrap-theme.css" rel="stylesheet" type="text/css"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script src="../js/jquery-1.10.1.js" type="text/javascript"></script>
    <script src="../js/bootstrap.js" type="text/javascript"></script>
    <script type="application/javascript" language="JavaScript">
        function userLogonJS()
        {
            var username = $("#exampleInputEmail1").val();
            var password = $("#exampleInputPassword1").val();
            var check_remember = $("#checkRememberBox").checked;
            alert(username +":"+password + ":"+check_remember);
            var param = "username="+username+"&password="+password+"&check_remember="+check_remember;
            $.ajax({
                url : '../first', //调用servelet页面
                data: param,
                type : "GET",
                dataType : "Text",
                success : function(message){
                    $("#returnMsg").html(message);
                },
                error : function(){
                    $("#returnMsg").html("请求失败");
                }
            })
        }
    </script>
    <style>

    </style>
</head>
<body>
<!--navigation for top area-->
<div class="container">
    <div class="row clearfix">
        <div class="col-md-12 column">
            <nav class="navbar navbar-default" role="navigation">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                        <span class="sr-only">Toggle navigation</span><span class="icon-bar"></span>
                        <span class="icon-bar"></span><span class="icon-bar"></span></button> <a class="navbar-brand" href="#">首页</a>
                </div>
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <li class="active">
                            <a href="#">房屋租售</a>
                        </li>
                        <li>
                            <a href="#">生活服务</a>
                        </li>
                        <li>
                            <a href="#">生活贴士</a>
                        </li>
                        <li>
                            <a href="#">生活论坛</a>
                        </li>
                        <li>
                            <a href="#">网站设计</a>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown<strong class="caret"></strong></a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a href="#">Action</a>
                                </li>
                                <li>
                                    <a href="#">Another action</a>
                                </li>
                                <li>
                                    <a href="#">Something else here</a>
                                </li>
                                <li class="divider">
                                </li>
                                <li>
                                    <a href="#">Separated link</a>
                                </li>
                                <li class="divider">
                                </li>
                                <li>
                                    <a href="#">One more separated link</a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                    <form class="navbar-form navbar-right" role="search">
                        <div class="form-group">
                            <input class="form-control" type="text" />
                        </div> <button type="submit" class="btn btn-default">Submit</button>
                    </form>

                </div>

            </nav>
        </div>
    </div>
</div>
<!--advertiae area and user log on-->
<div class="container">
    <div class="row clearfix">
        <div class="col-md-9">
            <div class="carousel slide" id="carousel-893567">
                <ol class="carousel-indicators">
                    <li class="active" data-slide-to="0" data-target="#carousel-893567">
                    </li>
                    <li data-slide-to="1" data-target="#carousel-893567">
                    </li>
                    <li data-slide-to="2" data-target="#carousel-893567">
                    </li>
                </ol>
                <div class="carousel-inner">
                    <div class="item active">
                        <img alt="" src="../img/1.jpg" />
                        <div class="carousel-caption">
                            <h4>
                                First Thumbnail label
                            </h4>
                            <p>
                                Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.
                            </p>
                        </div>
                    </div>
                    <div class="item">
                        <img alt="" src="../img/2.jpg" />
                        <div class="carousel-caption">
                            <h4>
                                Second Thumbnail label
                            </h4>
                            <p>
                                Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.
                            </p>
                        </div>
                    </div>
                    <div class="item">
                        <img alt="" src="../img/3.jpg" />
                        <div class="carousel-caption">
                            <h4>
                                Third Thumbnail label
                            </h4>
                            <p>
                                Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.
                            </p>
                        </div>
                    </div>
                </div> <a class="left carousel-control" href="#carousel-893567" data-slide="prev"><span class="glyphicon glyphicon-chevron-left"></span></a> <a class="right carousel-control" href="#carousel-893567" data-slide="next"><span class="glyphicon glyphicon-chevron-right"></span></a>
            </div>
        </div>
        <!--user logon-->
        <div class="col-md-3">
            <h4>商家登陆</h4>
            <form role="form" id="userLogonForm"  >
                <div class="form-group">
                    <label for="exampleInputEmail1">Email address</label><input class="form-control" id="exampleInputEmail1" type="email" />
                </div>
                <div class="form-group">
                    <label for="exampleInputPassword1">Password</label><input class="form-control" id="exampleInputPassword1" type="password" />
                </div>
                <div class="checkbox ">
                    <label><input type="checkbox" id="checkRememberBox" value="12"/> Check me out</label>
                </div> <button type="button" class="btn btn-primary" onclick="userLogonJS();">Submit</button>
                <label class="label-success" id="returnMsg"></label>
            </form>
        </div>

    </div>
</div>
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
                <div class="tab-pane active" id="home">1</div>
                <div class="tab-pane" id="profile">2</div>
                <div class="tab-pane" id="messages">3</div>
                <div class="tab-pane" id="settings">4s</div>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <div class="row clearfix">
        <div class="col-md-12 column">
            <h3 class="text-primary">
                房屋租售
            </h3>
            <div class="row">
                <div class="col-md-4">
                    <div class="thumbnail">
                        <img alt="300x200" src="http://lorempixel.com/600/200/people" />
                        <div class="caption">
                            <h3>
                                Thumbnail label
                            </h3>
                            <p>
                                Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.
                            </p>
                            <p>
                                <a class="btn btn-primary" href="#">Action</a> <a class="btn" href="#">Action</a>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="thumbnail">
                        <img alt="300x200" src="http://lorempixel.com/600/200/city" />
                        <div class="caption">
                            <h3>
                                Thumbnail label
                            </h3>
                            <p>
                                Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.
                            </p>
                            <p>
                                <a class="btn btn-primary" href="#">Action</a> <a class="btn" href="#">Action</a>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="thumbnail">
                        <img alt="300x200" src="http://lorempixel.com/600/200/sports" />
                        <div class="caption">
                            <h3>
                                Thumbnail label
                            </h3>
                            <p>
                                Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.
                            </p>
                            <p>
                                <a class="btn btn-primary" href="#">Action</a> <a class="btn" href="#">Action</a>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <div class="row clearfix">
        <div class="col-md-12 column">
            <div class="list-group">
                <a href="#" class="list-group-item active">生活服务</a>
                <div class="list-group-item">
                    <div class="row clearfix">
                        <div class="col-md-12 column">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="thumbnail">
                                        <img  src="../img/1.jpg" />
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="thumbnail">
                                        <img  src="../img/2.jpg" />
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="thumbnail">
                                        <img  src="../img/3.jpg" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>