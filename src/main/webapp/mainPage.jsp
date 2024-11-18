<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="net.coffeexing.webmall.entity.Goods" %>
<%
    // 从请求范围中获取商品列表
    List<Goods> goodsList = (List<Goods>) request.getAttribute("goodsList");
%>
<!DOCTYPE HTML>
<html>
<head>
    <title>商品展示</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 保持原HTML样式和路径 -->
    <link href="res/css/bootstrap.css" rel="stylesheet" type="text/css" media="all">
    <link href="res/css/style.css" rel="stylesheet" type="text/css" media="all">
    <script src="res/js/jquery.min.js"></script>
    <script src="res/js/bootstrap-3.1.1.min.js"></script>
</head>
<body>
<div class="products">
    <div class="container">
        <h2>商品展示</h2>
        <div class="col-md-13 product-model-sec">
            <%
                if (goodsList != null && !goodsList.isEmpty()) {
                    for (Goods goods : goodsList) {
            %>
            <div class="product-grid">
                <div class="product-info simpleCart_shelfItem">
                    <div class="product-info-cust prt_name">
                        <!-- 商品描述 -->
                        <h4><%= goods.getGoodsDescribe() %></h4>
                        <!-- 商品名称 -->
                        <a href="goodsDetail?goodsId=<%= goods.getGoodsId() %>">
                            <span class="item_price"><%= goods.getGoodsName() %></span>
                        </a>
                        <!-- 商品价格和折扣价格 -->
                        <div class="ofr">
                            <p class="pric1">
                                <del>￥<%= goods.getGoodsPrice() %></del>
                            </p>
                            <p class="disc">
                                ￥<%= goods.getGoodsDiscount() %>
                            </p>
                        </div>
                        <!-- 加入购物车按钮 -->
                        <input type="button" class="item_add items"
                               onclick="addGoodsToCart('<%= goods.getGoodsId() %>')" value="加入购物车">
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
            <%
                }
            } else {
            %>
            <p>暂无商品可展示！</p>
            <%
                }
            %>
            <div class="clearfix"></div>
        </div>
        <br><br>
    </div>
</div>
</body>
<script src="res/layer/layer.js" type="text/javascript"></script>
<script type="text/javascript">
    function addGoodsToCart(goodsId) {
        // 检查用户是否已登录
        <%-- 假设 session 中的 "user" 存储了用户信息 --%>
        <% if (session.getAttribute("user") != null) { %>
        $.ajax({
            type: "POST",
            dataType: "text",
            async: false,
            url: 'cart.jsp',
            data: {
                "goodsId": goodsId,
                "buyNum": 1,
                "oper": 1
            },
            success: function(msg) {
                if (msg == 'success') {
                    layer.msg('已加入您的购物车！', {icon:6});
                } else {
                    layer.msg('操作失败，请重试！', {icon:5});
                }
            },
            error: function() {
                layer.msg('服务器响应失败！', {icon: 5});
            }
        });
        <% } else { %>
        layer.msg('您还没有登录！', {icon: 5});
        <% } %>
    }
</script>
</html>
