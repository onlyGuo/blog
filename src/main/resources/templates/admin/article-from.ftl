<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>后台</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${ctx}/static/libs/layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${ctx}/static/libs/layuiadmin/style/admin.css" media="all">
    <link rel="stylesheet" href="${ctx}/static/libs/style/editormd.min.css" />
</head>
<body>
    <div class="layui-fluid">
        <div class="layui-card">
            <div class="layui-card-header">文章编辑</div>
            <div class="layui-card-body" style="padding: 15px;">
                <form class="layui-form" action="" lay-filter="component-form-group">
                    <div class="layui-form-item">
                        <label class="layui-form-label">文章标题</label>
                        <div class="layui-input-block">
                            <input type="text" name="title" lay-verify="title" autocomplete="off" value="${(article.title)!''}" placeholder="请输入标题" class="layui-input">
                        </div>
                    </div>

                    <div class="layui-form-item" pane="">
                        <label class="layui-form-label">关联栏目</label>
                        <div class="layui-input-block">
                            <#list classifys as classify>
                                <input type="checkbox" class="input-classify" name="classify[${classify.id}]"
                                       value="${classify.id}" lay-skin="primary" title="${classify.name}" <#if classify.selected>checked</#if>>
                            </#list>
                        </div>
                    </div>

                    <div class="layui-form-item layui-form-text">
                        <div class="layui-input-block" id="test-editor">
                            <textarea style="display:none;">${(article.doc)!''}</textarea>
                        </div>
                    </div>
                    <div class="layui-form-item layui-layout-admin">
                        <div class="layui-input-block">
                            <div class="layui-footer" style="left: 0;z-index: 10; text-align: right">
                                <button class="layui-btn" lay-submit="" lay-filter="component-form-demo1">立即提交</button>
                                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

<script src="${ctx}/static/libs/layuiadmin/layui/layui.js"></script>
<script src="${ctx}/static/libs/script/ajax/core.js"></script>
<script src="${ctx}/static/libs/script/jquery-2.0.2.js"></script>
<script src="${ctx}/static/libs/script/editormd.min.js"></script>
<script>
    layui.config({
        base: '${ctx}/static/libs/layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'form', 'table'], function () {
        var $ = layui.$,form = layui.form,table = layui.table;
        form.render(null, 'component-form-group');
        /* 自定义验证规则 */
        form.verify({
            title: function(value){
                if(value.length < 5){
                    return '标题至少得5个字符啊';
                }
            }
        });
        /* 监听提交 */
        form.on('submit(component-form-demo1)', function(data){
            let req = {
                title: data.field.title,
                doc: data.field['test-editor-markdown-doc'],
                content: data.field['test-editor-html-code'],
                id: '${(article.id)! "0"}',
                classifyIds: []
            };
            let classifyDoms = $(".input-classify:checked");
            for (let i = 0; i < classifyDoms.length; i++){
                req.classifyIds.push(classifyDoms[i].value);
            }
            H.put("${ctx}/api/v1/article", req, function (data) {
                layer.alert("发布成功", function () {
                    location.href = "${ctx}/admin/article-from/" + data.responseBody.id;
                });
            })
            return false;
        });


        let editor = editormd("test-editor", {
            width  : "100%",
            height : "calc(100vh)",
            theme : "dark",
            previewTheme : "dark",
            editorTheme : "pastel-on-dark",
            saveHTMLToTextarea : true,
            placeholder: "在此处编辑您的文章",
            path   : "${ctx}/static/libs/editormd/lib/"
        });
    });

</script>
</body>
</html>