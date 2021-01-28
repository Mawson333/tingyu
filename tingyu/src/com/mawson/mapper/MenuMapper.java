package com.mawson.mapper;

import com.mawson.pojo.Menu;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author ${author}
 * @since 2021-01-08
 */
public interface MenuMapper extends BaseMapper<Menu> {

    /**
     * 查询Menu
     * @param pid
     * @param aid
     * @return
     */
    List<Menu> selectMenu(@Param("pid") Integer pid,@Param("aid") Integer aid);

}
