package com.mawson.service;

import com.mawson.pojo.MarriedPerson;
import com.baomidou.mybatisplus.extension.service.IService;
import com.mawson.pojo.PageResult;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ${author}
 * @since 2021-01-08
 */
public interface IMarriedPersonService extends IService<MarriedPerson> {

    PageResult<MarriedPerson> setMarriedPersoninfoService(Integer page, Integer rows, String pname, String phone);
}

