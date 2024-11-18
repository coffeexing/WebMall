package net.coffeexing.webmall.service.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import net.coffeexing.webmall.entity.Goods;
import net.coffeexing.webmall.service.GoodsService;
import net.coffeexing.webmall.dao.BaseDao;

public class GoodsServiceImpl implements GoodsService {

    /**
     * 商品详情接口
     */
    @Override
    public Goods getGoodsByGoodsId(String goodsId) {
        /********* Begin *********/
        String sql = "select * from t_goods where goodsId = ?";
        List<Object> parameters = new ArrayList<Object>();
        parameters.add(goodsId);
        List<Goods> goodsList = null;
        try {
            goodsList = BaseDao.operQuery(sql, parameters, Goods.class);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return goodsList.size() == 0 ? null : goodsList.get(0);
        /********* End *********/
    }

    /**
     * 商品搜索接口
     */
    @Override
    public List<Goods> searchGoods(String condition) {
        /********* Begin *********/
        String sql = "select * from t_goods where goodsName like ? or goodsClass like ? order by salesNum desc";
        List<Goods> goodsList = null;
        condition = "%" + condition + "%";
        List<Object> paramenter = new ArrayList<Object>();
        paramenter.add(condition);
        paramenter.add(condition);
        try {
            goodsList = BaseDao.operQuery(sql, paramenter, Goods.class);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return goodsList;
        /********* End *********/
    }

    /**
     * 商品列表接口
     */
    @Override
    public List<Goods> getGoodsList() {
        /********* Begin *********/
        Connection conn = null;
        PreparedStatement pste = null;
        ResultSet executeQuery = null;
        List<Goods> list = new ArrayList<Goods>();
        String sql = "select * from t_goods order by salesNum desc limit 4";
        try {
            conn = BaseDao.getConn();
            pste = conn.prepareStatement(sql);
            executeQuery = pste.executeQuery();
            while (executeQuery.next()) {
                Goods goods = new Goods();
                goods.setGoodsId(executeQuery.getString("goodsId"));
                goods.setGoodsName(executeQuery.getString("goodsName"));
                goods.setGoodsImg(executeQuery.getString("goodsImg"));
                goods.setGoodsPrice(executeQuery.getBigDecimal("goodsPrice"));
                goods.setGoodsNum(executeQuery.getInt("goodsNum"));
                goods.setSalesNum(executeQuery.getInt("salesNum"));
                goods.setGoodsSize(executeQuery.getString("goodsSize"));
                goods.setGoodsFrom(executeQuery.getString("goodsFrom"));
                goods.setGoodsTime(executeQuery.getString("goodsTime"));
                goods.setGoodsSaveCondition(executeQuery.getString("goodsSaveCondition"));
                goods.setGoodsDescribe(executeQuery.getString("goodsDescribe"));
                goods.setGoodsExplain(executeQuery.getString("goodsExplain"));
                goods.setGoodsClass(executeQuery.getString("goodsClass"));
                goods.setGoodsDiscount(executeQuery.getBigDecimal("goodsDiscount"));
                goods.setDiscountStartTime(executeQuery.getDate("discountStartTime"));
                goods.setDiscountEndTime(executeQuery.getDate("discountEndTime"));
                list.add(goods);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (executeQuery != null) {
                    executeQuery.close();
                }
                if (pste != null) {
                    pste.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return list;
        /********* End *********/
    }
}