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
    <link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet"/>
    <script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="static/js/jquery-2.1.4.min.js"></script>
</head>
<body>
    <div class="container">
        <%--标题--%>
        <div class="row">
            <div class="col-md-12"><h1>员工管理系统</h1></div>
        </div>
        <%--按钮--%>
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button class="btn-primary">新增</button>
                <button class="btn-danger">删除</button>
            </div>
        </div>
        <%--信息--%>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover table-striped table-bordered">
                    <tr>
                        <th>id</th>
                        <th>名字</th>
                        <th>性别</th>
                        <th>email</th>
                        <th>公寓</th>
                        <th>操作</th>
                    </tr>
                    <c:forEach items="${pageInfo.list}" var="emp" >
                        <tr>
                            <td>${emp.empId}</td>
                            <td>${emp.empName}</td>
                            <td>${emp.gender=="M" ? "男":"女"}</td>
                            <td>${emp.email}</td>
                            <td>${emp.department.deptName}</td>
                            <td>
                                <button class="btn-primary btn-xs">
                                    编辑
                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                </button>
                                <button class="btn-danger btn-xs">
                                    删除
                                    <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                </button>
                            </td>
                        </tr>
                    </c:forEach>

                </table>

            </div>
        </div>
            <%--分页条--%>
        <div class="row">
            <div class="col-md-6">
                当前${pageInfo.pageNum}页,总${pageInfo.pages}页,总${pageInfo.total}记录
            </div>
            <div class="col-md-6">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <c:if test="${pageInfo.pageNum != 1}">
                            <li><a href="<%=path%>/emps?pn=1">首页</a></li>
                        </c:if>
                        <%--如果是第一页，则不显示箭头--%>
                        <c:if test="${pageInfo.hasPreviousPage}">
                            <li>
                                <a href="<%=path%>/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <c:forEach items="${pageInfo.navigatepageNums}" var="pageNum">
                            <c:if test="${pageNum == pageInfo.pageNum}">
                                <li class="active"><a href="#">${pageNum}</a></li>
                            </c:if>
                            <c:if test="${pageNum != pageInfo.pageNum}">
                                <li><a href="<%=path%>/emps?pn=${pageNum}">${pageNum}</a></li>
                            </c:if>
                        </c:forEach>
                        <c:if test="${pageInfo.hasNextPage}">
                            <li>
                                <a href="<%=path%>/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <c:if test="${pageInfo.pageNum != pageInfo.pages}">
                            <li><a href="<%=path%>/emps?pn=${pageInfo.pages}">末页</a></li>
                        </c:if>
                    </ul>
                </nav>
            </div>
        </div>

    </div>
</body>
</html>
