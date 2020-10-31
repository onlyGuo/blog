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
                    <label class="layui-form-label">关键字</label>
                    <div class="layui-input-block">
                        <input type="text" name="keyword" placeholder="请输入发言人/邮箱/内容" autocomplete="off" class="layui-input" style="width: 300px">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">栏目</label>
                    <div class="layui-input-block">
                        <select name="status">
                            <option value="2">所有状态</option>
                            <option value="0">待审核</option>
                            <option value="1">审核通过</option>
                            <option value="-1">已驳回</option>
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
<#--            <div style="padding-bottom: 10px;">-->
<#--                <button class="layui-btn layuiadmin-btn-useradmin" data-type="add" id="add-classify-btn">添加</button>-->
<#--            </div>-->
            <table id="classify-list-mgr" lay-filter="classify-list-mgr"></table>
            <script type="text/html" id="checkboxTpl">
                <span> {{d.status == 1 ? '通过' : (d.status == -1 ? '驳回': '待审核')}}</span>
            </script>
            <script type="text/html" id="table-useradmin-webuser">
                <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit-status"><i class="layui-icon layui-icon-edit"></i>审核</a>
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
            elem: '#classify-list-mgr'
            ,url: '${ctx}/api/v1/comment' //模拟接口
            ,cols: [[
                {field: 'id', width: 100, title: 'ID', sort: true}
                ,{field: 'parentId', title: '回复ID', width: 100}
                ,{field: 'title', title: '所属文章', width: 250}
                ,{field: 'nicker', title: '发言人', width: 150}
                ,{field: 'email', title: '电子邮箱', width: 200}
                ,{field: 'content', title: '发布内容'}
                ,{field: 'createTime', title: '发布时间', width: 200}
                ,{field: 'status', title: '审核状态', width: 100, templet: "#checkboxTpl"}
                ,{title: '操作', width: 150, align:'center', fixed: 'right', toolbar: '#table-useradmin-webuser'}
            ]]
            ,page: true
        });

        //监听搜索
        form.on('submit(article-search-btn)', function(data){
            var field = data.field;
            //执行重载
            table.reload('classify-list-mgr', {
                where: field
            });
        });

        table.on('tool(classify-list-mgr)', function(obj){
            var data = obj.data;
            if(obj.event === 'del'){
                layer.confirm('真的删除行么', function(index){
                    layer.close(index);
                    H.del("${ctx}/api/v1/comment/" + data.id, function () {
                        obj.del();
                        layer.msg("删除成功")
                    })
                });
            }else if (obj.event === 'edit-status'){
                if (data.status !== 0){
                    return;
                }
                // 审核
                layer.confirm('确定要通过审核吗?', {
                    btn: ['通过', '驳回']
                }, function(index){
                    H.put("${ctx}/api/v1/comment/" + data.id + "/status", {
                       status: 1
                    }, function (res) {
                        layer.msg("审核通过");
                        table.reload('classify-list-mgr', {
                            where: field
                        });
                    })
                }, function (index) {
                    H.put("${ctx}/api/v1/comment/" + data.id + "/status", {
                        status: -1
                    }, function (res) {
                        layer.msg("审核已驳回");
                        table.reload('classify-list-mgr', {
                            where: field
                        });
                    })
                });
            }
        });

    });

</script>
</body>
</html>