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

@WebServlet("/mainPage")
public class GoodsListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private GoodsService goodsService = new GoodsServiceImpl();

    public GoodsListServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Goods> goodsList = goodsService.getGoodsList();

        request.setAttribute("goodsList", goodsList);
        request.getRequestDispatcher("/mainPage.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
