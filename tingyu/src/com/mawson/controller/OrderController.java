package com.mawson.controller;


import com.mawson.pojo.Order;
import com.mawson.pojo.Result;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RestController;

import java.sql.Date;
import java.time.Clock;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2021-01-08
 */
@RestController
@RequestMapping("/order")
public class OrderController {

    @RequestMapping("orderInfo")
    public List<Order> orderInfo(Order order){

        List<Order> orders = order.selectAll();

        return orders;
    }

    @RequestMapping("orderAdd")
    public Result orderAdd(String hotelname, String hoteladdress,double money){
        Order order = new Order();
        order.setHotelname(hotelname);
        order.setHoteladdress(hoteladdress);
        order.setOrdertime(LocalDateTime.now(Clock.system(ZoneId.of("Asia/Shanghai"))));
        order.setMoney(money);
        order.setStatus("1");
        order.setComment("1");

        boolean insert = order.insert();
        return new Result(insert , insert ? "添加订单成功！" : "添加订单失败");
    }

    @RequestMapping("orderUpdate")
    public Result orderUpdate(Order order){
        boolean b = order.updateById();
        return new Result(b , b ? "修改订单成功！" : "修改订单失败!");
    }

    @RequestMapping("orderDel")
    public Result orderDel(Order order){
        boolean b = order.deleteById();
        return new Result(b , b ? "删除订单成功！" : "删除订单失败!");
    }

}

