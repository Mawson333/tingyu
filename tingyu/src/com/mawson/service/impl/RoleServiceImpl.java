package com.mawson.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.mawson.mapper.AdminRoleMapper;
import com.mawson.mapper.RoleMenuMapper;
import com.mawson.pojo.*;
import com.mawson.mapper.RoleMapper;
import com.mawson.service.IRoleService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author ${author}
 * @since 2021-01-08
 */
@Service
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements IRoleService {

    @Autowired
    private RoleMapper roleMapper;

    @Autowired
    private RoleMenuMapper roleMenuMapper;

    @Autowired
    private AdminRoleMapper adminRoleMapper;

    @Override
    public PageResult<Role> selRoleInfoService(Integer page, Integer rows) {
        Page<Role> p = new Page<>(page, rows);

        Page<Role> rolePage = roleMapper.selectPage(p, null);

        List<Role> roles = rolePage.getRecords();

        for (Role role : roles) {

            QueryWrapper<RoleMenu> qr = new QueryWrapper<>();
            qr.select("mid").eq("rid",role.getRid());

            //把role对应的mids查询出来
            List<Object> objs = roleMenuMapper.selectObjs(qr);

            role.setMids(objs);
        }

        return new PageResult<Role>(rolePage.getTotal(),roles);
    }

    @Override
    public Result addRoleService(Role role, String mids) {
        // 添加角色信息
        boolean insert = role.insert();
        boolean flag = false;

        // 增加角色和菜单的关联
        if (StringUtils.hasText(mids)){
            String[] midStr = mids.split(",");

            for (String mid : midStr) {
                // 创建 菜单权限对象
                RoleMenu roleMenu = new RoleMenu();
                roleMenu.setMid(Integer.parseInt(mid));
                roleMenu.setRid(role.getRid());
                //添加
                flag = roleMenu.insert();
                if (!flag){
                    break;
                }
            }
        }
        return new Result(flag , flag ? "添加成功" : "添加失败");
    }

    @Override
    public Result upRoleInfoService(Role role, String mids) {
        //更新角色权限
        // 删除原有的权限
        QueryWrapper<RoleMenu> qr = new QueryWrapper<>();
        qr.eq("rid",role.getRid());
        roleMenuMapper.delete(qr);
        //增加新的菜单权限
        if (StringUtils.hasText(mids)){
            String[] midStr = mids.split(",");
            boolean f = false;
            for (String mid : midStr) {
                RoleMenu roleMenu = new RoleMenu();
                roleMenu.setRid(role.getRid());
                roleMenu.setMid(Integer.parseInt(mid));
                f = roleMenu.insert();
                if (!f){
                    break;
                }
            }
        }
        //更新角色信息
        boolean b = role.updateById();
        return new Result(b , b ? "角色修改成功" : "角色修改失败");
    }

    @Override
    public Result delRoleService(String rids) {
        // 获取  删除角色 的id数组
        String[] ridStr = rids.split(",");
        int i = roleMapper.deleteBatchIds(Arrays.asList(ridStr));
        // 删除 角色菜单对应数据和 用户角色数据
        for (String rid : ridStr) {
            //删除角色 菜单数据
            // t_role_menu数据
            QueryWrapper<RoleMenu> qr = new QueryWrapper<>();
            qr.eq("rid",rid);
            roleMenuMapper.delete(qr);

            //删除用户角色数据
            // t_admin_role 的数据
            QueryWrapper<AdminRole> qr1 = new QueryWrapper<>();
            qr1.eq("rid",rid);
            adminRoleMapper.delete(qr1);
        }
        return new Result(i > 0 , i > 0 ? "角色删除成功" : "角色删除失败");
    }
}
