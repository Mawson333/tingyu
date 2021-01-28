package com.mawson.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.mawson.pojo.Host;
import com.mawson.mapper.HostMapper;
import com.mawson.pojo.HostCondition;
import com.mawson.pojo.PageResult;
import com.mawson.service.IHostService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author ${author}
 * @since 2021-01-08
 */
@Service
public class HostServiceImpl extends ServiceImpl<HostMapper, Host> implements IHostService {

    @Autowired
    private HostMapper hostMapper;

    /**
     * 查询host的数据
     * @param page
     * @param rows
     * @return
     */
    @Override
    public PageResult<Host> selectHostInfo(Integer page, Integer rows, HostCondition hostCondition) {

        //创建分页对象
        Page<Host> p = new Page<>(page, rows);
        //返回Page对象
        Page<Host> hostPage = hostMapper.selectHostInfo(p,hostCondition);

        //把分页对象转成pageResult对象
        PageResult<Host> pageResult = new PageResult<>();
        pageResult.setTotal(hostPage.getTotal());
        pageResult.setRows(hostPage.getRecords());

        return pageResult;
    }
}
