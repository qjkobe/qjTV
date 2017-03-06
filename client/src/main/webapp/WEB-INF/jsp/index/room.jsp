<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/3/6
  Time: 16:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../commons/jsptag.jsp"%>
<html>
<head>
    <title>Title</title>
    <%@include file="../commons/headjs.jsp"%>
    <script type="text/javascript" src="${ctx}/theme/flowplayer/flowplayer-3.2.8.min.js"></script>
</head>
<script>
    $(function(){

    })
</script>
<body>
<h1>主播：${zhubo.nickname}的直播间</h1>
<h2>直播标题：${liveroom.title}</h2>
<div>
    <br>
</div>
<!-- this A tag is where your Flowplayer will be placed. it can be anywhere -->
<a
        href="#"
        style="display:block;width:720px;height:576px"
        id="player">
</a>
<!-- this will install flowplayer inside previous A- tag. -->
<script>
    flowplayer("player", "${ctx}/theme/flowplayer/flowplayer-3.2.8.swf",{
        clip: {
            url: '${liveroom.stream}', //流名称
            provider: 'rtmp',
            live: true,
        },
        plugins: {
            rtmp: {
                url: '${ctx}/theme/flowplayer/flowplayer.rtmp-3.2.8.swf',
                netConnectionUrl: 'rtmp://115.159.62.204:1935/${liveroom.app}/' //服务器地址
            }
        }
    });
</script>

<p>
    <%--Sample RTMP URL (Live) is "rtmp://115.159.62.204:1935/qunima/123"--%>
</p>
</body>
</html>
