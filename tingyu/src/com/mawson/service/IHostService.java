package com.mawson.service;

import com.mawson.pojo.Host;
import com.baomidou.mybatisplus.extension.service.IService;
import com.mawson.pojo.HostCondition;
import com.mawson.pojo.PageResult;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ${author}
 * @since 2021-01-08
 */
public interface IHostService extends IService<Host> {


    /**
     * 查询host的数据
     * @param page
     * @param rows
     * @return
     */
    PageResult<Host> selectHostInfo(Integer page, Integer rows, HostCondition hostCondition);
}
