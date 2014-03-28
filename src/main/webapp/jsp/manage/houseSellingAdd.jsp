<%--
  Created by IntelliJ IDEA.
  User: Chao.Cui.VWED
  Date: 14-3-19
  Time: 下午11:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <c:import url="/template/importedFiles.html"/>
    <script type="application/javascript" language="JavaScript">
        $().ready(function() {
            // validate the comment form when it is submitted
            //$("#commentForm").validate();
            $("#formHouseAdd").validate({
                rules: {
                    title: {
                        required : true,
                        minlength : 6
                    },
                    selectDistrict : "required",
                    selectStatus : "required",
                    address :{
                        required : true,
                        minlength : 6
                    },
                    selectType : "required",
                    room : {
                        required : true,
                        digits : true
                    },
                    toilet : {
                        required : true,
                        digits : true
                    },
                    carport : {
                        required : true,
                        digits : true
                    }


                },
                messages: {
                    title: {
                        required : "Please enter the title",
                        minlength : "you need to text at least 6 chacaters",
                        selectStatus : "you need to enter the status of the house"
                    },
                    selectStatus: "you need to enter the status of the house",
                    address: {
                        required: "Please enter the address",
                        minlength: "you need to text at least 6 chacaters"
                    },
                    selectType : "you need to select a status for the house",
                    room: {
                        required: "Please provide a password",
                        digits: "you need input a digit"
                    },
                    toilet: {
                        required: "Please provide a password",
                        digits: "you need input a digit"
                    },
                    carport: {
                        required: "Please provide a password",
                        digits: "you need input a digit"
                    }
//                    debug : true
//                    confirm_password: {
//                        required: "Please provide a password",
//                        minlength: "Your password must be at least 5 characters long",
//                        equalTo: "Please enter the same password as above"
//                    },
//                    email: "Please enter a valid email address",
//                    agree: "Please accept our policy"
                },
                //设置错误信息显示的位置
                errorPlacement: function(error, element) {
                    //alert(error+":"+element.);
                    if ( element.is(":radio") )
                        error.appendTo( element.parent().next().next() );
                    else if ( element.is(":checkbox") )
                        error.appendTo (  element.parent().next());
                    else
                        error.appendTo( element.parent());
                }
            });
        })
    </script>
</head>
<body>
<!--navigation for left area-->
<%@ include file="/template/header.jsp" %>
<div class="container">
    <div class="row clearfix">
        <div class="col-md-3">
            <%@ include file="/template/left.jsp"%>
        </div>
        <div class="col-md-9">
            <div>
                <form class="form-horizontal" id="formHouseAdd" enctype="multipart/form-data"
                      method="post">
                    <div id="legend" class="">
                        <legend class="">表单名</legend>
                    </div>
                    <%--div for title--%>
                    <div class="form-group">
                        <label class="col-md-2 control-label" for="title">标题</label>
                        <div class="col-md-6 controls">
                            <input placeholder="请填写标题" class="form-control" id="title" type="text"
                                   name="title">
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <%--div for district--%>
                    <div class="form-group">
                        <label class="col-md-2 control-label">区域选择</label>
                        <div class="col-md-4 controls">
                            <select id="selectDistrict" name="selectDistrict" class="form-control">
                                <option value="">请选择</option>
                                <option value="central">市中心</option>
                                <option value="southEast">东南区</option>
                                <option value="north">北区</option>
                                <option value="northEast">东北区</option>
                                <option value="east">东区</option>
                                <option value="south">南区</option>
                                <option value="west">西区</option>
                                <option value="northWest">西北区</option>
                                <option value="southWest">西南区</option>
                            </select>
                        </div>
                        <div class="col-md-6"></div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label" >房屋状态</label>
                        <div class="col-md-4 controls">
                            <select class="form-control" id="selectStatus" name="selectStatus">
                                <option value="">请选择</option>
                                <option value="onSaling">在售</option>
                                <option value="onAuction">拍卖</option>
                                <option value="onSigning">正在签约</option>
                                <option value="onSaled">出售</option>
                            </select>
                        </div>
                        <div class="col-md-6"></div>
                    </div>
                    <%--div for house address--%>
                    <div class="form-group">
                        <label class="col-md-2 control-label" for="address">房屋地址</label>
                        <div class="col-md-8 controls">
                            <input placeholder="请输入房屋地址" class="form-control" id="address" type="text"
                                   name="address">
                        </div>
                        <div class="col-md-2"></div>
                    </div>
                    <%--div for house type--%>
                    <div class="form-group">
                        <label class="col-md-2 control-label" for="selectType">房屋类型</label>
                        <div class="col-md-6 controls">
                            <select class="form-control" id="selectType" name="selectType">
                                <option  value="">请选择</option>
                                <option  value="House">房子House</option>
                                <option  value="Apartmen">公寓Apartment</option>
                                <option  value="Unit">单位Unit</option>
                                <option  value="Townhouse">联排别墅Townhouse</option>
                                <option  value="Land">土地Land</option>
                                <option  value="Commercial estate">商业地产Commercial estate</option>
                                <option  value="Others">其他Others</option>
                            </select>
                        </div>
                        <div class="col-md-2"></div>
                    </div>
                    <%--div for house status--%>
                    <div class="form-group">
                        <label class="col-md-2 control-label">房屋情况</label>
                        <div class="col-md-6 controls">
                            <div class="row">
                                <div class="col-xs-2">
                                    <input type="text" class="form-control" id="room" placeholder=""
                                           name="room">
                                </div>
                                <div class="col-xs-1">
                                    <label class="control-label" for="room">室</label>
                                </div>
                                <div class="col-xs-2">
                                    <input type="text" class="form-control" id="toilet" placeholder=""
                                           name="toilet">
                                </div>
                                <div class="col-xs-1">
                                    <label class="control-label" for="toilet">卫</label>
                                </div>
                                <div class="col-xs-2">
                                    <input type="text" class="form-control" id="carport" placeholder=""
                                           name="carport">
                                </div>
                                <div class="col-xs=3">
                                    <label class="control-label" for="carport">车库</label>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <%--div for house area--%>
                    <div class="form-group">
                        <label class="col-md-2 control-label" for="inputForArea">面积</label>
                        <div class="col-md-2 controls">
                            <input placeholder="placeholder" class="form-control" id="inputForArea" type="text"
                                   name="area">
                        </div>
                        <div class="col-md-2">
                            <label class="control-label" for="inputForArea">平方米</label>
                        </div>
                        <div class="col-md-6"></div>
                    </div>
                    <%--div for high price and low price--%>
                    <div class="form-group">
                        <label class="col-md-2 control-label" for="high_price">售价</label>
                        <div class="col-md-2 controls">
                            <input placeholder="最低售价" class="form-control" id="high_price" type="text"
                                   name="high_price">
                        </div>
                        <div class="col-xs-2">
                            <label class="control-label" for="high_price">万</label>
                        </div>
                        <div class="col-md-2 controls">
                            <input placeholder="最高售价" class="form-control" id="low_price" type="text"
                                   name="low_price">
                        </div>
                        <div class="col-xs-2">
                            <label class="control-label" for="low_price">万</label>
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <%--div for house description textarea--%>
                    <div class="form-group">
                        <label class="col-md-2 control-label" for="inputForDetail">描述</label>
                        <div class="col-md-6 controls">
                            <div class="textarea">
                                <textarea class="form-control" id="inputForDetail" rows="6"
                                          name="description"> </textarea>
                            </div>
                        </div>
                        <div class="col-md-2"></div>
                    </div>
                    <%--div for first contact--%>
                    <div class="form-group">
                        <label class="col-md-2 control-label" for="first_contact_name">第一联系人</label>
                        <div class="col-md-3 controls">
                            <input placeholder="联系人姓名" class="form-control" id="first_contact_name" type="text"
                                   name="first_contact_name">
                        </div>
                        <div class="col-md-3 controls pull-left">
                            <input placeholder="联系人电话" class="form-control" id="first_contact_phone" type="text"
                                   name="first_contact_phone">
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <%--div for second contact--%>
                    <div class="form-group">
                        <label class="col-md-2 control-label" for="second_contact_name">第二联系人</label>
                        <div class="col-md-3 controls">
                            <input placeholder="联系人姓名" class="form-control" id="second_contact_name" type="text"
                                   name="second_contact_name">
                        </div>
                        <div class="col-md-3">
                            <input placeholder="联系人电话" class="form-control" id="second_contact_phone" type="text"
                                   name="second_contact_phone">
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <%--div for file upload--%>
                    <div class="form-group">
                        <label class="col-md-2 control-label">File Button</label>

                        <div class="col-md-6 controls">
                            <input class="input-file" id="fileInput" type="file" name="picture">
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <%--div for submit button--%>
                    <div class="form-group">
                        <label class="col-md-2 control-label"></label>

                        <div class="col-md-6 controls">
                            <button type="submit" class="btn btn-primary">Submit</button>
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>