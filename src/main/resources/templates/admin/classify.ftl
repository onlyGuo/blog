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
        <div class="layui-card-body">
            <div style="padding-bottom: 10px;">
                <button class="layui-btn layuiadmin-btn-useradmin" data-type="add" id="add-classify-btn">添加</button>
            </div>
            <table id="classify-list-mgr" lay-filter="classify-list-mgr"></table>
            <script type="text/html" id="checkboxTpl">
                <input type="checkbox" name="lock" value="{{d.status}}" lay-skin="switch" lay-text="ON|OFF" disabled {{ d.status == 1 ? 'checked' : '' }}>
            </script>
            <script type="text/html" id="table-useradmin-webuser">
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
            elem: '#classify-list-mgr'
            ,url: '${ctx}/api/v1/classify' //模拟接口
            ,cols: [[
                {field: 'id', width: 100, title: 'ID', sort: true}
                ,{field: 'name', title: '栏目名称'}
                ,{field: 'status', title: '栏目状态', templet: "#checkboxTpl"}
                ,{field: 'createTime', title: '创建时间'}
                ,{field: 'updateTime', title: '修改时间'}
                ,{title: '操作', width: 150, align:'center', fixed: 'right', toolbar: '#table-useradmin-webuser'}
            ]]
            ,page: true
        });

        $("#add-classify-btn").on("click", function () {
            // parent.layui.index.openTabsPage("123", "123");
            layer.open({
                type: 2
                ,title: '添加用户'
                ,content: '${ctx}/admin/classify-from'
                ,maxmin: true
                ,area: ['400px', '250px']
                ,btn: ['确定', '取消']
                ,yes: function(index, layero){
                    var iframeWindow = window['layui-layer-iframe'+ index]
                        ,submitID = 'LAY-user-front-submit'
                        ,submit = layero.find('iframe').contents().find('#'+ submitID);

                    //监听提交
                    iframeWindow.layui.form.on('submit('+ submitID +')', function(data){
                        H.post("${ctx}/api/v1/classify", data.field, function () {
                            table.reload('classify-list-mgr'); //数据刷新
                            layer.close(index); //关闭弹层
                        });
                    });
                    submit.trigger('click');
                }
            });
        });

    });

</script>
</body>
</html>