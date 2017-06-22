package crud.service;

import crud.dao.EmployeeMapper;
import crud.model.Employee;
import crud.model.EmployeeExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by lrx on 2017/6/19.
 */
@Service
public class EmployeeService {
    @Autowired
    private EmployeeMapper employeeMapper;

    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }

    /**
     * 保存员工信息
     * @param employee 员工
     */
    public void save(Employee employee) {
        System.out.println("用户保存");
        employeeMapper.insertSelective(employee);
    }

    /**
     *  查询数据库中是否存在此名字
     * @param empName
     * @return true:名字可用，否则不可用
     */
    public boolean validateEmpName(String empName) {
        // 构造查询条件
        EmployeeExample employeeExample = new EmployeeExample();
        employeeExample.createCriteria().andEmpNameEqualTo(empName);

        Long count = employeeMapper.countByExample(employeeExample);
        return count == 0;
    }

    /**
     * 更新员工信息
     * @param employee
     */
    public void updateEmp(Employee employee) {
        System.out.println("Update");
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    /**
     * 删除员工
     * @param id
     */
    public void deleteById(Integer id) {
        System.out.println("删除");
        employeeMapper.deleteByPrimaryKey(id);
    }
}
