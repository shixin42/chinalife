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
    <title>House Add</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="../../css/bootstrap.css">
    <!-- CSS to style the file input field as button and adjust the Bootstrap progress bars -->
    <link rel="stylesheet" href="../../css/jquery.fileupload.css">
    <link rel="stylesheet" href="../../css/jquery.fileupload-ui.css">
    <script src="../../js/jquery-1.10.1.js"></script>
    <!-- The jQuery UI widget factory, can be omitted if jQuery UI is already included -->
    <script src="../../js/upload/jquery.ui.widget.js"></script>
    <!-- The Templates plugin is included to render the upload/download listings -->
    <script src="../../js/upload/tmpl.min.js"></script>
    <!-- The Load Image plugin is included for the preview images and image resizing functionality -->
    <script src="../../js/upload/load-image.min.js"></script>
    <!-- The Canvas to Blob plugin is included for image resizing functionality -->
    <script src="../../js/upload/canvas-to-blob.min.js"></script>
    <!-- Bootstrap JS is not required, but included for the responsive demo navigation -->
    <script src="../../js/bootstrap.js"></script>
    <!-- blueimp Gallery script -->
    <script src="../../js/upload/blueimp-gallery.js"></script>
    <!-- The Iframe Transport is required for browsers without support for XHR file uploads -->
    <script src="../../js/upload/jquery.iframe-transport.js"></script>
    <!-- The basic File Upload plugin -->
    <script src="../../js/upload/jquery.fileupload.js"></script>
    <!-- The File Upload processing plugin -->
    <script src="../../js/upload/jquery.fileupload-process.js"></script>
    <!-- The File Upload image preview & resize plugin -->
    <script src="../../js/upload/jquery.fileupload-image.js"></script>
    <!-- The File Upload validation plugin -->
    <script src="../../js/upload/jquery.fileupload-validate.js"></script>
    <!-- The File Upload user interface plugin -->
    <script src="../../js/upload/jquery.fileupload-ui.js"></script>
    <script src="/chinalife/js/jquery.validate.js" type="text/javascript"></script>
    <script type="application/javascript" language="JavaScript">
        $(function () {
            // validate the comment form when it is submitted
            //$("#commentForm").validate();
//            $("#formHouseAdd").validate({
//                rules: {
//                    title: {
//                        required: true,
//                        minlength: 6
//                    },
//                    selectDistrict: "required",
//                    selectStatus: "required",
//                    address: {
//                        required: true,
//                        minlength: 6
//                    },
//                    selectType: "required",
//                    room: {
//                        required: true,
//                        digits: true
//                    },
//                    toilet: {
//                        required: true,
//                        digits: true
//                    },
//                    carport: {
//                        required: true,
//                        digits: true
//                    }
//                },
//
//                messages: {
//                    title: {
//                        required: "Please enter the title",
//                        minlength: "you need to text at least 6 chacaters",
//                        selectStatus: "you need to enter the status of the house"
//                    },
//                    selectStatus: "you need to enter the status of the house",
//                    address: {
//                        required: "Please enter the address",
//                        minlength: "you need to text at least 6 chacaters"
//                    },
//                    selectType: "you need to select a status for the house",
//                    room: {
//                        required: "Please provide a password",
//                        digits: "you need input a digit"
//                    },
//                    toilet: {
//                        required: "Please provide a password",
//                        digits: "you need input a digit"
//                    },
//                    carport: {
//                        required: "Please provide a password",
//                        digits: "you need input a digit"
//                    }
////                    debug : true
////                    confirm_password: {
////                        required: "Please provide a password",
////                        minlength: "Your password must be at least 5 characters long",
////                        equalTo: "Please enter the same password as above"
////                    },
////                    email: "Please enter a valid email address",
////                    agree: "Please accept our policy"
//                },
//                //设置错误信息显示的位置
//                errorPlacement: function (error, element) {
//                    //alert(error+":"+element.);
//                    if (element.is(":radio"))
//                        error.appendTo(element.parent().next().next());
//                    else if (element.is(":checkbox"))
//                        error.appendTo(element.parent().next());
//                    else
//                        error.appendTo(element.parent());
//                }
//            });

            $('#fileupload').fileupload({
                // Uncomment the following to send cross-domain cookies:
                //xhrFields: {withCredentials: true},
                url: '/chinalife/upload'
            });
            $('#fileupload').bind('fileuploaddone', function(e, result){
                $.each(result.result.files, function (index, file) {
//                    alert("file name:"+file.name+ " url:"+ file.url+ " index:"+index);
                    $("#divForFileUpload").append("<input type='hidden' value='"+file.url+"' name='upload'>");
                });
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
    <%@ include file="/template/left.jsp" %>
</div>
<div class="col-md-9">
<div>
    <form class="form-horizontal" id="formHouseAdd" method="post" action="" enctype="multipart/form-data">
        <div id="legend" class="">
            <legend class="">House Add</legend>
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
                <select id="selectDistrict" name="district" class="form-control">
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
            <label class="col-md-2 control-label">房屋状态</label>

            <div class="col-md-4 controls">
                <select class="form-control" id="selectStatus" name="status">
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
                <select class="form-control" id="selectType" name="type">
                    <option value="">请选择</option>
                    <option value="House">房子House</option>
                    <option value="Apartmen">公寓Apartment</option>
                    <option value="Unit">单位Unit</option>
                    <option value="Townhouse">联排别墅Townhouse</option>
                    <option value="Land">土地Land</option>
                    <option value="Commercial estate">商业地产Commercial estate</option>
                    <option value="Others">其他Others</option>
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
                       name="min_price">
            </div>
            <div class="col-xs-2">
                <label class="control-label" for="high_price">万</label>
            </div>
            <div class="col-md-2 controls">
                <input placeholder="最高售价" class="form-control" id="low_price" type="text"
                       name="max_price">
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
        <%--div for file upload input hidden--%>
        <div class="form-group" id="divForFileUpload">

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
    <form id="fileupload" action="/chinalife/upload" method="POST" enctype="multipart/form-data">
        <!-- The fileupload-buttonbar contains buttons to add/delete files and start/cancel the upload -->
        <div class="row fileupload-buttonbar">
            <div class="col-lg-7">
                <!-- The fileinput-button span is used to style the file input field as button -->
                <span class="btn btn-success fileinput-button">
                    <i class="glyphicon glyphicon-plus"></i>
                    <span>Add files...</span>
                    <input type="file" name="files[]" multiple>
                </span>
                <button type="submit" class="btn btn-primary start">
                    <i class="glyphicon glyphicon-upload"></i>
                    <span>Start upload</span>
                </button>
                <button type="reset" class="btn btn-warning cancel">
                    <i class="glyphicon glyphicon-ban-circle"></i>
                    <span>Cancel upload</span>
                </button>
                <button type="button" class="btn btn-danger delete">
                    <i class="glyphicon glyphicon-trash"></i>
                    <span>Delete</span>
                </button>
                <input type="checkbox" class="toggle">
                <!-- The global file processing state -->
                <span class="fileupload-process"></span>
            </div>
            <!-- The global progress state -->
            <div class="col-lg-5 fileupload-progress fade">
                <!-- The global progress bar -->
                <div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100">
                    <div class="progress-bar progress-bar-success" style="width:0%;"></div>
                </div>
                <!-- The extended global progress state -->
                <div class="progress-extended">&nbsp;</div>
            </div>
        </div>
        <!-- The table listing the files available for upload/download -->
        <table role="presentation" class="table table-striped"><tbody class="files"></tbody></table>

    </form>
</div>
</div>
</div>
</div>
<script id="template-upload" type="text/x-tmpl">
{% for (var i=0, file; file=o.files[i]; i++) { %}
    <tr class="template-upload fade">
        <td>
            <span class="preview"></span>
        </td>
        <td>
            <p class="name">{%=file.name%}</p>
            <strong class="error text-danger"></strong>
        </td>
        <td>
            <p class="size">Processing...</p>
            <div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0"><div class="progress-bar progress-bar-success" style="width:0%;"></div></div>
        </td>
        <td>
            {% if (!i && !o.options.autoUpload) { %}
                <button class="btn btn-primary start" disabled>
                    <i class="glyphicon glyphicon-upload"></i>
                    <span>Start</span>
                </button>
            {% } %}
            {% if (!i) { %}
                <button class="btn btn-warning cancel">
                    <i class="glyphicon glyphicon-ban-circle"></i>
                    <span>Cancel</span>
                </button>
            {% } %}
        </td>
    </tr>
{% } %}
</script>
<!-- The template to display files available for download -->
<script id="template-download" type="text/x-tmpl">
{% for (var i=0, file; file=o.files[i]; i++) { %}
    <tr class="template-download fade">
        <td>
            <span class="preview">
                {% if (file.thumbnailUrl) { %}
                    <a href="{%=file.url%}" title="{%=file.name%}" download="{%=file.name%}" data-gallery><img src="{%=file.thumbnailUrl%}" width="80" height="60"></a>
                {% } %}
            </span>
        </td>
        <td>
            <p class="name">
                {% if (file.url) { %}
                    <a href="{%=file.url%}" title="{%=file.name%}" download="{%=file.name%}" {%=file.thumbnailUrl?'data-gallery':''%}>{%=file.name%}</a>
                {% } else { %}
                    <span>{%=file.name%}</span>
                {% } %}
            </p>
            {% if (file.error) { %}
                <div><span class="label label-danger">Error</span> {%=file.error%}</div>
            {% } %}
        </td>
        <td>
            <span class="size">{%=o.formatFileSize(file.size)%}</span>
        </td>
        <td>
            {% if (file.deleteUrl) { %}
                <button class="btn btn-danger delete" data-type="{%=file.deleteType%}" data-url="{%=file.deleteUrl%}"{% if (file.deleteWithCredentials) { %} data-xhr-fields='{"withCredentials":true}'{% } %}>
                    <i class="glyphicon glyphicon-trash"></i>
                    <span>Delete</span>
                </button>
                <input type="checkbox" name="delete" value="1" class="toggle">
            {% } else { %}
                <button class="btn btn-warning cancel">
                    <i class="glyphicon glyphicon-ban-circle"></i>
                    <span>Cancel</span>
                </button>
            {% } %}
        </td>
    </tr>
{% } %}
</script>
</body>
</html>