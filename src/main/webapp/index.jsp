<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                    <button type="button" class="btn btn-primary">Save</button>
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
                to_page(pageInfo.total);
            });
        }
        $("#addBtn").click(function () {
            // 发送ajax请求获得部门信息
            $.ajax({
                url:"<%=path%>/depts",
                type:"GET",
                success:function(result){
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


    </script>

</div>
</body>
</html>
