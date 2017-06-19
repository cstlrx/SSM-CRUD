package crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import crud.model.Employee;
import crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import sun.awt.SunHints;

import java.util.List;

/**
 * Created by lrx on 2017/6/19.
 */
@Controller
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;
    /**
     * 查询所有员工信息
     * @param pn URL参数：页数
     * @return
     */
    @RequestMapping("/emps")
    public String list(@RequestParam(value="pn", defaultValue = "1") Integer pn,
                       Model model) {

        // PageHelper后边紧跟的查询会是分页查询
//        每次查10条信息
        PageHelper.startPage(pn, 10);
        List<Employee> list = employeeService.getAll();

//         将列表用pageInfo封装，第二个构造参数是连续显示的页数
        PageInfo pageInfo = new PageInfo(list, 5);
        model.addAttribute("pageInfo", pageInfo);
        return "list";
    }
}
