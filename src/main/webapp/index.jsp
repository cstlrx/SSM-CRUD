<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <title>Employee List</title>
    <%--引入样式--%>
    <%--web 路径
    不一 / 开始的路径，以当前资源路径为基准
    以 / 开始的路径以当前服务器为基准
    --%>
    <%--注意导入顺序--%>
    <script type="text/javascript" src="static/js/jquery-2.1.4.min.js"></script>
    <link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet"/>
    <script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <script src="static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
</head>
<body>

    <!-- 员工新增模态框 -->
    <div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">新增</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label for="name_add_input" class="col-sm-2 control-label">EmpName</label>
                            <div class="col-sm-10">
                                <input type="text" name="empName" class="form-control" id="name_add_input" placeholder="name">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                        <label class="col-sm-2 control-label">Gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                        <div class="form-group">
                            <label for="email_add_input" class="col-sm-2 control-label">Email</label>
                            <div class="col-sm-10">
                                <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Department</label>
                            <div class="col-sm-4">
                                <select name="deptId" class="form-control">
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="add_save_button">Save</button>
                </div>
            </div>
        </div>
    </div>

<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12"><h1>员工管理系统</h1></div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn-primary" id="addBtn">新增</button>
            <button class="btn-danger">删除</button>
        </div>
    </div>
    <%--信息--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover table-striped table-bordered" id="emps_table">
                <thead>
                    <tr>
                        <th>id</th>
                        <th>名字</th>
                        <th>性别</th>
                        <th>email</th>
                        <th>公寓</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>

        </div>
    </div>
    <%--分页条--%>
    <div class="row">
        <div class="col-md-6" id="page_inf">

        </div>
        <div class="col-md-6" >
            <nav aria-label="Page navigation">
                <ul class="pagination" id="navUl">
                </ul>
            </nav>
        </div>
    </div>
    <script>
        $(function () {
//            发送ajax请求
           to_page(1);
        });

        /**
         *  跳转到某个页面
        */
         function to_page(pn) {
            $.ajax({
                url:"<%=path%>/emps",
                data:"pn=" + pn,
                type:"GET",
                success:function (result) {
                    //console.log(result);
                    // 显示员工信息
                    build_emps_table(result);
//                    显示分页信息
                    build_page_nav(result);

                }
            });
        }
        /**
         * 员工信息的显示
         * @param result 服务器返回的json数据
         */
        function build_emps_table(result) {
            // 先清空上一次的内容
            $("#emps_table tbody").empty();

            // 拿到json中的员工列表
            var emps = result.extend.pageInfo.list;

//                jQuery提供的遍历方法,回调函数：索引和每一项信息
            $.each(emps, function (index, item) {
                var idTd = $("<td></td>").append(item.empId);
                var nameTd = $("<td></td>").append(item.empName);
                var genderTd = $("<td></td>").append(item.gender=="M"?"男":"女");
                var emailTd = $("<td></td>").append(item.email);
                var departmentTd = $("<td></td>").append(item.department.deptName);
//                    <button class="btn-primary btn-xs">
//                        编辑
//                        <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
//                        </button>
                var editBtn = $("<button></button>").addClass("btn-primary btn-xs")
                    .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                    .append("编辑");
                var delBtn = $("<button></button>").addClass("btn-danger btn-xs")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                    .append("删除");
                var btnTd = $("<td></td>").append(editBtn)
                    .append(" ")
                    .append(delBtn);
                var tr = $("<tr></tr>").append(idTd)
                    .append(nameTd)
                    .append(genderTd)
                    .append(emailTd)
                    .append(departmentTd)
                    .append(btnTd);
                $("#emps_table tbody").append(tr);
            });
        }

        /**
         * 分页信息的显示
         * @param result 服务器返回的json数据
         */
        function build_page_nav(result) {
            // 先清空
            $("#page_inf").empty();
            $("#navUl").empty();

            var pageInfo = result.extend.pageInfo;
            // 添加左侧页数信息
            $("#page_inf").append("当前" + pageInfo.pageNum +
                "页,总" + pageInfo.pages +
                "页,总"+pageInfo.total +
                "记录");

            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页"));
            var lastPageLi = $("<li></li>").append($("<a></a>").append("末页"));
            var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
            var nextPageLI = $("<li></li>").append($("<a></a>").append("&raquo;"));

            $("#navUl").append(firstPageLi);
            $("#navUl").append(prePageLi);

            // 添加首页导航
            // 只有当不是第一页时显示
            if (pageInfo.pageNum == 1) {
                firstPageLi.addClass("disabled");
            }
            if (!pageInfo.hasPreviousPage) {
                prePageLi.addClass("disabled");
            } else {
                prePageLi.click(function () {
                    to_page(pageInfo.pageNum - 1);
                });
            }

            var navNums = pageInfo.navigatepageNums;
            // 遍历当前显示页数
            $.each(navNums, function (index, item) {
                var li = $("<li></li>").append($("<a></a>").append(item))
                    .click(function () {
                        to_page(item);
                    });
                if (item == pageInfo.pageNum) {
                    li.addClass("active");
                }
                $("#navUl").append(li);
            });

            $("#navUl").append(nextPageLI);
            $("#navUl").append(lastPageLi);
            if (!pageInfo.hasNextPage) {
                nextPageLI.addClass("disabled");
            } else {
                nextPageLI.click(function () {
                    to_page(pageInfo.pageNum + 1);
                });
            }
            // 添加末页导航
            if (pageInfo.pageNum == pageInfo.pages) {
                lastPageLi.addClass("disabled");
            }
            firstPageLi.click(function () {
                to_page(1);
            });
            lastPageLi.click(function () {
                to_page(pageInfo.pages);
            });
        }
        /**
         *  点击新增按钮，发送ajax请求获取部门列表
         */
        $("#addBtn").click(function () {
//            先清空表单信息,调用dom对象的重置方法
            $("#empAddModal form")[0].reset();

            // 发送ajax请求获得部门信息
            $.ajax({
                url:"<%=path%>/depts",
                type:"GET",
                success:function(result){
                    $("#empAddModal select").empty();
//                    console.log(result);
                    // 将查询到的信息添加到下拉列表中
                    $.each(result.extend.depts,function (index, item) {
                        var option = $("<option></option>").append(item.deptName).attr("value",item.deptId);
                        $("#empAddModal select").append(option);
                    });
                }
            });
            // 弹出模态对话框
            $("#empAddModal").modal({
                backdrop:"static"
            });
        });

        /**
         *  输入框校验状态的改变
         */
        function validate_name(ele, state, text) {
            // 先清空上一次内容
            $(ele).parent().removeClass("has-error has-success");
            $(ele).next("span").text("");

            if (state == "success") {
                $(ele).parent().addClass("has-success");
                $(ele).next("span").text(text);
            } else {
                $(ele).parent().addClass("has-error");
                $(ele).next("span").text(text);
            }
        }
        /**
         *  前端校验表单
        **/
        function jQuery_validate_name() {
            // 1、先通过jQuery校验名字格式
            var name = $("#name_add_input").val();
            var nameReg = /(^[a-zA-Z0-9_-]{5,20}$)|(^[\u2E80-\u9FFF]{2,5})/;
            if (!nameReg.test(name)) {
                //alert("用户名需要为2-5位数字或5-20位字母和数字的组合");
                validate_name("#name_add_input", "fail", "用户名需要为2-5位数字或5-20位字母和数字的组合");
                return false;
            } else {
                validate_name("#name_add_input", "success", "");
            }
            return true;
        }
         function jQuery_validate_email() {
            // 2、通过jQuery校验邮箱
            var email = $("#email_add_input").val();
            var emailReg = /^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$/;
            if (!emailReg.test(email)) {
//                alert("邮箱格式不正确");
                validate_name("#email_add_input", "error", "邮箱格式不正确");
                return false;
            } else {
                validate_name("#email_add_input", "success", "");
            }
            return true;
        }
        $("#email_add_input").change(function () {
            var bool = jQuery_validate_email();
            // 邮箱格式不正确
            if (!bool) {
                $("#add_save_button").attr("validate_state", "error");
            } else {
                $("#add_save_button").attr("validate_state", "success");
            }
        });
        // 名字输入框ajax校验
        $("#name_add_input").change(function () {

            // 若前端校验不成功则不进行后端校验
            var bool = jQuery_validate_name();
            if (!bool) {
                return false;
            }

            var name = this.value;
            $.ajax({
                url:"<%=path%>/validateName",
                data:"empName="+name,
                type:"GET",
                success:function (result) {
                   // alert(result.code)
                    if (result.code == 200) {
                        // 可用
                        validate_name("#name_add_input", "success", "用户名可用");
                        // 名字可用，可以保存信息至数据库
                        $("#add_save_button").attr("validate_state","success");
                    } else {
                        validate_name("#name_add_input", "error", "用户名已存在");
                        // 名字不可用，不能保存
                        $("#add_save_button").attr("validate_state","error");
                    }
                }
            });
        });

        /**
         *  点击保存按钮，发送ajax请求
         */
        $("#add_save_button").click(function(){
            // 如果校验失败，直接返回

            // 通过ajax校验名字是否重复,判断validate_state的值是成功还是失败,失败不能保存
            if ($(this).attr("validate_state") != "success") {
//                alert($(this).attr("validate_state"));
                return false;
            }
//            alert($("#empAddModal form").serialize());
            $.ajax({
                url:"/emps",
                method:"POST",
                // 序列化的表单数据，通过jQuery的serialize方法
                data:$("#empAddModal form").serialize(),
                success:function (result) {
                   // console.log(result);

                    if (result.code == 200) {
    //                    关闭模态框
                        $("#empAddModal").modal('hide');
    //                  跳到末页
                        to_page(10000);
                    } else {
                        if (undefined != result.msg.extend.err_msg.empName) {
                            validate_name("#name_add_input", "error", result.msg.extend.err_msg.empName);
                        }
//                        alert(result.extend.err_msg.email);
                        if (undefined != result.extend.err_msg.email) {
                            validate_name("#email_add_input", "error", result.extend.err_msg.email);
                        }
                    }
                }
            });
        });


    </script>

</div>
</body>
</html>
