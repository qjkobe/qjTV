<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/2/27
  Time: 10:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../commons/jsptag.jsp"%>
<!DOCTYPE html>
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
    <meta charset="utf-8"/>
    <title>QjTV-后台管理</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport"/>
    <meta content="" name="description"/>
    <meta content="" name="author"/>
    <%@include file="../commons/userheadjs.jsp"%>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href="${ctx}/theme/assets/global/plugins/select2/select2.css"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/theme/assets/global/plugins/datatables/extensions/Scroller/css/dataTables.scroller.min.css"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/theme/assets/global/plugins/datatables/extensions/ColReorder/css/dataTables.colReorder.min.css"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/theme/assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.css"/>
    <!-- END PAGE LEVEL STYLES -->
</head>
<!-- END HEAD -->
<%
    menuActive = "gift";
    subMenuActive = "gift";
%>
<script>
    $(function(){
        $("#goZhibo").click(function(){
            window.location.href = "/user/myZhibo?userId=${user.id}";
        });

        $(".fangguan").click(function(){
            $.ajax({
                type: "POST",
                url: "/manage/fangguan",
                data: {
                    uid: $(this).data("uid"),
                },
                dataType: "json",
                success: function(data){
                    temp = eval(data);
                    if(temp.status == "success"){
                        alert("任命管理员成功");
                    }else if(temp.status == "noaccess"){
                        alert("你没有权限这么做");
                    }
                },
                error: function(data){
                    alert("系统错误");
                }
            });
        })
    });
</script>
<!-- BEGIN BODY -->
<body class="page-md page-boxed page-header-fixed page-sidebar-closed-hide-logo page-container-bg-solid page-sidebar-closed-hide-logo">
<%@include file="../commons/usertop.jsp"%>
<div class="clearfix">
</div>
<!-- BEGIN CONTAINER -->
<div class="container">
    <div class="page-container">
        <%@include file="../commons/userleft.jsp"%>
        <!-- BEGIN CONTENT -->
        <div class="page-content-wrapper">
            <div class="page-content">
                <!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->
                <div class="modal fade" id="portlet-config" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                <h4 class="modal-title">Modal title</h4>
                            </div>
                            <div class="modal-body">
                                Widget settings form goes here
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn blue">Save changes</button>
                                <button type="button" class="btn default" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal-dialog -->
                </div>
                <!-- /.modal -->
                <!-- END SAMPLE PORTLET CONFIGURATION MODAL FORM-->
                <!-- BEGIN PAGE HEADER-->
                <h3 class="page-title">
                    关注管理</h3>
                <div class="page-bar">
                    <ul class="page-breadcrumb">
                        <li>
                            <i class="fa fa-home"></i>
                            <a href="index.html">关注管理</a>
                            <i class="fa fa-angle-right"></i>
                        </li>
                        <li>
                            <a href="#">关注管理</a>
                        </li>
                    </ul>
                </div>
                <!-- END PAGE HEADER-->
                <div class="row">
                    <div class="col-md-7">
                        <!-- BEGIN EXAMPLE TABLE PORTLET-->
                        <div class="portlet box blue-hoki">
                            <div class="portlet-title">
                                <div class="caption">
                                    <i class="fa fa-globe"></i>关注列表
                                </div>
                            </div>
                            <div class="portlet-body">
                                <table class="table table-striped table-bordered table-hover" id="sample_1">
                                    <thead>
                                    <tr>
                                        <th>
                                            用户昵称
                                        </th>
                                        <th>
                                            送礼积分
                                        </th>
                                        <th class="hidden-xs">
                                            操作
                                        </th>
                                        <th class="hidden-xs" style="display: none;">

                                        </th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:if test="${giftList == 'nogift'}">
                                        <tr>
                                            <td >
                                                还没有人给你送礼过
                                            </td>
                                            <td >
                                                0
                                            </td>
                                            <td >
                                                真可怜啊
                                            </td>
                                            <td style="display: none;">
                                                真可怜啊
                                            </td>
                                        </tr>
                                    </c:if>
                                    <c:if test="${giftList != 'nogift'}">
                                    <c:forEach items="${giftList}" var="item" varStatus="st">
                                        <tr>
                                            <td id="${item.sendid}name">
                                                <script>
                                                    $.ajax({
                                                        type: "POST",
                                                        url: "/index/getnick",
                                                        data: {
                                                            uid: "${item.sendid}"
                                                        },
                                                        dataType: "json",
                                                        success: function(data){
                                                            temp = eval(data);
                                                            if(temp.status == "success"){
                                                                $("#${item.sendid}name").html(temp.nickname);
                                                            }
                                                        },
                                                        error: function(data){
                                                            alert("系统错误");
                                                        }
                                                    });
                                                </script>
                                            </td>
                                            <td>
                                                ${item.total}
                                            </td>
                                            <td>
                                                <button type="button" data-uid="${item.sendid}" class="btn btn-success fangguan">任命房管</button>
                                            </td>
                                            <td style="display: none;">
                                                <span>${item.id}</span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <!-- END EXAMPLE TABLE PORTLET-->
                    </div>

                    <div class="col-md-5 ">
                        <!-- BEGIN SAMPLE FORM PORTLET-->
                        <div class="portlet light">
                            <div class="portlet-title">
                                <div class="caption font-green">
                                    <i class="icon-pin font-green"></i>
                                    <span class="caption-subject bold uppercase"> 提现</span>
                                </div>
                            </div>
                            <div class="portlet-body form">
                                <form role="form" id="editform">
                                    <div class="form-body">
                                        <div class="form-group form-md-line-input form-md-floating-label has-error">
                                            <c:if test="${giftList == 'nogift'}">
                                                <input type="text" class="form-control" readonly value="0">
                                            </c:if>
                                            <c:if test="${giftList != 'nogift'}">
                                                <input type="text" class="form-control" readonly value="${giftTotal}">
                                            </c:if>
                                            <label>总金额</label>
                                        </div>
                                        <div class="form-group form-md-line-input form-md-floating-label has-error">
                                            <c:if test="${giftList == 'nogift'}">
                                                <input type="text" class="form-control" readonly value="0">
                                            </c:if>
                                            <c:if test="${giftList != 'nogift'}">
                                                <input type="text" class="form-control" readonly value="${giftTotal}">
                                            </c:if>
                                            <label>可提现金额</label>
                                        </div>
                                        <div class="form-group form-md-line-input form-md-floating-label">
                                            <input type="text" class="form-control" id="money" name="money" maxlength="6" value="">
                                            <label>提现</label>
                                            <span class="help-block">请输入提现金额...</span>
                                        </div>
                                    </div>
                                    <div class="form-actions noborder">
                                        <button type="button" class="btn blue" id="chongzhi">提现</button>
                                        <%--<button type="button" class="btn default">Cancel</button>--%>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <!-- END SAMPLE FORM PORTLET-->
                    </div>
                </div>
            </div>
        </div>
        <!-- END CONTENT -->
        <!-- BEGIN QUICK SIDEBAR -->
        <!--Cooming Soon...-->
        <!-- END QUICK SIDEBAR -->
    </div>
    <!-- END CONTAINER -->
    <!-- BEGIN FOOTER -->
    <div class="page-footer">
        <div class="page-footer-inner">
            2014 &copy; Metronic by keenthemes. <a href="http://themeforest.net/item/metronic-responsive-admin-dashboard-template/4021469?ref=keenthemes" title="Purchase Metronic just for 27$ and get lifetime updates for free" target="_blank">Purchase Metronic!</a>
        </div>
        <div class="scroll-to-top">
            <i class="icon-arrow-up"></i>
        </div>
    </div>
    <!-- END FOOTER -->
</div>
<%@include file="../commons/userfootjs.jsp"%>

<script>
    jQuery(document).ready(function() {
        Metronic.init(); // init metronic core components
        Layout.init(); // init current layout
        Demo.init(); // init demo features
        TableAdvanced.init();
    });
</script>
<!-- END JAVASCRIPTS -->
</body>
<!-- END BODY -->
</html>