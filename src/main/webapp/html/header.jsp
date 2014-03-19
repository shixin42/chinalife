<%--
  Created by IntelliJ IDEA.
  User: Chao.Cui.VWED
  Date: 14-3-18
  Time: 上午11:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container">
    <div class="row clearfix">
        <div class="col-md-12 column">
            <nav class="navbar navbar-default" role="navigation">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                        <span class="sr-only">Toggle navigation</span><span class="icon-bar"></span>
                        <span class="icon-bar"></span><span class="icon-bar"></span></button>
                    <a class="navbar-brand" href="./main.jsp">首页</a>
                </div>
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <li id="houseBuying">
                            <a href="houseBuying.jsp">房屋租售</a>
                        </li>
                        <li id="lifeService">
                            <a href="lifeService.jsp">生活服务</a>
                        </li>
                        <li id="lifeTips">
                            <a href="#" >生活贴士</a>
                        </li>
                        <li>
                            <a href="#">生活论坛</a>
                        </li>
                        <li>
                            <a href="#">网站设计</a>
                        </li>
                        <li id="userLogon">
                            <%--<a id="modal-964516" href="#modal-container-964516" role="button" class="btn" data-toggle="modal">用户登陆</a>--%>
                            <a href="userLogon.jsp">用户登陆</a>
                        </li>
                        <li id="userMenu" class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><%=session.getAttribute("User")%>
                                <strong class="caret"></strong></a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a href="#">用户资料</a>
                                </li>
                                <li>
                                    <a href="#">用户退出</a>
                                </li>
                                <li>
                                    <a href="#">进入我的店铺</a>
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
                    <%--<div class="modal fade" id="modal-container-964516" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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
                    </div>--%>
                </div>

            </nav>
        </div>
    </div>
</div>
