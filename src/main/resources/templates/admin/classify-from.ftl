

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>layuiAdmin 网站用户 iframe 框</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
  <link rel="stylesheet" href="${ctx}/static/libs/layuiadmin/layui/css/layui.css" media="all">
</head>
<body>

  <div class="layui-form" lay-filter="layuiadmin-form-useradmin" id="layuiadmin-form-useradmin" style="padding: 20px;">
    <div class="layui-form-item">
      名称
      <input type="text" name="name" lay-verify="required" placeholder="请输入栏目名称" autocomplete="off" class="layui-input" style="display: inline-block;width: 300px; margin-left: 20px">
    </div>
    <div class="layui-form-item">
      状态
      <div style="display: inline-block;vertical-align: bottom;margin-left: 20px;">
          <input type="checkbox" name="status" lay-skin="switch" lay-text="ON|OFF" value="1" checked>
      </div>
    </div>
    <div class="layui-form-item layui-hide">
      <input type="button" lay-submit lay-filter="LAY-user-front-submit" id="LAY-user-front-submit" value="确认">
    </div>
  </div>

  <script src="${ctx}/static/libs/layuiadmin/layui/layui.js"></script>
  <script>
  layui.config({
    base: '${ctx}/static/libs/layuiadmin/' //静态资源所在路径
  }).extend({
    index: 'lib/index' //主入口模块
  }).use(['index', 'form'], function(){
    var $ = layui.$
    ,form = layui.form;
  })
  </script>
</body>
</html>