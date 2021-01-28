package com.mawson.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.mawson.pojo.Company;
import com.mawson.mapper.CompanyMapper;
import com.mawson.pojo.PageResult;
import com.mawson.service.ICompanyService;
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
public class CompanyServiceImpl extends ServiceImpl<CompanyMapper, Company> implements ICompanyService {

    @Autowired
    private CompanyMapper companyMapper;

    @Override
    public PageResult<Company> selectCompanyInfo(Integer page, Integer rows, String cname, String status, String ordernumber) {

        //构造分页对象
        Page<Company> p = new Page<>(page,rows);

        //条件查询
        QueryWrapper<Company> qr = new QueryWrapper<>();
        // cname 的条件查询
        if (cname != null && !"".equals(cname)){
            qr.like("cname",cname);
        }

        // status 的条件查询
        if (status != null && !"".equals(status)){
            qr.eq("status",status);
        }

        // ordernumber 的条件查询
        if (ordernumber != null && !"".equals(ordernumber)){

            //升序
            if (ordernumber.equals("asc")){
                qr.orderByAsc("ordernumber");
            }
            //降序
            if (ordernumber.equals("desc")){
                qr.orderByDesc("ordernumber");
            }
        }

        Page<Company> companyPage = companyMapper.selectPage(p,qr);

        // 02 组装 pageResult
        PageResult<Company> pageResult = new PageResult<>();
        pageResult.setTotal(companyPage.getTotal());
        pageResult.setRows(companyPage.getRecords());

        return pageResult;
    }
}
