package net.coffeexing.webmall.servlet;

import net.coffeexing.webmall.entity.Goods;
import net.coffeexing.webmall.service.GoodsService;
import net.coffeexing.webmall.service.impl.GoodsServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/searchGoods")
public class SearchGoodsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private GoodsService goodsService = new GoodsServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 获取查询关键字
        String keyword = req.getParameter("keyword");

        // 调用服务层方法搜索商品
        List<Goods> goodsList = goodsService.searchGoods(keyword);

        // 将查询结果存入请求范围
        req.setAttribute("goodsList", goodsList);
        req.setAttribute("keyword", keyword);

        // 转发到 searchGoods.jsp
        req.getRequestDispatcher("/searchGoods.jsp").forward(req, resp);
    }
}
