package crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import crud.model.Employee;
import crud.model.Msg;
import crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import sun.awt.SunHints;
import sun.misc.CharacterEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by lrx on 2017/6/19.
 */
@Controller
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;

    /**
     * 校验添加的员工名字是否重复
     * @param empName
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/validateName")
    public Msg validateEmpName(@RequestParam("empName") String empName) {

//        try {
//            empName = new String(empName.getBytes("ISO-8859-1"),"UTF-8");
//        } catch (UnsupportedEncodingException e) {
//            e.printStackTrace();
//        }
//        System.out.println(empName);
        boolean result = employeeService.validateEmpName(empName);
        // 返回TRUE，名字可用
        if (result) {
            return Msg.success();
        }
        return Msg.fail();
    }

    /**
     * post请求保存用户至数据库
     * @param employee spring从表单绑定的员工对象
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emps", method = RequestMethod.POST)
    public Msg saveEmp(@Valid Employee employee,
                       Errors errors) {
        // 有错误
        if (errors.hasErrors()) {
            // 保存所有的错误信息
            Map<String, Object> map = new HashMap<String, Object>();
            for (FieldError fieldError : errors.getFieldErrors()) {
//                System.out.println(fieldError.getField() + ">>" + fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("err_msg", map);
        }
        employeeService.save(employee);
        return Msg.success();
    }

    /**
     * 需要导入Jackson包，使用ResponseBody注解将返回值转换为json数据
     * @param pn
     * @return
     */
    @ResponseBody
    @RequestMapping("/emps")
    public Msg listWithJson(@RequestParam(value="pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 10);
        List<Employee> list = employeeService.getAll();
//         将列表用pageInfo封装，第二个构造参数是连续显示的页数
        PageInfo pageInfo = new PageInfo(list, 5);
        return Msg.success().add("pageInfo", pageInfo);
    }
    /**
     * 查询所有员工信息
     * @param pn URL参数：页数
     * @return
     */
    //@RequestMapping("/emps")
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
