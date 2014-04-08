<!--
--user logon module
-->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="panel panel-info" >
    <div class="panel-heading">
        <div class="panel-title">Sign In
            <div class="pull-right"><a href="#">Forgot password?</a></div>
        </div>
    </div>
    <div class="panel-body" >
        <div class="col-md-1"></div>
        <div class="col-md-10">
            <div style="display:none" id="errorAlert" class="alert alert-danger col-sm-12">12</div>
            <form role="form" class="form-horizontal" id="userLogonForm"  action="/chinalife/login" method="post">
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
                        <input class="form-control" id="nickname" name="nickname" type="text" placeholder="输入用户名"/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="password" class="control-label col-md-2">密码</label>
                    <div class="col-md-8">
                        <input class="form-control" id="password" name="password" type="password" placeholder="请输入密码"/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="password" class="control-label col-md-2">验证码</label>
                    <div class="col-md-4">
                        <input class="form-control" id="captcha" name="captcha" type="text" placeholder="请输入右侧验证码"/>
                    </div>
                    <div class="col-md-4">
                        <img border=0  id="code" src="/chinalife/template/captcha.jsp">
                        <a href="javascript:changeImg()" >看不清，换一张 </a>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-2"></div>
                    <div class="checkbox col-md-8">
                        <label>
                            <input id="remember" type="checkbox" name="remember" value="1"> Remember me
                        </label>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-2"></div>
                    <button type="submit" class="btn btn-success">Login</button>
                </div>
            </form>
        </div>
        <div class="col-md-1"></div>
    </div>
    <div class="panel-footer">
        Don't have an account!
        <a href="/chinalife/jsp/user/userRegister.jsp">
            Sign Up Here
        </a>
    </div>
</div>