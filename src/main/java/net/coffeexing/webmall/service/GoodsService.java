package net.coffeexing.webmall.service;

import net.coffeexing.webmall.entity.Goods;

import java.util.List;

public interface GoodsService {
    Goods getGoodsByGoodsId(String goodsId);
    List<Goods> searchGoods(String condition);
    List<Goods> getGoodsList();
}
