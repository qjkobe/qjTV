<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/3/1
  Time: 15:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../commons/jsptag.jsp"%>
<html>
<head>
    <title>首页</title>
    <%@include file="../commons/headjs.jsp"%>
</head>
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
                                $("#weikaibos").html("还没有未关注的主播开播");
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
<body>
<nav class="navbar navbar-default" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="#">shuTV</a>
        </div>
        <div>
            <ul class="nav navbar-nav">
                <li class="active"><a href="#">首页</a></li>
                <li><a href="#">直播</a></li>
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

<div class="container">
    <div class="row">
        <div class="col-md-4">
            <c:if test="${liveroom == 'none'}">
                当前没有任何直播
            </c:if>
            <c:if test="${liveroom != 'none'}">
                <a href="/index/toRoom/${liveroom.roomnum}" title="点击进入直播间">
                    <img src="${ctx}/upload/cover/${liveroom.img}" width="300" height="200" alt="点击进入直播间">
                </a><br>
                <strong>${liveroom.title}</strong>
            </c:if>
        </div>
    </div>
</div>
</body>
</html>
