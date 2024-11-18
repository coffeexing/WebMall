<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="net.coffeexing.webmall.entity.Goods" %>
<%
    // 从请求范围中获取商品列表
    List<Goods> goodsList = (List<Goods>) request.getAttribute("goodsList");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="res/css/bootstrap.css">
    <link rel="stylesheet" href="res/css/style.css">
</head>
<body>
<div class="products">
    <div class="container">
        <h2>商品展示</h2>
        <div class="product-model-sec">
            <%
                if (goodsList != null && !goodsList.isEmpty()) {
                    for (Goods goods : goodsList) {
            %>
            <div class="col-md-4 product-grid">
                <div class="product-info">
                    <h3><a href="goodsInfo.jsp?goodsId=<%= goods.getGoodsId() %>">
                        <%= goods.getGoodsName() %>
                    </a></h3>
                    <p>价格：￥<%= goods.getGoodsPrice() %></p>
                    <button class="btn btn-primary" onclick="addToCart('<%= goods.getGoodsId() %>')">加入购物车</button>
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
    </div>
</div>
</body>
<script src="res/js/jquery.min.js"></script>
<script type="text/javascript">
    function addToCart(goodsId) {
        $.ajax({
            type: "POST",
            url: "cart.jsp",
            data: { goodsId: goodsId, oper: 1 },
            success: function(response) {
                if (response === "success") {
                    alert("商品已加入购物车！");
                } else {
                    alert("加入购物车失败，请重试！");
                }
            },
            error: function() {
                alert("服务器响应失败！");
            }
        });
    }
</script>
</html>
