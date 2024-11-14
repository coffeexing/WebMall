package net.coffeexing.webmall.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;

import net.coffeexing.webmall.dao.BaseDao;
import net.coffeexing.webmall.entity.Cart;
import net.coffeexing.webmall.entity.User;
import net.coffeexing.webmall.service.CartService;

public class CartServiceImpl implements CartService {
    // 查询购物车列表
    public List<Cart> getGoodsByUserId(HttpServletRequest request) {
        /********* Begin *********/
        User user = (User) request.getSession().getAttribute("user");
        String userId = user.getUserId();
        String sql = "select * from t_cart as a, t_goods as b where a.goodsId = b.goodsId and a.userId = ?";
        List<Cart> cartList = null;
        List<Object> parameters = new ArrayList<Object>();
        parameters.add(userId);
        try {
            cartList = BaseDao.operQuery(sql, parameters, Cart.class);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cartList;
        /********* End *********/
    }

    // 购物车操作接口
    @Override
    public void doCartHandle(String userId, String goodsId, String buyNum, String oper) {
        /********* Begin *********/
        String deletesql = "delete from t_cart where userId=? and goodsId=?";
        String querysql = "select * from t_cart where userId = ? and goodsId = ?";
        String updatesql = "update t_cart set buyNum=? where userId=? and goodsId=?";
        String addsql = "insert into t_cart(userId, goodsId, buyNum, addTime) values(?, ?, ?, ?)";
        List<Object> parameters = new ArrayList<Object>();
        //删除
        if (buyNum == null) {
            parameters.add(userId);
            parameters.add(goodsId);
            BaseDao.operUpdate(deletesql, parameters);
        } else {
            //进行修改和添加
            List<Cart> goodsList = null;
            parameters.add(userId);
            parameters.add(goodsId);
            try {
                goodsList = BaseDao.operQuery(querysql, parameters, Cart.class);
                parameters.clear();
            } catch (Exception e) {
                e.printStackTrace();
            }
            //进行添加
            if (goodsList.isEmpty()) {
                parameters.add(userId);
                parameters.add(goodsId);
                parameters.add(buyNum);
                parameters.add(new Date());
                BaseDao.operUpdate(addsql, parameters);
            } else {
                //进行修改
                if (oper != null) {
                    buyNum += goodsList.get(0).getBuyNum();
                    parameters.add(buyNum);
                    parameters.add(userId);
                    parameters.add(goodsId);
                    BaseDao.operUpdate(updatesql, parameters);
                }
            }
        }
        /********* End *********/
    }
}