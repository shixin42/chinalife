<!--
/*
* jQuery File Upload Plugin Demo 9.0.1
* https://github.com/blueimp/jQuery-File-Upload
*
* Copyright 2010, Sebastian Tschan
* https://blueimp.net
*
* Licensed under the MIT license:
* http://www.opensource.org/licenses/MIT
*/
-->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
    <meta charset="utf-8">

    <title>jQuery File Upload Demo</title>

    <!-- Bootstrap styles -->
    <link rel="stylesheet" href="../../css/bootstrap.css">

    <!-- CSS to style the file input field as button and adjust the Bootstrap progress bars -->
    <link rel="stylesheet" href="../../css/jquery.fileupload.css">
    <link rel="stylesheet" href="../../css/jquery.fileupload-ui.css">

    <c:import url="/template/js.html"/>
    <c:import url="/template/import-jquery-file-upload.html"/>

    <script type="application/javascript" language="JavaScript">
        $(function () {
            // Initialize the jQuery File Upload widget:
            $('#fileupload').fileupload({
                // Uncomment the following to send cross-domain cookies:
                //xhrFields: {withCredentials: true},
//                url: '/chinalife/upload',
//                done:function(e, data){
//                   alert("done");
//                }
//                done : function (result, textStatus, jqXHR){
//                    alert("bb");
//                },
                url: '/chinalife/upload'
            });
            $('#fileupload').bind('fileuploaddone', function (e, result) {
                $.each(result.result.files, function (index, file) {
//                    $('<p/>').text(file.name).appendTo(document.body);
//                    alert("file name:"+file.name+ " url:"+ file.url+ " index:"+index);
                    $("#divForFileUpload").append("<input type='hidden' value='" + file.url + "' name='upload'>");
                });
//                alert(result.result.toString());
            });
        });
    </script>
</head>
<body>
<div class="container">
    <h1>jQuery File Upload Demo</h1>

    <form class="form-horizontal" id="formHouseAdd" method="post" action="" enctype="multipart/form-data">
        <div class="form-group">
            <label class="col-md-2 control-label" for="title">标题</label>

            <div class="col-md-6 controls">
                <input placeholder="请填写标题" class="form-control" id="title" type="text"
                       name="title">
            </div>
            <div class="col-md-4"></div>
        </div>
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
        <div class="form-group" id="divForFileUpload">
        </div>
    </form>

    <br>
    <!-- The file upload form used as target for the file upload widget -->
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
        <table role="presentation" class="table table-striped">
            <tbody class="files"></tbody>
        </table>

    </form>
    <br>
</div>

<!-- The template to display files available for upload -->
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
