<%--
  Created by IntelliJ IDEA.
  User: Chao.Cui.VWED
  Date: 14-3-19
  Time: 下午9:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <c:import url="/template/importedFiles.html" />
    <script type="application/javascript" language="JavaScript">
    </script>
</head>
<body>
<!--navigation for left area-->
<%--<%@ include file="chinalife/jsp/header.jsp"%>--%>
<c:import url="/template/header.jsp" />
<div class="container">
    <div class="row clearfix">
        <div class="col-md-3">
            <%@ include file="/template/left.jsp"%>
        </div>
        <div class="col-md-9">
            <div>
                <form class="form-horizontal">
                    <fieldset>
                    <div id="legend" class="">
                        <legend class="">表单名</legend>
                    </div>
                    <div class="form-group">
                        <!-- Text input-->
                        <label class="col-md-2 control-label" for="inputForTitle">用户名</label>
                        <div class="col-md-6 controls">
                            <input  class="form-control" id="inputForTitle" type="text"
                                   value=" <c:out value="${sessionScope.user.getNickname()}">未登陆</c:out>">
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <div class="form-group">
                        <!-- Text input-->
                        <label class="col-md-2 control-label" for="inputForEmail">邮箱地址</label>
                        <div class="col-md-6 controls">
                            <input  class="form-control" id="inputForEmail" type="text"
                                    value=" <c:out value="${sessionScope.user.getEmail()}">未登陆</c:out>">
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    </fieldset>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>
