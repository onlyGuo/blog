<!DOCTYPE html>
<html lang="zh-cn" style="">
<head>
    <meta charset="UTF-8">
    <title>${classify.name!''} - ${WEB_SITE.name!''}</title>
    <link href="${ctx}/static/libs/style/common.css" rel="stylesheet">
</head>
<body style="min-width: 1280px;">
    <div class="banner">
        <#include "nav.ftl">
    </div>
    <div class="sc-body" id="sc-body">
<#--        <div class="bg">-->
<#--            <div id="img-tc"></div>-->
<#--            <img data-stellar-ratio="2" src="${ctx}/static/libs/images/banner.png" id="bg-img">-->
<#--        </div>-->
        <div style="height: 80px; background-color: #181C1F"></div>
        <div class="body" data-stellar-ratio="1" style="margin-top: 0px">
            <div class="home-left">
                <div class="box user-box">
                    <img src="${ctx}/static/libs/images/head-big.png" class="head-big">
                    <div class="information">
                        <p class="nicker">John Stone</p>
                        <p class="create-time">1996-04-04</p>
                        <p class="create-time">中国 河北</p>
                    </div>
                    <div class="more-btns">
                        <ul>
                            <li><div class="icon-btns"><img src="${ctx}/static/libs/images/github.svg"></div></li>
                            <li><div class="icon-btns"><img src="${ctx}/static/libs/images/qq.svg"></div></li>
                            <li><div class="icon-btns"><img src="${ctx}/static/libs/images/email.svg"></div></li>
                            <li><div class="icon-btns"><img src="${ctx}/static/libs/images/weibo.svg"></div></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="home-right">
                <#list articleList.list as article>
                    <div class="box">
                        <div class="title-left">
                            <img src="${ctx}/static/libs/images/head-big.png">
                            <p>John Stone</p>
                        </div>
                        <div class="title-right">
                            <h1><a href="${ctx}/article/${article.id}">${article.title}</a></h1>
                            <p>${article.outline}</p>
                            <div class="line"></div>
                            <div class="title-bottom-bar">
                                <span class="left">
                                    <img src="${ctx}/static/libs/images/eye.svg"> 1642
                                </span>
                                <span class="right">${article.createTime?string('yyyy-MM-dd HH:mm:ss')}</span>
                            </div>
                        </div>
                    </div>
                </#list>

                <!-- 分页 -->
                <div class="page-btns">
                    <ul>
                        <#list page.pages as p>
                            <#if p.abst>
                                <li><span>···</span></li>
                            <#elseif p.thisPage>
                                <li><span class="this-page">${p.num}</span></li>
                            <#else>
                                <li><a href="${ctx}/${classifyLocation}/${p.num}-10"><#if p.frist><<#elseif p.last>><#else>${p.num}</#if></a></li>
                            </#if>
                        </#list>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <script>
        let leftBox = document.getElementsByClassName("home-left")[0];
        let clfy = leftBox.getBoundingClientRect().y - window.pageYOffset - 100;
        let imgTc = document.getElementById("img-tc");
        let titleBody = document.getElementsByClassName("body")[0];
        let bgImg = document.getElementById("bg-img");
        let homeRight = document.getElementsByClassName("home-right")[0];
        window.onresize = function (){
            window.scroll(0, 0);
            setTimeout(() => {
                clfy = leftBox.getBoundingClientRect().y - window.pageYOffset - 100;
            }, 50);
        }
        window.onscroll = function (e){
            // let offset = window.pageYOffset;
            // if (offset === 0){
            //     imgTc.style.height = "0";
            //     bgImg.style.opacity = 1;
            // }else{
            //     let yf = offset / 3;
            //     imgTc.style.height = yf + "px";
            //     bgImg.style.opacity = 1 - offset / 800;
            // }
            // console.log(bgImg.offsetHeight,888888)
            if (document.documentElement.scrollTop - 80 <= -60){
                leftBox.style.position = "relative";
                homeRight.style.paddingLeft = "0";
                leftBox.style.top = "0px";
            }else{
                leftBox.style.position = 'fixed';
                leftBox.style.top = "60px";
                homeRight.style.paddingLeft = "505px";
            }
        }

        // if (location.href.concat("-")){
        //     setTimeout(() => {
        //         // window.screenY(677);
        //         window.scroll(0, 500);
        //     }, 5000);
        // }


    </script>
</body>
</html>