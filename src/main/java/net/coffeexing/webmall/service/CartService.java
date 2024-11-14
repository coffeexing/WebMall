package net.coffeexing.webmall.service;

import net.coffeexing.webmall.entity.Cart;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface CartService {
    List<Cart> getGoodsByUserId(HttpServletRequest request);
    void doCartHandle(String userId, String goodsId, String buyNum, String oper);
}
