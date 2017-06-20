package crud.controller;

/**
 * Created by lrx on 2017/6/20.
 */

import crud.model.Department;
import crud.model.Msg;
import crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 部门相关
 */
@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    /**
     * 相应客户端的ajax请求
     * @return 包含department列表信息的json数据
     */
    @ResponseBody
    @RequestMapping("/depts")
    public Msg getDepartments() {
        List<Department> list = departmentService.getAllDept();
        return Msg.success().add("depts", list);
    }
}
