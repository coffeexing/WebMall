package net.coffeexing.webmall.service;

import net.coffeexing.webmall.entity.Order;

import java.util.List;

public interface OrderService {
    Order submitOrder(String userId, String addressId, String[] goodsBuyNum, String[] chooseGoodId);
    List<Order> getOrderByUserId(String userId);
}
