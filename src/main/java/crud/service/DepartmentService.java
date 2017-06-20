package crud.service;

/**
 * Created by lrx on 2017/6/20.
 */

import crud.dao.DepartmentMapper;
import crud.model.Department;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 处理department相关业务
 */
@Service
public class DepartmentService {
    @Autowired
    private DepartmentMapper departmentMapper;

    /**
     * 查询所有的部门信息
     * @return 部门信息列表列表
     */
    public List<Department> getAllDept() {
        return departmentMapper.selectByExample(null);
    }
}
