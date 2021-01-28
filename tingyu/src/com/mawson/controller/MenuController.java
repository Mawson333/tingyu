package com.mawson.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.mawson.pojo.Admin;
import com.mawson.pojo.Menu;
import com.mawson.pojo.Result;
import com.mawson.pojo.TreeResult;
import com.mawson.service.IMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import sun.reflect.generics.tree.Tree;

import javax.servlet.http.HttpSession;
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
@RequestMapping("/menu")
public class MenuController {

    @Autowired
    private IMenuService menuService;

    /**
     *
     * @param id        页面传入过来id (菜单的id 通过这个id可以查询菜单的子菜单)
     * @param session   从session中获取 user 获取对象
     * @return
     */
    @RequestMapping("menuInfo")
    public List<TreeResult> menuInfo(@RequestParam(defaultValue = "0") Integer id , HttpSession session){

        //拿到 session中存储的 admin
        Admin admin = (Admin) session.getAttribute("admin");

        // 查询菜单 aid 通过 aid查询 rid
        Integer aid = admin.getAid();
        List<TreeResult> list = null;
        if (admin != null){
            list = menuService.selectMenuInfo(id, aid);
        }
        return list;
    }

    /**
     * 查询所有菜单
     * @param id
     * @return
     */
    @RequestMapping("menuAllInfo")
    public List<TreeResult> menuAllInfo(@RequestParam(defaultValue = "0") Integer id){

        List<TreeResult> list = menuService.selectMenuAllInfo(id);

        return list;
    }

    @RequestMapping("menuAdd")
    public Result menuAdd(Menu menu){
        Integer pid = menu.getPid();

        //没有pid，设为0
        if (pid == null){
            menu.setPid(0);
        } else {
            Menu m = new Menu();
            // 父级菜单的mid 为 当前的菜单的pid
            m.setMid(pid);
            m.setIsparent("1");
            // 更新父级菜单
            m.updateById();
        }
        // 添加新增菜单
        // 没有的值给默认值
        menu.setIsparent("0");
        menu.setStatus("0");

        boolean insert = menu.insert();
        return new Result(insert,insert?"添加成功":"添加失败");
    }

    @RequestMapping("meunEdit")
    public Result meunEdit(Menu menu){

        boolean b = menu.updateById();
        return new Result(b , b ? "修改成功" : "修改失败");

    }

    @RequestMapping("menuDel")
    public Result menuDel(Menu menu){

        //判断父节点是否有 子节点
        Menu m = new Menu();
        m.setMid(menu.getPid());

        QueryWrapper<Menu> qr = new QueryWrapper<>();
        qr.eq("pid",m.getMid());
        // 通过 pid 查询父节点是否有子节点
        Integer i = m.selectCount(qr);
        // 删除这个子菜单 父菜单要修改为普通菜单
        // 校验子菜单数量是否为1  如果是则更新上级菜单为普通菜单
        if (i == 1){
            m.setIsparent("0");
            m.updateById();
        }
        //删除正常的子节点
        boolean b = menu.deleteById();
        return new Result(b,b?"删除成功":"删除失败");
    }

    @RequestMapping("menuAllInfoChildren")
    public List<TreeResult> menuAllInfoChildren(){
        //调用业务层的方法
        List<TreeResult> list = menuService.selMenuAllInfoChildren();

        return list;
    }

}

