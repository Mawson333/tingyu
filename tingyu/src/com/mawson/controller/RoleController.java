package com.mawson.controller;


import com.mawson.pojo.PageResult;
import com.mawson.pojo.Result;
import com.mawson.pojo.Role;
import com.mawson.service.IRoleService;
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
@RequestMapping("/role")
public class RoleController {

    @Autowired
    private IRoleService roleService;

    @RequestMapping("roleInfo")
    public PageResult roleInfo(Integer page,Integer rows){

        PageResult<Role> pageResult = roleService.selRoleInfoService(page,rows);

        return pageResult;
    }

    @RequestMapping("roleAdd")
    public Result roleAdd(Role role,String mids){

        return roleService.addRoleService(role,mids);
    }

    @RequestMapping("roleEdit")
    public Result roleEdit(Role role,String mids){
        //处理请求
        Result result = roleService.upRoleInfoService(role,mids);

        return result;
    }

    @RequestMapping("roleDel")
    public Result roleDel(String rids){
        // 处理请求
        Result result = roleService.delRoleService(rids);
        //响应结果
        return result;
    }

}

