<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/3/6
  Time: 17:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../commons/jsptag.jsp"%>
<!DOCTYPE html>
<!-- BEGIN HEAD -->
<head>
    <meta charset="utf-8"/>
    <title>QjTV-所有直播</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport"/>
    <%@include file="../commons/headjs.jsp"%>
</head>
<!-- END HEAD -->
<%
    menuActive = "live";
    subMenuActive = "live";
%>
<script>
    $(function(){
        $("#myFollow").click(function(){
            $.ajax({
                type: "POST",
                url: "/index/myFollow",
                dataType: "json",
                success: function(data){
                    temp = eval(data);
                    if(temp.status == "success"){
                        $("#followList").removeClass("hidden");
                        if(temp.followList == 0){
                            $("#noFollow").removeClass("hidden");
                            $("#followed").addClass("hidden");
                        }else{
                            $("#noFollow").addClass("hidden");
                            $("#followed").removeClass("hidden");
                            if(temp.kaibos == 0){
                                $("#kaibos").html("还没有关注的主播开播");
                            }else {
                                //拼接字符串
                                var result1 = "";
                                result1 += "<ul>";
                                for (i = 0; i < temp.kaibos.length; i++) {
                                    result1 += "<li>";
                                    result1 += "<a href='/index/toRoom/" + temp.kaibos[i].roomnum + "' title='点击进入直播间'>";
                                    result1 += temp.kaibos[i].title + "</a>";
                                    result1 += "</li>";
                                }
                                result1 += "</ul>";
                                $("#kaibos").html(result1);
                            }
                            if(temp.weikaibos == 0){
                                $("#weikaibos").html("还没有关注的主播未开播");
                            }else{
                                var result2 = "";
                                result2 += "<ul>";
                                for(i = 0; i < temp.weikaibos.length; i++){
                                    result2 += "<li>";
                                    result2 += "<a href='/index/toRoom/" + temp.weikaibos[i].roomnum + "' title='点击进入直播间'>";
                                    result2 += temp.weikaibos[i].title + "</a>";
                                    result2 += "</li>";
                                }
                                result2 += "</ul>";
                                $("#weikaibos").html(result2);
                            }
                        }

                    }else if(temp.status == "nologin"){
                        alert("请先登录");
                    }
                },
                error: function(data){
                    alert("系统错误");
                }
            })
        });

        $("#fold").click(function(){
            $("#followList").addClass("hidden");
        })
    })
</script>
<!-- BEGIN BODY -->
<body class="page-md page-header-fixed page-quick-sidebar-over-content page-sidebar-closed-hide-logo ">
<%@include file="../commons/top.jsp"%>
<div class="clearfix">
</div>
<!-- BEGIN CONTAINER -->
<div class="page-container">
    <%@include file="../commons/left.jsp"%>
    <!-- BEGIN CONTENT -->
    <div class="page-content-wrapper">
        <div class="page-content">
            <!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->
            <div class="modal fade" id="portlet-config" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                            <h4 class="modal-title">模态框示例</h4>
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
                所有直播 <small>我 & 你</small>
            </h3>
            <div class="page-bar">
                <ul class="page-breadcrumb">
                    <li>
                        <i class="fa fa-home"></i>
                        <a href="index.html">所有分类</a>
                        <i class="fa fa-angle-right"></i>
                    </li>
                    <li>
                        <a href="#">守望先锋</a>
                    </li>
                </ul>
            </div>
            <!-- END PAGE HEADER-->
            <button id="myFollow">我的关注</button>
            <div class="hidden" id="followList">
                <div id="noFollow" class="hidden">
                    还没有关注过主播
                </div>
                <div id="followed">
                    已开播：<br>
                    <div id="kaibos">

                    </div>
                    未开播：<br>
                    <div id="weikaibos">

                    </div>
                </div>
                <button id="fold">收起</button>
            </div>
            <div class="row">
                <c:if test="${liveroom == 'none'}">
                    当前没有任何直播
                </c:if>
                <ul class="list-group">
                    <%--获得直播间，每获取四个，就增加一个li--%>
                    <c:forEach items="${liverooms}" var="item" varStatus="st">
                        <c:if test="${st.count % 4==1}">
                        </c:if>
                        <li class="col-md-3 col-sm-3 list-group-item">
                            <a href="/index/toRoom/${item.roomnum}" title="点击进入直播间">
                                <img src="${ctx}/upload/cover/${item.img}" width="330" height="210" alt="点击进入直播间">
                            </a>
                            <br><strong>标题: </strong>
                            <strong>${item.title}</strong>
                            <br><strong>在线: </strong><strong id="${item.roomnum}online">0</strong>
                            <script>
                                $.ajax({
                                    type: "POST",
                                    url: "/index/getOnlineNum",
                                    data: {
                                        roomnum: "${item.roomnum}"
                                    },
                                    dataType: "json",
                                    success: function(data){
                                        temp = eval(data);
                                        if(temp.status == "success"){
                                            $("#${item.roomnum}online").html(temp.onlinenum);
                                        }
                                    },
                                    error: function(data){
                                        alert("系统错误");
                                    }
                                });
                            </script>
                        </li>
                        <c:if test="${st.count % 4==0}">
                        </c:if>
                    </c:forEach>
                </ul>
            </div>
            <div class="clearfix">
            </div>

        </div>
    </div>
    <!-- END CONTENT -->

</div>
<!-- END CONTAINER -->
<!-- BEGIN FOOTER -->
<div class="page-footer">
    <div class="page-footer-inner">
        2017 &copy; QjTV by QJKOBE.
    </div>
    <div class="scroll-to-top">
        <i class="icon-arrow-up"></i>
    </div>
</div>
<!-- END FOOTER -->
<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<%@include file="../commons/footjs.jsp"%>
<script>
    jQuery(document).ready(function() {
        Metronic.init(); // init metronic core componets
        Layout.init(); // init layout
        QuickSidebar.init(); // init quick sidebar
        Demo.init(); // init demo features
        Index.init();
        Index.initDashboardDaterange();
        Index.initJQVMAP(); // init index page's custom scripts
        Index.initCalendar(); // init index page's custom scripts
        Index.initCharts(); // init index page's custom scripts
        Index.initChat();
        Index.initMiniCharts();
        Tasks.initDashboardWidget();
    });
</script>
<!-- END JAVASCRIPTS -->
</body>
<!-- END BODY -->
</html>