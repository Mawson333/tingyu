package com.mawson.service;

import com.mawson.pojo.Company;
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
public interface ICompanyService extends IService<Company> {

    /**
     * 分页查询公司信息
     * @param page
     * @param rows
     * @param cname        名称的条件查询
     * @param status       状态
     * @param ordernumber  订单数量
     * @return
     */
    PageResult<Company> selectCompanyInfo(Integer page, Integer rows, String cname, String status, String ordernumber);
}
