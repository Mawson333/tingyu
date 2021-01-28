package com.mawson.service;

import com.mawson.pojo.Menu;
import com.baomidou.mybatisplus.extension.service.IService;
import com.mawson.pojo.Result;
import com.mawson.pojo.TreeResult;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ${author}
 * @since 2021-01-08
 */
public interface IMenuService extends IService<Menu> {

    // 通过 用户角色查询菜单信息
    List<TreeResult> selectMenuInfo(Integer pid, Integer aid);

    /**
     * 查询所有菜单
     * @param pid
     * @return
     */
    List<TreeResult> selectMenuAllInfo(Integer pid);

    List<TreeResult> selMenuAllInfoChildren();
}
