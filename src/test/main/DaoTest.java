package main;

import com.github.pagehelper.PageInfo;
import crud.dao.DepartmentMapper;
import crud.dao.EmployeeMapper;
import crud.model.Department;
import crud.model.Employee;
import crud.service.EmployeeService;
import org.apache.ibatis.session.SqlSession;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.UUID;
/**
 * Created by lrx on 2017/6/19.
 */

/**
 * 测试Dao层的方法
 * ContextConfiguration指定配置文件位置
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml", "file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
public class DaoTest {

    @Autowired
    private DepartmentMapper departmentMapper;

    @Autowired
    private EmployeeMapper employeeMapper;


    @Autowired
    private SqlSession sqlSession;

    @Autowired
    WebApplicationContext context;

    MockMvc mockMvc;

    /**
     * 初始化MockMVC，每次都要调用
     */
    @Before
    public void initMockMvc() {
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }
    // 单元测试，测试分页效果
    @Test
    public void empsTest() throws Exception {
        // 虚拟MVC请求
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps?pn=1"))
                .andReturn();
        MockHttpServletRequest request = result.getRequest();
        PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("总页数："+pageInfo.getPages());
        System.out.println("当前页数："+pageInfo.getPageNum());
        System.out.println("总条目数："+pageInfo.getTotal());

        int[] nums = pageInfo.getNavigatepageNums();
        for (int i:nums) {
            System.out.print(" " + i);
        }

    }
    @Test
    public void departmentTest() {
        System.out.println(departmentMapper);
//        插入数据
//        departmentMapper.insertSelective(new Department("开发部"));
//        departmentMapper.insertSelective(new Department("测试部"));
//        departmentMapper.insertSelective(new Department("鼓励部"));
//        employeeMapper.insertSelective(new Employee(null,"李四", "男", "lrx@163.com", 1));
//        employeeMapper.insertSelective(new Employee(null,"张三", "男", "lrx@163.com", 2));

//        批量插入多个元素

        // 批量插入
//        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
//        for (int i=0; i<1000; i++) {
//            String uuid = UUID.randomUUID().toString().substring(0,5) + i;
//            mapper.insertSelective(new Employee(null, uuid, "M", uuid+"@lrx.com",1));
//        }
//        System.out.println("批量完成");
//        测试删除 修改
//        employeeMapper.deleteByPrimaryKey(3);

    }
}
