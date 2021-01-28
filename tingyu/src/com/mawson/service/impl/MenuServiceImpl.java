package com.mawson.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.mawson.mapper.AdminMapper;
import com.mawson.mapper.AdminRoleMapper;
import com.mawson.mapper.RoleMenuMapper;
import com.mawson.pojo.AdminRole;
import com.mawson.pojo.Menu;
import com.mawson.mapper.MenuMapper;
import com.mawson.pojo.TreeResult;
import com.mawson.service.IMenuService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sun.org.apache.bcel.internal.generic.NEW;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author ${author}
 * @since 2021-01-08
 */
@Service
public class MenuServiceImpl extends ServiceImpl<MenuMapper, Menu> implements IMenuService {

/*    //声明 用户角色表的mapper
    @Autowired
    private AdminRoleMapper adminRoleMapper;

    // 声明 角色菜单表的mapper
    @Autowired
    private RoleMenuMapper roleMenuMapper;*/

    //声明 菜单表的mapper
    @Autowired
    private MenuMapper menuMapper;

    /**
     * 通过 pid, aid 查询菜单
     * @param pid
     * @param aid
     * @return
     */
    @Override
    public List<TreeResult> selectMenuInfo(Integer pid, Integer aid) {

        //直接查询menu
        List<Menu> menus = menuMapper.selectMenu(pid, aid);

        //TreeResult集合
        ArrayList<TreeResult> list = new ArrayList<>();

        for (Menu menu : menus) {
            //把menu转成TreeResult
            TreeResult treeResult = new TreeResult();
            treeResult.setId(menu.getMid());
            treeResult.setText(menu.getMname());
            //判断是否为文件夹
            treeResult.setState("1".equals(menu.getIsparent()) ? "closed" : "open");

            //把需要的自定义属性传到页面的tree中
            Map<String, String> map = new HashMap<>();
            map.put("isparent",menu.getIsparent());
            map.put("url",menu.getUrl());

            treeResult.setAttributes(map);

            list.add(treeResult);
        }

        return list;
    }

    @Override
    public List<TreeResult> selectMenuAllInfo(Integer pid) {

        QueryWrapper<Menu> qr = new QueryWrapper<>();
        qr.eq("pid",pid);
        List<Menu> menus = menuMapper.selectList(qr);

        //把menu转成TreeResult的数据
        List<TreeResult> list = new ArrayList<>();

        for (Menu menu : menus) {
            //把menu转成TreeResult
            TreeResult treeResult = new TreeResult();
            treeResult.setId(menu.getMid());
            treeResult.setText(menu.getMname());
            //判断是否为文件夹
            treeResult.setState("1".equals(menu.getIsparent()) ? "closed" : "open");

            //把需要的自定义属性传到页面的tree中
            Map<String, String> map = new HashMap<>();
            map.put("isparent",menu.getIsparent());
            map.put("url",menu.getUrl());
            map.put("mdesc",menu.getMdesc());
            map.put("pid",String.valueOf(menu.getPid()));

            treeResult.setAttributes(map);

            list.add(treeResult);
        }

        return list;
    }

    @Override
    public List<TreeResult> selMenuAllInfoChildren() {
        // 获取所有的 菜单信息
        List<Menu> menus = menuMapper.selectList(null);
        //按照层级关系 组装菜单
        // 0 是一级菜单
        List<TreeResult> list = getMenuInfo(menus,0);

        return list;
    }

    /**
     *
     * @param menus 查询的菜单
     * @param pid   父级菜单
     * @return
     */
    private List<TreeResult> getMenuInfo(List<Menu> menus, int pid) {
//        01创建一个存储TreeResult 集合
//        02遍历List<Menu> 获取上级的id 为pid的menu
//        03把menu转成 TreeResult  设置state属性, 1 父级菜单设置open,设置自定义attributes 属性
//        04 使用递归 看这个菜单是否有子菜单,设置到treeResult,children属性

        List<TreeResult> list = new ArrayList<>();

        for (Menu menu : menus) {

            //判断
            if (menu.getPid() == pid){
                TreeResult tr = new TreeResult();
                tr.setId(menu.getMid());
                tr.setText(menu.getMname());
                //父级菜单默认全部打开
                tr.setState("1".equals(menu.getStatus()) ? "open" : "close");

                //创建map集合
                Map<String,String> map = new HashMap<>();
                map.put("isparent",menu.getIsparent());
                map.put("url",menu.getUrl());
                map.put("mdesc",menu.getMdesc());
                map.put("pid",String.valueOf(menu.getPid()));

                tr.setAttributes(map);

                //使用递归 看这个菜单是否有子菜单
                if ("1".equals(menu.getIsparent())){
                    List<TreeResult> menuInfo = getMenuInfo(menus, menu.getMid());
                    tr.setChildren(menuInfo);
                }
                // 把转换后的TreeResult 对象存储到集合中
                list.add(tr);
            }

        }
        return list;
    }
}
