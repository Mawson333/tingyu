package com.mawson.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.mawson.pojo.Admin;
import com.mawson.pojo.AdminRole;
import com.mawson.pojo.Result;
import com.mawson.service.IAdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2021-01-08
 */
@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private IAdminService iAdminService;

    /**
     * 登录功能
     * 01 拿到数据
     * 02 调用方法 service
     * 03 判断 登录是否成功了
     * 04 成功把admin存储在session
     * 04 失败,重定向到login.jsp 带一个错误的信息过去
     * @return
     */
    @RequestMapping("/login")
    public String login(String aname , String apwd , HttpSession session){
        //构造器条件查询
        QueryWrapper<Admin> qr = new QueryWrapper<>();
        qr.eq("aname",aname).eq("apwd",apwd);

        Admin admin = iAdminService.getOne(qr);
        if (admin != null){
            session.setAttribute("admin",admin);
            //跳转主页页面
            return "redirect:/main.jsp";
        } else {
            session.setAttribute("msg","用户名或密码错误！");
            return "redirect:/login.jsp";
        }
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session){

        //销毁session
        session.invalidate();
        //重定向到登录页面
        return "redirect:/login.jsp";
    }

    @ResponseBody
    @RequestMapping("registered")
    public Result registered(Admin admin){

        admin.setStarttime(LocalDateTime.now());
        boolean insert = admin.insert();

        if (insert){
            AdminRole adminRole = new AdminRole();
            adminRole.setAid(admin.getAid());
            adminRole.setRid(2);
            boolean b = adminRole.insert();

            return new Result(b , b ? "注册成功" : "注册失败");
        } else {
            return new Result(false , "注册失败");
        }
    }

}

