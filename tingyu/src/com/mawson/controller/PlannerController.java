package com.mawson.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.mawson.pojo.PageResult;
import com.mawson.pojo.Planner;
import com.mawson.pojo.Result;
import com.mawson.service.IPlannerService;
import org.springframework.beans.factory.annotation.Autowired;
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
@RequestMapping("/planner")
public class PlannerController {

    @Autowired
    private IPlannerService plannerService;

    @RequestMapping("plannerInfo")
    public PageResult<Planner> plannerInfo(Integer cid){

        QueryWrapper<Planner> qr = new QueryWrapper<>();
        qr.eq("cid",cid);

        List<Planner> list = plannerService.list(qr);

        PageResult<Planner> pageResult = new PageResult<>();
        pageResult.setRows(list);
        pageResult.setTotal(list.size() + 0L );

        return pageResult;
    }

}

