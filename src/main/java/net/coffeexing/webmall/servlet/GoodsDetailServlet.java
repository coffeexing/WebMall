package net.coffeexing.webmall.servlet;

import net.coffeexing.webmall.entity.Goods;
import net.coffeexing.webmall.service.impl.GoodsServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/goodsDetail")
public class GoodsDetailServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private GoodsServiceImpl goodsService = new GoodsServiceImpl();


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String goodsId = req.getParameter("goodsId");
        Goods goods = goodsService.getGoodsByGoodsId(goodsId);
        req.setAttribute("goods", goods);
        req.getRequestDispatcher("/goodsInfo.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
