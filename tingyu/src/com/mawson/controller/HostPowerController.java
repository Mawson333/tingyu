package com.mawson.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.mawson.pojo.HostPower;
import com.mawson.pojo.Result;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2021-01-08
 */
@RestController
@RequestMapping("/hostPower")
public class HostPowerController {

    @RequestMapping("update")
    public Result update(HostPower hostPower){

        Integer hpid = hostPower.getHpid();

        if (hpid != null){
            boolean b = hostPower.updateById();
            return new Result(b , b ? "权限修改成功" : "权限修改失败" );
        } else {
            boolean insert = hostPower.insert();
            return new Result(insert,insert?"权限添加成功":"权限添加失败");
        }
    }

    @RequestMapping("batch")
    public Result batch(String hids , HostPower hostPower){

        //切割hids
        String[] hidStr = hids.split(",");
        System.out.println("hidStr = " + hidStr);
        boolean flag = false;

        for (int i = 0; i < hidStr.length; i++) {
            //主持人的hid
            String hid = hidStr[i];
            // 判断 hostpower是否存在 hostid
            HostPower hostPower1 = new HostPower();
            QueryWrapper<HostPower> qr = new QueryWrapper<>();
            qr.eq("hostid",hid);
            HostPower hostPower2 = hostPower1.selectOne(qr);
            //如果存在，删除之前的
            if (hostPower2 != null){
                hostPower2.deleteById();
            }
            //添加 新的hostpower
            hostPower.setHostid(Integer.parseInt(hid));
            flag = hostPower.insert();

            if (!flag){
                break;
            }
        }
        return new Result(flag , flag ? "批量处理修改成功" : "批量处理修改失败");
    }

}

