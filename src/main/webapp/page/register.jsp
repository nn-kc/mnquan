<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--<%@ include file="/page/commons.jsp" %>--%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-dns-prefetch-control" content="on"/>
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta content="telephone=no" name="format-detection"/>
    <meta name="version" version="201810101200">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
    <title>注册_搜券宝</title>
    <meta name="keywords" content="9.9包邮，白菜价，天天特价，优惠卷,淘券宝"/>
    <meta name="description" content="9.9包邮，白菜价，天天特价"/>
    <meta itemprop="image" content="_50x50.jpg" />
    <link rel="stylesheet" href="../../page/js/common.css">
    <link rel="stylesheet" href="../../page/js/main.css">
    <script src="../../page/js/jquery.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="../../page/js/xcConfirm.css"/>
    <script src="../../page/js/xcConfirm.js" type="text/javascript" charset="utf-8"></script>
</head>

<body data-appid="489217" data-in="1">
<link rel="stylesheet" href="../../page/js/login.css">
<div class="header_pr  ">
    <header class="icon_header">
        <a class="iconfont icon-zuojiantou" ui-back ></a>
        <div>
            注册
        </div>
    </header>
</div>
<div class="layout" >
    <h1 class="col-mar text-center">
    </h1>

    <form action="" autocomplete="off" ui-login data-type="1" data-url="?r=login/register" onSubmit="return false;" data-mta-case="register" >
        <div class="col-mar form_input_item" id="form_input_item_01" error >
            <i class="iconfont tab_fl icon-phone"></i>
            <div class="inputtext">
                <input type="text" autocomplete="off" id="accountNo"  name="accountNo" placeholder="手机号码"  />
                <i class="iconfont icon-closecircle tab col-hr close"></i>
            </div>
            <p class="input_msg">请输入正确11位的手机号码！</p>
        </div>
        <div class="col-mar form_input_item" id="form_input_item_02">
            <i class="iconfont tab_fl icon-path"></i>
            <div class="inputtext">
                <input type="password" autocomplete="off" maxLength="18" id="pwd1" name="pwd1" placeholder="请输入密码"  />
                <i class="iconfont icon-eyeclose tab col-text showPassword"></i>
            </div>
            <p class="input_msg">密码为8-16位的数字或字母！</p>
        </div>
        <div class="col-mar form_input_item" id="form_input_item_03">
            <i class="iconfont tab_fl icon-path"></i>
            <div class="inputtext">
                <input type="password" autocomplete="off" maxLength="18" id="pwd2" name="pwd2" placeholder="请再次输入密码"  />
                <i class="iconfont icon-eyeclose tab col-text showPassword"></i>
            </div>
            <p class="input_msg">密码为8-16位的数字或字母！</p>
        </div>
        <div class="col-mar form_input_item" id="form_input_item_04">
            <i class="iconfont tab_fl icon-yanzhengma"></i>
            <div class="inputtext">
                <input type="number" autocomplete="off" id="code" name="code" placeholder="请输入邀请码"  />
                <i class="iconfont icon-closecircle tab col-hr close"></i>
                <%--<a class="btn btn-outline btn-min getPhone" data-url="?r=login/codeeg" data-nc_appkey="FFFF0000000001798134" data-scene="register">获取验证码</a>--%>
            </div>
            <p class="input_msg">验证码不能为空！</p>
        </div>

        <div class="col-mar login_submit">
            <input id="my_submit" type="submit" class="btn btn-default btn-block btn-max"  value= "注册" >
            <p></p>
        </div>

       <%-- <div class="col-mar col-888 font-size-12">
            点击“注册”表示您已同意 <a href="/index.php?r=user/agreement" class="col-link">《淘券宝用户协议》</a>
        </div>--%>
    </form>

</div>

<footer class="login_footer text-center">
    已有账号？点击<a href="/app/user/center.do" class="col-link">登录</a>
</footer>
<div style="display: none;"></div>
</body>
<script>
    var domain = "http://"+window.location.host;
    var accountFlag = true;
    var pwdFlat = true;
    $("#accountNo").blur(function(){
        var tel = $("#accountNo").val(); //获取手机号
        //如果手机号码不能通过验证
        if(!(/^1[34578]\d{9}$/.test(tel))){
            $("#form_input_item_01").attr("error","true");
            accountFlag = false;
        }else {
            $("#form_input_item_01").attr("error","false");
            accountFlag = true;
        }
    })

    $("#pwd1").blur(function(){
        var pwd = $("#pwd1").val(); //密码
        if(!(/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$/.test(pwd))){
            $("#form_input_item_02").attr("error","true");
            pwdFlat = false;
        }else {
            $("#form_input_item_02").attr("error","false");
            pwdFlat = true;
        }
    })

    $("#pwd2").blur(function(){
        var pwd = $("#pwd2").val(); //密码
        if(!(/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$/.test(pwd))){
            $("#form_input_item_03").attr("error","true");
            pwdFlat = false;
        }else {
            $("#form_input_item_03").attr("error","false");
            pwdFlat = true;
        }
    })

    $('#my_submit').on('click',function(){
        if(!accountFlag){
            $("#form_input_item_01").attr("error","true");
            return;
        }
        if(!pwdFlat){
            $("#form_input_item_02").attr("error","true");
            return;
        }
        var accountNo = $("#accountNo").val(); //获取手机号
        var pwd1 = $("#pwd1").val(); //第一次输入的密码
        var pwd2 = $("#pwd2").val(); //第二次输入的密码
        var agencyCode = $("#code").val(); //邀请码
        console.log("pwd1="+pwd1)
        console.log("pwd2="+pwd2)
        if(pwd1 != pwd2){
            var txt=  "两次输入的密码不一致！";
            window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.error);
            return;
        }
        console.log(agencyCode)

        if("" == agencyCode){
            agencyCode = "000001";
        }
        $.ajax({
            url:""+"/app/user/register.do",
            async:false,
            data: {'account':accountNo,'pwd':pwd1,'agencyCode':agencyCode},
            dataType:'json',
            type:"post",
            success:function(data){
                console.log(data);
                if("1" == data){//用户名或密码不能为空！
                    var txt=  "用户名或密码不能为空,请重新登陆！";
                    window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.error);
                }
                if("2" == data){//手机号已被注册，请去登陆！
                    var txt=  "用户名或密码错误,请重新登陆！";
                    window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.error);
                }
                if("3" == data){//登陆成功
                    var txt=  "您输入的邀请码不存在！";
                    window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.error);
                }
                if("4" == data){//注册成功
                    var txt=  "您已注册成功，请去登陆";
                    window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.success);
                    window.location.href = domain+"/app/user/center.do";
                }
            }
        });
    });
</script>
</html>