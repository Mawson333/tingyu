package com.mawson.controller;


import com.mawson.pojo.Company;
import com.mawson.pojo.PageResult;
import com.mawson.pojo.Result;
import com.mawson.service.ICompanyService;
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
@RequestMapping("/company")
public class CompanyController {

    @Autowired
    private ICompanyService companyService;

    @RequestMapping("companyInfo")
    public PageResult<Company> companyInfo(Integer page, Integer rows, String cname, String status, String ordernumber){
        // 调用服务器层
        PageResult<Company> pageResult = companyService.selectCompanyInfo(page,rows,cname,status,ordernumber);

        return pageResult;
    }

    @RequestMapping("companyAdd")
    public Result companyAdd(Company company){
        //设置默认值
        company.setStarttime(LocalDateTime.now());
        company.setStatus("1");
        company.setOrdernumber(0);

        //添加
        boolean insert = company.insert();
        return  new Result(insert,insert ? "添加公司成功" : "添加公司失败");
    }

    @RequestMapping("companyUpdate")
    public Result companyUpdate(Company company){

        //修改操作
        boolean b = company.updateById();
        return  new Result(b , b ? "修改公司成功":"修改公司失败");

    }

    @RequestMapping("companyStatues")
    public Result companyStatues(String cids,String statuss){
        //拿到数据进行切割
        String[] cidsStr = cids.split(",");
        String[] statussStr = statuss.split(",");

        List<Company> list = new ArrayList<>();

        for (int i = 0; i < cidsStr.length; i++) {

            Company company = new Company();
            company.setCid(Integer.parseInt(cidsStr[i]));
            company.setStatus(statussStr[i].equals("1") ? "0":"1");
            list.add(company);
        }

        // 更新的批处理
        boolean b = companyService.saveOrUpdateBatch(list);
        return   new Result(b,b?"修改公司状态成功":"修改公司状态失败");
    }

}

