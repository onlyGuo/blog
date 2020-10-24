<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${ctx}/static/libs/layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${ctx}/static/libs/layuiadmin/style/admin.css" media="all">
</head>
<body>
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-form layui-card-header layuiadmin-card-header-auto">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">标题</label>
                    <div class="layui-input-block">
                        <input type="text" name="title" placeholder="请输入标题关键字" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">栏目</label>
                    <div class="layui-input-block">
                        <select name="classifyId">
                            <option value="0">所有栏目</option>
                            <#list classifys as classify>
                                <option value="${classify.id}">${classify.name}</option>
                            </#list>
                        </select>
                    </div>
                </div>
                <div class="layui-inline">
                    <button class="layui-btn layuiadmin-btn-admin" lay-submit lay-filter="article-search-btn">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>
            </div>
        </div>

        <div class="layui-card-body">
            <div style="padding-bottom: 10px;">
                <button class="layui-btn layuiadmin-btn-useradmin" data-type="add" id="add-article-btn">发布文章</button>
            </div>
            <table id="article-list-mgr" lay-filter="classify-list-mgr"></table>
            <script type="text/html" id="checkboxTpl">
                <input type="checkbox" name="lock" value="{{d.status}}" lay-skin="switch" lay-text="ON|OFF" disabled {{ d.status == 1 ? 'checked' : '' }}>
            </script>
            <script type="text/html" id="table-article-work">
                <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i class="layui-icon layui-icon-edit"></i>编辑</a>
                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i class="layui-icon layui-icon-delete"></i>删除</a>
            </script>
        </div>
    </div>
</div>

<script src="${ctx}/static/libs/layuiadmin/layui/layui.js"></script>
<script src="${ctx}/static/libs/script/ajax/core.js"></script>
<script>
    layui.config({
        base: '${ctx}/static/libs/layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'form', 'table'], function () {
        var $ = layui.$,form = layui.form,table = layui.table;

        // 初始化列表
        table.render({
            elem: '#article-list-mgr'
            ,url: '${ctx}/api/v1/article' //模拟接口
            ,cols: [[
                {field: 'id', width: 100, title: 'ID', sort: true}
                ,{field: 'title', title: '文章标题'}
                ,{field: 'classifyName', title: '关联栏目'}
                ,{field: 'createTime', title: '发布时间'}
                ,{field: 'updateTime', title: '修改时间'}
                ,{title: '操作', width: 150, align:'center', fixed: 'right', toolbar: '#table-article-work'}
            ]]
            ,page: true
        });

        table.on('tool(classify-list-mgr)', function(obj){
            var data = obj.data;
            if(obj.event === 'del'){
                // layer.confirm('真的删除行么', function(index){
                //     obj.del();
                //     layer.close(index);
                // });
            } else if(obj.event === 'edit'){
                parent.layui.index.openTabsPage("${ctx}/admin/article-from/" + data.id, "发布文章");
            }
        });

        //监听搜索
        form.on('submit(article-search-btn)', function(data){
            var field = data.field;
            //执行重载
            table.reload('article-list-mgr', {
                where: field
            });
        });

        $("#add-article-btn").on("click", function () {
            parent.layui.index.openTabsPage("${ctx}/admin/article-from", "发布文章");
        });


    });

</script>
</body>
</html>