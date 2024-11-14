package net.coffeexing.webmall.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import net.coffeexing.webmall.dao.BaseDao;
import net.coffeexing.webmall.entity.Order;
import net.coffeexing.webmall.service.OrderService;

public class OrderServiceImpl implements OrderService {
    private CartServiceImpl catService = new CartServiceImpl();

    // 下单
    @Override
    public Order submitOrder(String userId, String addressId, String[] goodsBuyNum,
                             String[] chooseGoodId) {
        /********* Begin *********/
        Order order = new Order();
        String ordersql = "insert into t_order(orderId, userId, orderTime, addressId) values(?, ?, ?, ?)";
        String child_order_sql = "insert into t_order_child (orderId, goodsId, buyNum) values( ?, ?, ?) ";
        String orderId = UUID.randomUUID().toString();
        List<Object> parameters = new ArrayList<Object>();
        parameters.add(orderId);
        parameters.add(userId);
        parameters.add(new Date());
        parameters.add(addressId);
        BaseDao.operUpdate(ordersql, parameters);
        for (int n = 0; n < chooseGoodId.length; n++) {
            parameters.clear();
            parameters.add(orderId);
            parameters.add(chooseGoodId[n]);
            parameters.add(goodsBuyNum[n]);
            BaseDao.operUpdate(child_order_sql, parameters);
            //下单后，需要清空购物车
            catService.doCartHandle(userId, chooseGoodId[n], null, null);
        }
        //返回带有订单id的订单
        order.setOrderId(orderId);
        return order;
        /********* End *********/
    }

    // 订单查询
    @Override
    public List<Order> getOrderByUserId(String userId) {
        /********* Begin *********/
        String sql = "select A.orderId, A.userId, B.userName, A.orderTime, C.address, E.goodsId, E.goodsName, D.buyNum, E.goodsPrice from " +
                "t_order as A, t_user as B, t_address as C, t_order_child as D, t_goods as E " +
                "where A.userId=? and A.orderId=D.orderId and A.userId=B.userId and A.addressId=C.addressId and D.goodsId=E.goodsId " +
                "order by orderTime desc";
        List<Object> parameters = new ArrayList<Object>();
        parameters.add(userId);
        List<Order> orderList = null;
        try {
            orderList = BaseDao.operQuery(sql, parameters, Order.class);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orderList;
        /********* End *********/
    }
}