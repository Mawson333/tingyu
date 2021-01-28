package com.mawson.controller;


import com.mawson.pojo.Order;
import com.mawson.pojo.Result;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RestController;

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

}

