<script src="${ctx}/static/libs/script/ajax/core.js"></script>
<link href="${ctx}/static/libs/style/ajax/ajax.css" rel="stylesheet">
<div class="nav burl">
    <ul>
        <#if classifyId?? >
            <li><a href="${ctx}/">首页</a></li>
            <#list classifyList as classify>
                <#if classifyId == classify.id>
                    <li class="active"><a href="${ctx}/classify/${classify.id}">${classify.name}</a></li>
                <#else>
                    <li><a href="${ctx}/classify/${classify.id}">${classify.name}</a></li>
                </#if>
            </#list>
        <#else>
            <li class="active"><a href="${ctx}/">首页</a></li>
            <#list classifyList as classify>
                <li><a href="${ctx}/classify/${classify.id}">${classify.name}</a></li>
            </#list>
        </#if>

    </ul>
</div>
<#if LOGIN_USER ??>
    <div class="user">
        <img src="${ctx}/static/libs/images/avatar.png">
        ${LOGIN_USER.nicker!'管理员'}
        <embed src="${ctx}/static/libs/images/down.svg" class="down">
        <div>
            <div style="height: 10px"></div>
            <div class="show-block burl">
                <ul>
<#--                    <li><div class="list-item"><img src="${ctx}/static/libs/images/logout.svg">后台管理</div></li>-->
                    <li onclick="javascript:location.href = '${ctx}/admin';"><div class="list-item"><img src="${ctx}/static/libs/images/logout.svg">后台管理</div></li>
                    <li id="nav-logout-btn"><div class="list-item"><img src="${ctx}/static/libs/images/logout.svg">退出</div></li>
                </ul>
            </div>
        </div>
    </div>
<#else>
    <div class="user">
        <span id="nav-login-btn">登录</span>
    </div>
    <div class="login-bg burl" id="login-box-switch">
        <div class="login-box">
            <h1>管理员登录</h1>
            <div class="box-content">
                <input type="text" id="username-input" placeholder="请输入账号">
                <input type="password" id="password-input" placeholder="请输入密码">
            </div>
            <div class="box-line"></div>
            <div class="button-group">
                <button id="close-login-btn">取消</button>
                <button id="box-login-btn">登录</button>
            </div>
        </div>
    </div>
</#if>

<!-- 小冰 -->
<div class="chat" id="chat">
    <img src="/static/libs/images/imgres.png">
</div>
<div class="chat-box">
    <div class="title">与人工智能【微软小冰】对话<span class="close">X</span></div>
    <iframe src="/static/bing-chat.html" style="
        overflow: hidden;
        border: none;
        height: calc(100% - 40px);
        min-height: 360px;
        width: 100%">
    </iframe>
</div>

<style>
    .chat{
        position: fixed;
        bottom: 20px;
        right: 20px;
        width: 60px;
        height: 60px;
        background-color: white;
        border-radius: 50%;
        cursor: pointer;
        overflow: hidden;
    }
    .chat img{
        height: 60px;
        width: 60px;
    }
    .chat-box{
        position: fixed;
        min-height: 400px;
        min-width: 500px;
        z-index: 10;
        left: calc(50% - 250px);
        top: 100px;
        background-color: white;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 0 10px 0 rgba(0, 0, 0, .8);
        display: none;
    }
    .chat-box .title{
        text-align: center;
        background-color: #25292E;
        line-height: 40px;
        color: white;
        cursor: default;
    }
    .chat-box .title span{
        display: inline-block;
        float: right;
        margin-right: 10px;
        cursor: pointer;
    }
</style>


<script src="${ctx}/static/libs/script/jquery-2.0.2.js"></script>
<script src="${ctx}/static/libs/script/move.js"></script>
<script>
    // 弹出登录窗口

    $("#nav-login-btn").click(function () {
        openLoginBox();
    });

    // 关闭登录窗口
    $("#close-login-btn").click(function () {
        closeLoginBox();
    });

    // 退出登录
    $("#nav-logout-btn").click(function () {
        H.post("${ctx}/api/v1/user/logout", function (res) {
            location.href = location.href;
        });
    });

    function openLoginBox() {
        document.getElementById("login-box-switch").style.bottom = "0";
        document.getElementById("login-box-switch").style.backgroundColor = "rgba(0, 0, 0, .6)";
        document.getElementsByClassName("login-box")[0].style.marginTop = "150px";
        document.getElementsByClassName("login-box")[0].style.display = "block";
        setTimeout(() => {
            document.getElementsByClassName("login-box")[0].style.opacity = "1";
            document.getElementsByClassName("login-box")[0].style.marginTop = "200px";
        }, 100)
    }

    function closeLoginBox() {
        document.getElementById("login-box-switch").style.backgroundColor = "rgba(0, 0, 0, .0)";
        document.getElementsByClassName("login-box")[0].style.marginTop = "150px";
        document.getElementsByClassName("login-box")[0].style.opacity = "0";
        setTimeout(() => {
            document.getElementById("login-box-switch").style.bottom = "100vh";
            document.getElementsByClassName("login-box")[0].style.display = "none";
        }, 300)
    }

    // 开始登录
    $("#box-login-btn").click(function () {
        let data = {
            email: document.getElementById("username-input").value,
            password: document.getElementById("password-input").value
        };
        if (!data.email){
            H.msg("用户名不能为空");
            return;
        }
        if (!data.password){
            H.msg("密码不能为空")
            return;
        }
        H.post("${ctx}/api/v1/user/login", data, function (res) {
            setCookie("token", res.responseBody.token, 1);
            location.href = location.href;
        });
    });

    function setCookie(cname, cvalue, exdays) {
        let d = new Date();
        d.setTime(d.getTime() + (exdays*24*60*60*1000));
        let expires = "expires=" + d.toUTCString();
        document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
    }

    // 打开聊天窗口
    $("#chat").click(function (){
        $(".chat-box").css("display", "block");
    });

    // 移动窗口
    let down = false;
    let $title = $(".chat-box .title");
    let initLeft = 0;
    let initTop = 0;
    let $box = $(".chat-box");
    $title.mousedown(function (a){
        initLeft = a.offsetX;
        initTop = a.offsetY;
        down = true;
    });
    $title.mouseup(function (){
        down = false;
    });
    $title.mousemove(function (a){
        if (down){
            $box.css("left", a.clientX - initLeft);
            $box.css("top", a.clientY - initTop);
        }
    });
    $(".chat-box .title span.close").click(function (){
        $(".chat-box").css("display", "none");
    });
</script>