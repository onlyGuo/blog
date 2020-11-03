

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>layuiAdmin 网站用户 iframe 框</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
  <link rel="stylesheet" href="${ctx}/static/libs/layuiadmin/layui/css/layui.css" media="all">
  <style>
    .keyword-items{
      padding-top: 20px;
    }
    .keyword-items span{
      display: inline-block;
      height: 20px;
      line-height: 20px;
      padding: 0 10px;
      background-color: #00aaaa;
      margin-left: 10px;
      color: white;
    }
  </style>
</head>
<body>

  <div class="layui-form" lay-filter="layuiadmin-form-useradmin" id="layuiadmin-form-useradmin" style="padding: 20px;">
    <div class="layui-form-item">
      匹配词汇
      <input type="text" name="keyword" lay-verify="required" placeholder="请输入过滤词汇" autocomplete="off" class="layui-input" style="display: inline-block;width: 300px; margin-left: 20px">
      <div class="keyword-items"><span>中国</span><span>台湾</span><span>社会</span></div>
    </div>
    <div class="layui-form-item">
      匹配范围
      <div style="display: inline-block;vertical-align: bottom;margin-left: 20px;">
        <input type="checkbox" name="findRange" title="昵称" value="1" lay-skin="primary">
        <input type="checkbox" name="findRange" title="邮箱" value="1" lay-skin="primary">
        <input type="checkbox" name="findRange" title="内容" value="1" lay-skin="primary">
      </div>
    </div>
    <div class="layui-form-item">
      匹配规则
      <div style="display: inline-block;margin-left: 20px;width: 300px">
        <select name="rule">
          <option value="">请选择一种匹配规则</option>
          <option value="1">所有词汇出现次数总和</option>
          <option value="2">出现率最高词汇数</option>
          <option value="3">平均每个词汇出现数</option>
          <option value="4">全部匹配且按最低出现率的词汇次数</option>
          <option value="5">全部匹配且按出现率最高的词汇次数</option>
        </select>
      </div>
    </div>
    <div class="layui-form-item">
      触发阀值
      <input name="threshold" lay-verify="required" placeholder="请输入一个数字阀值" type="number" autocomplete="off" class="layui-input" style="display: inline-block;width: 300px; margin-left: 20px">
    </div>
    <div class="layui-form-item">
      处理方法
      <div style="display: inline-block;margin-left: 20px;width: 300px">
        <select name="flowFun">
          <option value="">请选择一种处理方法</option>
          <option value="1">转人工审核</option>
          <option value="2">自动驳回</option>
          <option value="3">自动通过</option>
          <option value="4">替换为`***`并通过</option>
        </select>
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