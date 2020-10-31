<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="UTF-8">
    <title>${article.title}-天涯客栈</title>
    <link href="${ctx}/static/libs/style/common.css" rel="stylesheet">
    <link href="${ctx}/static/libs/prism/prism.css" rel="stylesheet">
</head>
<body class="common-body">
<div class="banner">
    <#include "nav.ftl">
</div>
<div class="body article-body">
    <div class="home-left" style="position: fixed; top: 90px">
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
    <div class="home-right" style="padding-left: 505px">
        <div class="box article-box">
            <h1 class="title">${article.title}</h1>
            <div class="author">
                <img src="${ctx}/static/libs/images/head-big.png" class="head-img">
                <div class="author-right">
                    <h1 class="author-name">John Stone</h1>
                    <div class="title-info">
                        <span>${article.createTime}</span>
                        <span>
                            <img src="${ctx}/static/libs/images/eye.svg"> 1642
                        </span>
                    </div>
                </div>
            </div>
            <div class="article-content line-numbers">
                ${article.content}
            </div>
        </div>


        <div class="box article-box" id="comment-block-id">
            <input class="block-input" placeholder="请输入您的邮箱" name="email" autocomplete="off" id="comment-email-ipt">
            <input class="block-input" placeholder="请输入您的昵称" name="nicker" autocomplete="off" id="comment-nicker-ipt">
            <textarea class="block-input text" id="comment-content-input" placeholder="写下对作者的感受,对他人帮助很大哦！" autocomplete="off" maxlength="400"></textarea>
            <div class="validation-block">
                <div class="validation-size">
                    <span>拖动滑块验证</span>
                    <div class="validation-btn" id="validation-btn"><img src="${ctx}/static/libs/images/right-gooo.svg"></div>
                </div>
                <span class="validation-result success" id="validation-result-success"><img src="${ctx}/static/libs/images/icon-success.svg"> 验证通过</span>
                <span class="validation-result fail" id="validation-result-fail"><img src="${ctx}/static/libs/images/icon-fail.svg "> 验证失败</span>
                <input type="hidden" id="moveLength" value="32">
                <input type="hidden" id="validation-code" value="0">
                <input type="hidden" id="validation-index" value="${validationIndex}">
                <input type="hidden" id="reply-id" value="0">
                <button class="submit-btn" style="float: right;" onclick="submitComment()">评论</button>
            </div>

            <!-- 评论内容 -->

            <div style="padding-top: 40px; padding-bottom: 20px">
                <h1 class="h1">全部评论</h1>
                <div class="hr"></div>
                <div class="comment-list">
                    <#list comments as comment>
                        <div class="comment-item">
                            <div class="comment-left">
                                <div class="author-name">${comment.nicker}</div>
                                <div class="small-text">${comment.createTime}</div>
                            </div>
                            <div class="comment-right">
                                <p class="comment-content">
                                    <#if comment.deleted>
                                        <span style="text-decoration:line-through; color: #8A8F99; background-color: #33373D; padding: 5px; display: inline-block; border-radius: 3px">该评论已被删除</span>
                                    <#else>
                                        ${comment.content}
                                    </#if>
                                </p>
                                <#if comment.subList?size != 0>
                                    <div class="box comment-sub-box">
                                        <#list comment.subList as subComment>
                                            <div style="margin-bottom: 10px">
                                                <#if subComment.parentId != comment.id>
                                                    <span class="author-name">${subComment.nicker}</span>
                                                    <span class="small-text">Re: [${subComment.replyName}] ${subComment.createTime}</span>
                                                <#else>
                                                    <span class="author-name">${subComment.nicker}</span>
                                                    <span class="small-text">${subComment.createTime}</span>
                                                </#if>
                                            </div>
                                            <p>
                                                <#if subComment.deleted>
                                                    <span style="text-decoration:line-through; color: #8A8F99; background-color: #33373D; padding: 5px; display: inline-block; border-radius: 3px">该评论已被删除</span>
                                                <#else>
                                                    ${subComment.content}
                                                </#if>

                                            </p>
                                            <div class="comment-btn-bar" style="margin-bottom: 10px">
                                                <a class="small-text" href="javascript:;" onclick="gotoCommen({id: '${subComment.id}', nicker: '${subComment.nicker}'})"> <img class="icon" src="${ctx}/static/libs/images/comment.svg"> 回复</a>
                                            </div>
                                            <div class="hr" style="margin-bottom: 15px;"></div>
                                        </#list>
                                    </div>
                                </#if>
                                <div class="comment-btn-bar">
                                    <a class="small-text" href="javascript:;" onclick="gotoCommen({id: '${comment.id}', nicker: '${comment.nicker}'})"> <img class="icon" src="${ctx}/static/libs/images/comment.svg"> 回复</a>
                                </div>
                            </div>
                        </div>
                    </#list>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${ctx}/static/libs/prism/prism.js"></script>
<script src="${ctx}/static/libs/script/validation.js"></script>
<script>

    function gotoCommen(reply) {
        let contentIpt = dg("comment-content-input");
        if (reply){
            contentIpt.innerText = "Re: [" + reply.nicker + "] ";
            dg("reply-id").value = reply.id;
        }
        window.scroll(0, dg("comment-block-id").offsetTop - 100);
        focus(contentIpt);
    }

    function focus(dom){
        if(dom.setSelectionRange){//火狐
            dom.setSelectionRange(dom.value.length, dom.value.length); //将光标定位在textarea的开头，需要定位到其他位置的请自行修改
            dom.focus();
        }else if(dom.createTextRange){//ie
            var rtextRange =dom.createTextRange();
            rtextRange.moveStart('character',dom.value.length);
            rtextRange.collapse(true);
            rtextRange.select();
        }
    }

    function dg(id) {return document.getElementById(id)}

    /**
     * 验证码
     */
    function loadValiCode(){
        if (dg("validation-code").value == 0){
            H.get("${ctx}/api/v1/vc/" + dg("validation-index").value, function (res) {
                dg("moveLength").value = res.responseBody;
                moveLength = res.responseBody;
            });
            // 验证码过期自动刷新
            setTimeout(() => {
                loadValiCode();
            }, 1000 * 60 * 4);
        }
    }
    loadValiCode();

    function submitComment() {
        if (!isSuccess){
            H.msg("请先拖动滑块完成验证");
            return ;
        }
        let req = {
            email: dg("comment-email-ipt").value,
            nicker: dg("comment-nicker-ipt").value,
            content: dg("comment-content-input").value,
            valicode: dg("validation-code").value,
            valiIndex: dg("validation-index").value,
            parentId: dg("reply-id").value
        }
        H.post("${ctx}/api/v1/article/${article.id}/comment", req, function () {
            H.msg("发布成功, 审核通过后自动展示");
            dg("comment-content-input").value = "";
        })
    }


</script>
</body>
</html>