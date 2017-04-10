<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/3/6
  Time: 17:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../commons/jsptag.jsp"%>
<html>
<head>
    <title>所有直播-qjTV</title>
    <%@include file="../commons/headjs.jsp"%>
</head>
<script>
    $(function(){

    })
</script>
<body>
<nav class="navbar navbar-default" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="#">shuTV</a>
        </div>
        <div>
            <ul class="nav navbar-nav">
                <li><a href="#">首页</a></li>
                <li  class="active"><a href="#">直播</a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        分类
                        <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="#">jmeter</a></li>
                        <li><a href="#">EJB</a></li>
                        <li><a href="#">Jasper Report</a></li>
                        <li class="divider"></li>
                        <li><a href="#">分离的链接</a></li>
                        <li class="divider"></li>
                        <li><a href="#">另一个分离的链接</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>
<div class="container">
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
                            <img src="${ctx}/upload/cover/${item.img}" width="270" height="180" alt="点击进入直播间">
                        </a>
                        <strong>${item.title}</strong>
                        <br><strong id="${item.roomnum}online">0</strong>
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
</div>
</body>
</html>
