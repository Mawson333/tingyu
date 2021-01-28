package com.mawson.controller;


import com.mawson.pojo.Host;
import com.mawson.pojo.HostCondition;
import com.mawson.pojo.PageResult;
import com.mawson.pojo.Result;
import com.mawson.service.IHostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.ArrayList;
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
@RequestMapping("/host")
public class HostController {

    @Autowired
    private IHostService hostService;

    /**
     * 查询host数据
     * @param page
     * @param rows
     * @return
     */
    @RequestMapping("hostInfo")
    public PageResult<Host> hostInfo(Integer page , Integer rows , HostCondition hostCondition){

        PageResult<Host> pageResult = hostService.selectHostInfo(page,rows,hostCondition);

        return pageResult;
    }

    /**
     * 修改权重
     * @param host
     * @return
     */
    @RequestMapping("strongUp")
    public Result strongUp(Host host){
        boolean b = host.updateById();
        return new Result(b,b ? "修改权重成功" : "修改权重失败");
    }

    /**
     * 添加主持人的功能
     * @param host
     * @return
     */
    @RequestMapping("add")
    public Result add(Host host){
        // 设置没有提交的默认值
        host.setStatus("1");
        host.setStrong("20");
        host.setOrdernumber(0);
        // LocalDateTime 是java8 的日期时间类
        host.setStarttime(LocalDateTime.now());
        boolean insert = host.insert();
        return new Result(insert,insert ? "添加成功":"添加失败");
    }

    /**
     *  账号状态修改
     * @param hids
     * @param statuss
     * @return
     */
    @RequestMapping("updatestatus")
    public Result updatestatus(String hids,String statuss){
        // hids,statuss进行切割
        String[] hidsStr = hids.split(",");
        String[] statussStr = statuss.split(",");

        List<Host> list = new ArrayList<>();

        for (int i = 0; i < hidsStr.length; i++) {

            Host host = new Host();
            host.setHid(Integer.parseInt(hidsStr[i]));
            //修改的是状态
            // 如果你传递过来的是 1  修改为 0
            host.setStatus("1".equals(statussStr[i]) ? "0":"1");
            list.add(host);
        }
        //03 批量处理 更新操作
        boolean b = hostService.saveOrUpdateBatch(list);
        return new Result(b,b ? "批量处理状态成功":"批量处理状态失败");
    }
}

