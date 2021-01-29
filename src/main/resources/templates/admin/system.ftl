

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>网站设置</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
  <link rel="stylesheet" href="${ctx}/static/libs/layuiadmin/layui/css/layui.css" media="all">
  <link rel="stylesheet" href="${ctx}/static/libs/layuiadmin/style/admin.css" media="all">
</head>
<body>

  <div class="layui-fluid">
    <div class="layui-row layui-col-space15">
      <div class="layui-col-md12">
        <div class="layui-card">
          <div class="layui-card-header">网站设置</div>
          <div class="layui-card-body" pad15>
            
            <div class="layui-form" wid100 lay-filter="">
              <div class="layui-form-item">
                <label class="layui-form-label">网站名称</label>
                <div class="layui-input-block">
                  <input type="text" name="name" value="${website.name !''}" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <label class="layui-form-label">默认昵称</label>
                <div class="layui-input-block">
                  <input type="text" name="nicker" value="${website.nicker !''}" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <label class="layui-form-label">网站域名</label>
                <div class="layui-input-block">
                  <input type="text" name="domain" value="${website.domain !''}" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <label class="layui-form-label">缓存时间</label>
                <div class="layui-input-inline" style="width: 80px;">
                  <input type="text" name="cacheTime" lay-verify="number" value="${website.cacheTime !''}" class="layui-input">
                </div>
                <div class="layui-input-inline layui-input-company">秒</div>
                <div class="layui-form-mid layui-word-aux">本地开发一般推荐设置为 0，线上环境建议设置为 10。</div>
              </div>
              <div class="layui-form-item">
                <label class="layui-form-label">最大文件上传</label>
                <div class="layui-input-inline" style="width: 80px;">
                  <input type="text" name="maxUpdateSize" lay-verify="number" value="${website.maxUpdateSize !''}" class="layui-input">
                </div>
                <div class="layui-input-inline layui-input-company">KB</div>
                <div class="layui-form-mid layui-word-aux">提示：1 M = 1024 KB</div>
              </div>
              <div class="layui-form-item">
                <label class="layui-form-label">上传文件类型</label>
                <div class="layui-input-block">
                  <input type="text" name="uploadFileType" value="${website.uploadFileType !''}" class="layui-input">
                </div>
              </div>
              
              <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">首页标题</label>
                <div class="layui-input-block">
                  <textarea name="homeTitle" class="layui-textarea">${website.homeTitle !''}</textarea>
                </div>
              </div>
              <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">META关键词</label>
                <div class="layui-input-block">
                  <textarea name="metaKeywords" class="layui-textarea" placeholder="多个关键词用英文状态 , 号分割">${website.metaKeywords !''}</textarea>
                </div>
              </div>
              <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">META描述</label>
                <div class="layui-input-block">
                  <textarea name="metaDescription" class="layui-textarea">${website.metaDescription !''}</textarea>
                </div>
              </div>
              <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">版权信息</label>
                <div class="layui-input-block">
                  <textarea name="license" class="layui-textarea">${website.license !''}</textarea>
                </div>
              </div>
              <div class="layui-form-item">
                <div class="layui-input-block">
                  <button class="layui-btn" lay-submit lay-filter="set_website">确认保存</button>
                </div>
              </div>
            </div>
            
          </div>
        </div>
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
  }).use(['index', 'form'], function () {
    var $ = layui.$,form = layui.form;
    //网站设置
    form.on('submit(set_website)', function(obj){
      H.put("${ctx}/api/v1/system/website", obj.field, function () {
        H.msg("保存成功");
      });
      return false;
    });
  });

  </script>
</body>
</html>