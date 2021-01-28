package com.mawson.controller;


import com.mawson.mapper.MarriedPersonMapper;
import com.mawson.pojo.MarriedPerson;
import com.mawson.pojo.PageResult;
import com.mawson.service.IMarriedPersonService;
import org.springframework.beans.factory.annotation.Autowired;
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
@RequestMapping("/marriedPerson")
public class MarriedPersonController {

    @Autowired
    private IMarriedPersonService marriedPersonService;

    @RequestMapping("marriedPersonInfo")
    public PageResult<MarriedPerson> marriedPersonInfo(Integer page, Integer rows, String pname, String phone){

        PageResult<MarriedPerson> pageResult = marriedPersonService.setMarriedPersoninfoService(page, rows, pname, phone);

        return pageResult;
    }

}

