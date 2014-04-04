<%--
  Created by IntelliJ IDEA.
  User: Chao.Cui.VWED
  Date: 14-3-16
  Time: 下午11:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <c:import url="/template/importedFiles.html" />
    <script type="application/javascript" language="JavaScript">
        $(function() {
            //初始化页面，查看cookie用户名和密码情况。
//            var name = unescape($.cookie("cookieUserName"));
//            var pwd = unescape($.cookie("cookiePassword"));
//            $("#userMenu").toggle();
//            if (name == "undefined" ||  pwd == "undefined")
//            {
//                //alert("af"+name+":"+pwd);
//            }
//            else
//            {
//                $("#exampleInputEmail1").val(name);
//                $("#exampleInputPassword1").val(pwd);
//            }
        });
        /*function userLogonJS()
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
                url : '../login', //调用servelet页面
                data: param,
                type : "GET",
                dataType : "Text",
                success : function(message){
                    $("#returnMsg").html(message);
                    $("#userMenu").toggle();
                    $('#modal-container-964516').modal('hide');
                    $("#modal-964516").toggle();
                },
                error : function(message){
                    $("#returnMsg").html(message.val()+":cc");
                }
            })
        }*/
    </script>
    <style>

    </style>
</head>
<body>
<!--navigation for top area-->
<c:import url="/template/header.jsp" />
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
                        <img alt="" src="/chinalife/img/1.jpg" />
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
                        <img alt="" src="/chinalife/img/2.jpg" />
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
                        <img alt="" src="/chinalife/img/3.jpg" />
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
<h5>&nbsp;</h5>
<!--house buying area-->
<div class="container">
    <div class="list-group">
        <div class="row clearfix">
            <a href="#" class="list-group-item active">房屋买卖</a>
            <div class="list-group-item">
            <div class="row clearfix">
                <div class="col-md-12 column">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="thumbnail">
                                <img alt="300x200" src="/chinalife/img/1.jpg" />
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
                                <img alt="300x200" src="/chinalife/img/2.jpg" />
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
                                <img alt="300x200" src="/chinalife/img/3.jpg" />
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
        </div>
    </div>
</div>
<div class="container">
    <div class="row clearfix">
        <div class="col-md-12 column">
            <div class="row">
                <div class="col-md-4">
                    <div class="thumbnail">
                        <img alt="300x200" src="/chinalife/img/1.jpg" />
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
                        <img alt="300x200" src="/chinalife/img/2.jpg" />
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
                        <img alt="300x200" src="/chinalife/img/3.jpg" />
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
<!--life service area-->
<%--<div class="container">
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
</div>--%>

</body>
</html>