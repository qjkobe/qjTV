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
        <div class="col-md-4">
            <c:if test="${liveroom == 'none'}">
                当前没有任何直播
            </c:if>

            <ul class="" id="">
                <%--获得直播间，每获取四个，就增加一个li--%>
                <c:forEach items="${liverooms}" var="item" varStatus="st">
                    <c:if test="${st.count % 4==1}">
                        <li>
                    </c:if>
                    <a href="/index/toRoom/${item.roomnum}" title="点击进入直播间">
                        <img src="${ctx}/upload/cover/${item.img}" alt="点击进入直播间">
                    </a><br>
                    <strong>${item.title}</strong>
                    <c:if test="${st.count % 4==0}">
                        </li>
                    </c:if>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>
</body>
</html>