<%--
  Created by IntelliJ IDEA.
  User: Chao.Cui.VWED
  Date: 14-3-23
  Time: 下午4:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <c:import url="/template/importedFiles.html" />
    <link href="/chinalife/css/demo_table.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" language="javascript" src="/chinalife/js/jquery.dataTables.js"></script>
    <script type="application/javascript" language="JavaScript">
        $(document).ready(function() {
            $('#example').dataTable( {
                "sPaginationType": "full_numbers",
                "bProcessing": true
//                "sAjaxSource": 'houseData.txt'
            } );
            $('#example tbody tr').on('click', function () {
                var sTitle;
                var nTds = $('td', this);
                var sBrowser = $(nTds[1]).text();
                var sGrade = $(nTds[4]).text();

                if ( sGrade == "A" )
                    sTitle =  sBrowser+' will provide a first class (A) level of CSS support.';
                else if ( sGrade == "C" )
                    sTitle = sBrowser+' will provide a core (C) level of CSS support.';
                else if ( sGrade == "X" )
                    sTitle = sBrowser+' does not provide CSS support or has a broken implementation. Block CSS.';
                else
                    sTitle = sBrowser+' will provide an undefined level of CSS support.';
                alert( sTitle )
            } );
        } );
    </script>
    <style type="text/css">
        .dataTables_paginate {
            float: right;
            text-align: right;
        }
        .paging_full_numbers {
            width: 400px;
            height: 22px;
            line-height: 22px;
        }
    </style>
</head>
<body>
<!--navigation for left area-->
<%@ include file="/template/header.jsp"%>
<div class="container">
    <div class="row clearfix">
        <div class="col-md-3">
            <%@ include file="/template/left.jsp"%>
        </div>
        <div class="col-md-9">
            <table class="table table-hover" id="example">
                <thead>
                <tr>
                    <th>序号</th>
                    <th>标题</th>
                    <th>小区</th>
                    <th>价格</th>
                    <th>联系电话</th>
                </tr>
                </thead>
                <tbody>
                    <tr class="gradeX">
                        <td>Trident</td>
                        <td>
                            Internet
                            Explorer
                            4.0
                        </td>
                        <td>Win 95+</td>
                        <td class="center">4</td>
                        <td class="center">X</td>
                    </tr>
                    <tr class="gradeC">
                        <td>Trident</td>
                        <td>Internet
                            Explorer 5.0</td>
                        <td>Win 95+</td>
                        <td class="center">5</td>
                        <td class="center">C</td>
                    </tr>
                    <tr class="gradeX">
                        <td>Trident</td>
                        <td>
                            Internet
                            Explorer
                            4.0
                        </td>
                        <td>Win 95+</td>
                        <td class="center">4</td>
                        <td class="center">X</td>
                    </tr>
                    <tr class="gradeC">
                        <td>Trident</td>
                        <td>Internet
                            Explorer 5.0</td>
                        <td>Win 95+</td>
                        <td class="center">5</td>
                        <td class="center">C</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
