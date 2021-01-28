package com.mawson.mapper;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.mawson.pojo.Host;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.mawson.pojo.HostCondition;
import org.apache.ibatis.annotations.Param;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author ${author}
 * @since 2021-01-08
 */
public interface HostMapper extends BaseMapper<Host> {

    /**
     * 分页查询host
     * @param p
     * @return
     */
    Page<Host> selectHostInfo(Page<Host> p ,@Param("hostCondition") HostCondition hostCondition);
}
