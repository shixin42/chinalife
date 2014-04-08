<%--
  Created by IntelliJ IDEA.
  User: Chao.Cui.VWED
  Date: 14-4-5
  Time: 上午9:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <c:import url="/template/importedFiles.html" />
    <link href="/chinalife/css/base.css" rel="stylesheet" type="text/css"/>
    <script type="application/javascript" language="JavaScript">
        $(function()
        {
            $("#lifeService").removeClass("active");
            $("#houseBuying").addClass("active");

            //$("#pikame").PikaChoose({carousel:true});
            var a = function(self){
                self.anchor.fancybox();
            };
            $("#pikame").PikaChoose({
                buildFinished:a,
                carousel:true,
                autoPlay:false,
                showCaption:false
            });
        })
    </script>
    <script type="text/javascript" src="/chinalife/js/image/jquery.jcarousel.min.js"></script>
    <script type="text/javascript" src="/chinalife/js/image/jquery.pikachoose.js"></script>
    <script type="text/javascript" src="/chinalife/js/image/jquery.touchwipe.min.js"></script>
    <script type="text/javascript" src="/chinalife/js/image/jquery.fancybox-1.3.4.js"></script>
    <link href="/chinalife/css/jquery.fancybox-1.3.4.css" rel="stylesheet" type="text/css"/>
    <style type="text/css">
        /* jCarousel Styles */
        /*if you're not using the carousel you can delete everything below this */
        .jcarousel-skin-pika .jcarousel-container-horizontal { padding: 10px 0px; overflow:hidden;}
        .jcarousel-skin-pika .jcarousel-clip-horizontal {height: 90px; width: 485px;}
        .jcarousel-skin-pika .jcarousel-item-horizontal { margin-right: 10px;}
    </style>
</head>
<body>
<!--navigation for top area-->
<%@ include file="/template/header.jsp"%>
<div class="container">
    <div class="row clearfix">
        <!--<div class="col-md-1 column"></div>-->
        <!--center information for house selling-->
        <div class="col-md-8 column">

            <div class="row clearfix ">
                <div class="col-md-12 column">
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <h2 class="panel-title">
                                万达广场真正的一室一厅，设施全，看好来电
                            </h2>
                        </div>
                        <div class="panel-body">
                            <div class="row clearfix " >
                                <div class="col-md-5 column">
                                    <dl class="dl-horizontal ">
                                        <dt>
                                            地址：
                                        </dt>
                                        <dd>
                                            长虹大路1777号
                                        </dd>
                                        <dt>
                                            价格：
                                        </dt>
                                        <dd>
                                            500$
                                        </dd>
                                    </dl>
                                </div>
                                <div class="col-md-3 column">
                                    经纪人信息
                                </div>
                                <div class="col-md-4 column">
                                    <img data-src="holder.js/220x80" class="img-rounded">
                                </div>
                            </div>
                        </div>
                        <!--house images-->
                        <div class="panel-heading">
                            <h3 class="panel-title">
                                房源信息
                            </h3>
                        </div>
                        <div class="panel-body">
                            <ul id="pikame" class="jcarousel-skin-pika">
                                <li><a href="/chinalife/img/4.jpg"><img src="/chinalife/img/4.jpg"/></a></li>
                                <li><a href="/chinalife/img/5.jpg"><img src="/chinalife/img/5.jpg"/></a></li>
                                <li><a href="/chinalife/img/6.jpg"><img src="/chinalife/img/6.jpg"/></a></li>
                                <li><a href="/chinalife/img/1.jpg"><img src="/chinalife/img/1.jpg"/></a></li>
                                <li><a href="/chinalife/img/2.jpg"><img src="/chinalife/img/2.jpg"/></a></li>
                                <li><a href="/chinalife/img/3.jpg"><img src="/chinalife/img/3.jpg"/></a></li>
                            </ul>
                        </div>
                        <!--house detail info-->
                        <div class="panel-heading">
                            <h3 class="panel-title">
                                房源信息
                            </h3>
                        </div>
                        <div class="panel-body">
                        </div>
                        <!--house inquire info-->
                        <div class="panel-heading">
                            <h3 class="panel-title">
                                邮件询问
                            </h3>
                        </div>
                        <div class="panel-body">
                            <form class="form-horizontal">
                                <div class="form-group">
                                    <label class="control-label col-sm-2" for="userName">姓名</label>
                                    <div class="controls col-sm-6">
                                        <input placeholder="请输入姓名" id="userName" name="userName" class="form-control" type="text">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-2" for="userEmail">邮箱地址</label>
                                    <div class="controls col-sm-6">
                                        <input placeholder="请输入邮箱地址" id="userEmail" name="userEmail" class="form-control" type="text">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-2" for="userTel">电话</label>
                                    <div class="controls col-sm-6">
                                        <input placeholder="请输入电话号码" id="userTel" name="userTel" class="form-control" type="text">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-2">询问内容</label>
                                    <div class="controls col-sm-6">
                                        <label class="checkbox">
                                            <input value="价格询问" type="checkbox">
                                            价格询问
                                        </label>
                                        <label class="checkbox">
                                            <input value="预约看房时间" type="checkbox">
                                            预约看房时间
                                        </label>
                                        <label class="checkbox">
                                            <input value="索取房产文件" type="checkbox">
                                            索取房产文件
                                        </label>
                                        <label class="checkbox">
                                            <input value="被告知相同房产" type="checkbox">
                                            被告知相同房产
                                        </label>
                                    </div>
                                </div>
                                <div class="form-group ">
                                    <label class="control-label col-sm-2">邮件正文</label>
                                    <div class="controls col-sm-6">
                                        <div class="textarea" >
                                            <textarea type="" class="" id="emailContent" name="emailContent" rows="6" cols="55"> </textarea>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-2"></label>
                                    <div class="controls col-sm-6">
                                        <button class="btn btn-primary">发送邮件</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3 column">
            <div class="row clearfix ">
            </div>
            <div class="row clearfix ">
                <img data-src="holder.js/250x300" class="img-rounded">
            </div>
            <div class="row clearfix ">
            </div>
            <div class="row clearfix">
                <img data-src="holder.js/250x300" class="img-rounded">
            </div>
            <div class="row clearfix ">
            </div>
            <div class="row clearfix ">
                <img data-src="holder.js/250x300" class="img-rounded">
            </div>
        </div>
    </div>
    <div class="col-md-1 column"></div>
</div>
</body>
</html>
