<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2017/1/30
  Time: 12:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../commons/jsptag.jsp"%>
<html>
<head>
    <title>登录</title>
    <%@include file="../commons/headjs.jsp"%>
</head>
<script>
    $(function(){
        $("#login").click(function(){
            $.ajax({
                type: "POST",
                url: "/login/login",
                data: $("#loginform").serialize(),
                dataType: "json",
                success: function(data){
                    temp = eval(data);
                    if(temp.status == "success"){
                        alert("登陆成功");
                        window.location.href = "/user/userinfo?userId=" + temp.userid;
                    }else if(temp.status == "fail"){
                        alert("用户名或密码错误");
                    }
                },
                error: function(data){
                    alert("系统错误");
                }
            });
        });
    });
</script>
<body>
<div>
    <form action="" id="loginform" method="post">
    用户名：<input type="text" id="username" name="username">
    密码：<input type="password" id="password" name="password">
        <input type="button" id="login" value="登录">
    </form>
</div>
</body>
</html>
