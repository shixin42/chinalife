<!--user register module-->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <div class="panel panel-info" >
        <div class="panel-heading">
            <div class="panel-title">注册</div>
        </div>
        <div class="panel-body" >
            <div class="col-md-1"></div>
            <div class="col-md-10">
                <form role="form" id="userRegisterForm" class="form-horizontal" action="/chinalife/register" method="post">
                    <label class="label-danger">
                        <c:if test="${requestScope.error != null}">
                            <c:forEach items="${requestScope.error.errorInfo}" var="entry">
                                <h1>${entry.value}</h1>
                            </c:forEach>
                        </c:if>
                    </label>
                    <div class="form-group">
                        <label for="nickname" class="control-label col-md-2">用户名</label>
                        <div class="col-md-8">
                            <input type="text" class="form-control" id="nickname" name="nickname"
                                   placeholder="请输入用户名">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email" class="control-label col-md-2">邮箱地址</label>
                        <div class="col-md-8">
                            <input type="email" class="form-control" id="email" name="email"
                                   placeholder="请输入邮箱地址">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="password" class="control-label col-md-2">密码</label>
                        <div class="col-md-8">
                            <input type="password" class="form-control" id="password" name="password"
                                   placeholder="请输入密码">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="passwordAgain" class="control-label col-md-2">密码确认</label>
                        <div class="col-md-8">
                            <input type="password" class="form-control" id="passwordAgain" name="passwordAgain" placeholder="请再输入一次">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="optionsRadios1" class="control-label col-md-2">用户类型</label>
                        <div class="col-md-2 radio">
                            <label>
                                <input type="radio" name="category" id="optionsRadios1" value="business" checked>
                                商家用户
                            </label>
                        </div>
                        <div class="col-md-2 radio">
                            <label>
                                <input type="radio" name="category" id="optionsRadios2" value="customer">
                                个人用户
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-2"></div>
                        <div class="checkbox col-md-8">
                            <label>
                                <input id="commitment" type="checkbox" name="commitment" value="1">
                                我已经阅读并同意 <a href="#">《chinalife相关协议条款》</a>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-2"></div>
                        <div class="col-md-8">
                            <button type="submit" class="btn btn-success btn-lg">注册用户</button>
                        </div>
                    </div>
                </form>
            </div>
            <div class="col-md-1"></div>
        </div>
        <div class="panel-footer">
            <a href="/chinalife/jsp/user/userLogon.jsp">
                已有账户，点击直接登录
            </a>
        </div>
    </div>
