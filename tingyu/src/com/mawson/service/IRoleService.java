package com.mawson.service;

import com.mawson.pojo.PageResult;
import com.mawson.pojo.Result;
import com.mawson.pojo.Role;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ${author}
 * @since 2021-01-08
 */
public interface IRoleService extends IService<Role> {

    PageResult<Role> selRoleInfoService(Integer page, Integer rows);

    Result addRoleService(Role role, String mids);

    Result upRoleInfoService(Role role, String mids);

    Result delRoleService(String rids);
}
