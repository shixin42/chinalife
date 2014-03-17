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
    <script src="../js/jquery.cookie.js" type="text/javascript"></script>
    <script type="application/javascript" language="JavaScript">
        $(function() {
            //初始化页面，查看cookie用户名和密码情况。
            var name = unescape($.cookie("cookieUserName"));
            var pwd = unescape($.cookie("cookiePassword"));
            $("#userMenu").toggle();
            if (name == "undefined" ||  pwd == "undefined")
            {
                //alert("af"+name+":"+pwd);
            }
            else
            {
                $("#exampleInputEmail1").val(name);
                $("#exampleInputPassword1").val(pwd);
            }
        });
        function userLogonJS()
        {
            var username = escape($("#exampleInputEmail1").val());
            var password = escape($("#exampleInputPassword1").val());
            //var time = "10"; //设置cookies 保存时间
            if ($("#checkRememberBox").is(":checked"))
            {
                $.cookie("cookieUserName", username, { expires: 10 });
                $.cookie("cookiePassword", password, { expires: 10 });

            }
            var param = "username="+username+"&password="+password;
            $.ajax({
                url : 'test.jsp', //调用servelet页面
                data: param,
                type : "GET",
                dataType : "Text",
                success : function(message){
                    $("#returnMsg").html(message);
                    $("#userMenu").toggle();
                    $('#modal-container-964516').modal('hide');
                    $("#modal-964516").toggle();
                    alert("username:  "+<%=session.getAttribute("username")%>)
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
                        <li>
                            <a id="modal-964516" href="#modal-container-964516" role="button" class="btn" data-toggle="modal">用户登陆</a>
                        </li>
                        <li id="userMenu" class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">UserName<strong class="caret"></strong></a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a href="#">用户资料</a>
                                </li>
                                <li>
                                    <a href="#">用户退出</a>
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
                        </div> <button type="type" class="btn btn-default" >Submit</button>
                    </form>
                    <!--登陆弹出框-->
                    <div class="modal fade" id="modal-container-964516" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                    <h4 class="modal-title" id="myModalLabel">
                                        用户登陆
                                    </h4>
                                </div>
                                <div class="row clearfix">
                                    <div class="col-md-2"></div>
                                    <div class="col-md-8">
                                        <div class="modal-body">
                                            <form role="form" id="userLogonForm"  >
                                                <label class="label-danger" id="returnMsg">错误信息</label>
                                                <div class="form-group">
                                                    <label for="exampleInputEmail1"></label><input class="form-control" id="exampleInputEmail1" type="text" placeholder="邮箱地址"/>
                                                </div>
                                                <div class="form-group">
                                                    <label for="exampleInputPassword1"></label><input class="form-control" id="exampleInputPassword1" type="password" placeholder="密码"/>
                                                </div>
                                                <div class="checkbox ">
                                                    <label><input type="checkbox" id="checkRememberBox" value="12"/> Check me out</label>
                                                </div> <button type="button" class="btn btn-primary" onclick="userLogonJS();">Submit</button>
                                            </form>
                                        </div>
                                    </div>
                                    <div class="col-md-2"></div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button> <button type="button" class="btn btn-primary">Save changes</button>
                                </div>
                            </div>
                        </div>
                    </div>
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
        <div class="col-md-12 column">
            <h3 class="text-primary">
                房屋租售
            </h3>
            <div class="row">
                <div class="col-md-4">
                    <div class="thumbnail">
                        <img alt="300x200" src="../img/1.jpg" />
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
                        <img alt="300x200" src="../img/2.jpg" />
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
                        <img alt="300x200" src="../img/3.jpg" />
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