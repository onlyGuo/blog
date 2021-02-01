

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>layuiAdmin 主页示例模板二</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
  <link rel="stylesheet" href="${ctx}/static/libs/layuiadmin/layui/css/layui.css" media="all">
  <link rel="stylesheet" href="${ctx}/static/libs/layuiadmin/style/admin.css" media="all">
</head>
<body>

  <div class="layui-fluid">
    <div class="layui-row layui-col-space15">
      
      <div class="layui-col-sm6 layui-col-md3">
        <div class="layui-card">
          <div class="layui-card-header">
            访问量
            <span class="layui-badge layui-bg-blue layuiadmin-badge">周</span>
          </div>
          <div class="layui-card-body layuiadmin-card-list">
            <p class="layuiadmin-big-font">${weekVisit}</p>
            <p>
              总计访问量 
              <span class="layuiadmin-span-color">${allVisit} <i class="layui-inline layui-icon layui-icon-flag"></i></span>
            </p>
          </div>
        </div>
      </div>
      <div class="layui-col-sm6 layui-col-md3">
        <div class="layui-card">
          <div class="layui-card-header">
            评论
            <span class="layui-badge layui-bg-cyan layuiadmin-badge">月</span>
          </div>
          <div class="layui-card-body layuiadmin-card-list">
            <p class="layuiadmin-big-font">33,555</p>
            <p>
              新评论
              <span class="layuiadmin-span-color">10% <i class="layui-inline layui-icon layui-icon-face-smile-b"></i></span>
            </p>
          </div>
        </div>
      </div>
      <div class="layui-col-sm6 layui-col-md3">
        <div class="layui-card">
          <div class="layui-card-header">
            文章
            <span class="layui-badge layui-bg-green layuiadmin-badge">年</span>
          </div>
          <div class="layui-card-body layuiadmin-card-list">

            <p class="layuiadmin-big-font">999,666</p>
            <p>
              待审核
              <span class="layuiadmin-span-color">0 <i class="layui-inline layui-icon layui-icon-dollar"></i></span>
            </p>
          </div>
        </div>
      </div>
      <div class="layui-col-sm6 layui-col-md3">
        <div class="layui-card">
          <div class="layui-card-header">
            待审评论
<#--            <span class="layui-badge layui-bg-orange layuiadmin-badge">月</span>-->
          </div>
          <div class="layui-card-body layuiadmin-card-list">

            <p class="layuiadmin-big-font">66,666</p>
            <p>
              最近一个月 
              <span class="layuiadmin-span-color">11 <i class="layui-inline layui-icon layui-icon-user"></i></span>
            </p>
          </div>
        </div>
      </div>   
      <div class="layui-col-sm12">
        <div class="layui-card">
          <div class="layui-card-header">
            访问量
          </div>
          <div class="layui-card-body">
            <div class="layui-row">
              <div class="layui-col-sm8">
                  <div class="layui-carousel layadmin-carousel layadmin-dataview" data-anim="fade" lay-filter="LAY-index-pagetwo">
                    <div carousel-item id="LAY-index-pagetwo">
                      <div><i class="layui-icon layui-icon-loading1 layadmin-loading"></i></div>
                    </div>
                  </div>
              </div>
              <div class="layui-col-sm4">
                <div class="layuiadmin-card-list">
                  <p class="layuiadmin-normal-font">日访问数</p>
                  <span>同上期增长</span>
                  <div class="layui-progress layui-progress-big" lay-showPercent="yes">
                    <div class="layui-progress-bar" lay-percent="30%"></div>
                  </div>
                </div>
                <div class="layuiadmin-card-list">
                  <p class="layuiadmin-normal-font">日评论数</p>
                  <span>同上期增长</span>
                  <div class="layui-progress layui-progress-big" lay-showPercent="yes">
                    <div class="layui-progress-bar" lay-percent="20%"></div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="layui-col-sm4">
        <div class="layui-card">
          <div class="layui-card-header">用户留言</div>
          <div class="layui-card-body" style="height: 900px;overflow-y: auto;">
            <ul class="layuiadmin-card-status layuiadmin-home2-usernote">
              <li>
                <h3>贤心</h3>
                <p>作为 layui 官方推出的后台模板，从初版的饱受争议，到后续的埋头丰富，逐步占据了国内后台系统应用的主要市场。</p>
                <span>5月30日 00:00</span>
                <a href="javascript:;" layadmin-event="replyNote" data-id="7" class="layui-btn layui-btn-xs layuiadmin-reply">回复</a>
              </li>
              <li>
                <h3>诸葛亮</h3>
                <p>皓首匹夫！苍髯老贼！你枉活九十有六，一生未立寸功，只会摇唇鼓舌！助曹为虐！一条断脊之犬，还敢在我军阵前狺狺狂吠，我从未见过有如此厚颜无耻之人！</p>
                <span>5月02日 00:00</span>
                <a href="javascript:;" layadmin-event="replyNote" data-id="5" class="layui-btn layui-btn-xs layuiadmin-reply">回复</a>
              </li>
              <li>
                <h3>胡歌</h3>
                <p>你以为只要长得漂亮就有男生喜欢？你以为只要有了钱漂亮妹子就自己贴上来了？你以为学霸就能找到好工作？我告诉你吧，这些都是真的！</p>
                <span>5月11日 00:00</span>
                <a href="javascript:;" layadmin-event="replyNote" data-id="6" class="layui-btn layui-btn-xs layuiadmin-reply">回复</a>
              </li>
              <li>
                <h3>杜甫</h3>
                <p>人才虽高，不务学问，不能致圣。刘向十日画一水，五日画一石。</p>
                <span>4月11日 00:00</span>
                <a href="javascript:;" layadmin-event="replyNote" data-id="2" class="layui-btn layui-btn-xs layuiadmin-reply">回复</a>
              </li>
              <li>
                <h3>鲁迅</h3>
                <p>路本是无所谓有和无的，走的人多了，就没路了。。</p>
                <span>4月28日 00:00</span>
                <a href="javascript:;" layadmin-event="replyNote" data-id="4" class="layui-btn layui-btn-xs layuiadmin-reply">回复</a>
              </li>
              <li>
                <h3>张爱玲</h3>
                <p>于千万人之中遇到你所要遇到的人，于千万年之中，时间的无涯的荒野中，没有早一步，也没有晚一步，刚巧赶上了，那也没有别的话好说，唯有轻轻的问一声：“噢，原来你也在这里？”</p>
                <span>4月11日 00:00</span>
                <a href="javascript:;" layadmin-event="replyNote" data-id="1" class="layui-btn layui-btn-xs layuiadmin-reply">回复</a>
              </li>
            </ul>
          </div>
        </div>
      </div>
      <div class="layui-col-md8">
        <div class="layui-card">
          <div class="layui-card-header">数据概览</div>
          <div class="layui-card-body">

            <div class="layui-carousel layadmin-carousel layadmin-dataview" data-anim="fade" lay-filter="LAY-index-dataview">
              <div carousel-item id="LAY-index-dataview">
                <div><i class="layui-icon layui-icon-loading1 layadmin-loading"></i></div>
                <div></div>
              </div>
            </div>

          </div>
        </div>
        <div class="layui-card">
          <div class="layui-tab layui-tab-brief layadmin-latestData">
            <ul class="layui-tab-title">
              <li class="layui-this">今日热搜</li>
              <li>今日热帖</li>
            </ul>
            <div class="layui-tab-content" style="height: 481px">
              <div class="layui-tab-item layui-show">
                <table id="LAY-index-topSearch"></table>
              </div>
              <div class="layui-tab-item">
                <table id="LAY-index-topCard"></table>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="layui-col-sm12">
        <div class="layui-row layui-col-space15">
          <div class="layui-col-sm12">
            <div class="layui-card">
              <div class="layui-card-header">用户全国分布</div>
              <div class="layui-card-body">
                <div class="layui-row layui-col-space15">
                  <div class="layui-col-sm4">
                    <table class="layui-table layuiadmin-page-table" lay-skin="line">
                      <thead>
                        <tr>
                          <th>排名</th>
                          <th>地区</th>
                          <th>人数</th>
                        </tr> 
                      </thead>
                      <tbody>
                        <tr>
                          <td>1</td>
                          <td>浙江</td>
                          <td>62310</td>
                        </tr>
                        <tr>
                          <td>2</td>
                          <td>上海</td>
                          <td>59190</td>
                        </tr>
                        <tr>
                          <td>3</td>
                          <td>广东</td>
                          <td>55891</td>
                        </tr>
                        <tr>
                          <td>4</td>
                          <td>北京</td>
                          <td>51919</td>
                        </tr>  
                        <tr>
                          <td>5</td>
                          <td>山东</td>
                          <td>39231</td>
                        </tr>
                        <tr>
                          <td>6</td>
                          <td>湖北</td>
                          <td>37109</td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                  <div class="layui-col-sm8">

                    <div class="layui-carousel layadmin-carousel layadmin-dataview" data-anim="fade" lay-filter="LAY-index-pagethree">
                      <div carousel-item id="LAY-index-pagethree">
                        <div><i class="layui-icon layui-icon-loading1 layadmin-loading"></i></div>
                      </div>
                    </div>
      
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
        
      </div>
    </div>
  </div>

  <script src="${ctx}/static/libs/layuiadmin/layui/layui.js"></script>
  <script>
  layui.config({
    base: '${ctx}/static/libs/layuiadmin/' //静态资源所在路径
  }).extend({
    index: 'lib/index' //主入口模块
  }).use(['index', 'sample', 'console']);
  </script>
</body>
</html>