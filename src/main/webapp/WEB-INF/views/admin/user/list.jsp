<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="userAPIUrl" value="/api/user"/>
<html>
<head>
    <title>User</title>
</head>
<body>
<div class="pagetitle">
    <h1>Quản lý người dùng</h1>
    <nav>
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<c:url value="/admin/home"/>">Home</a></li>
            <li class="breadcrumb-item active">Danh sách người dùng</li>
        </ol>
    </nav>
</div>
<section class="section">
    <div class="row">
        <div class="col-lg-12">
            <c:if test="${not empty model.msg && not empty model.alert}">
                <div class="alert alert-${model.alert} alert-dismissible">
                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                        ${model.msg}
                </div>
            </c:if>
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title">Danh sách người dùng</h5>
                    <a href="<c:url value="/admin/user/edit" />" title="Add new user" style="margin-right: 10px;">
                        <i class="fa-solid fa-square-plus fa-xl"></i>
                    </a>
                    <a href="#" title="delete user" id="btnDelete" style="margin-right: 10px;">
                        <i class="fa-solid fa-trash-can fa-xl" style="color: #e60000;"></i>
                    </a>
                    <a href="#" title="lock user" id="btnLock" style="margin-right: 10px;">
                        <i class="fa-solid fa-lock fa-xl" style="color: #B197FC;"></i>
                    </a>
                    <a href="#" title="unlock user" id="btnUnLock">
                        <i class="fa-solid fa-lock-open fa-xl" style="color: #0bd07b;"></i>
                    </a>
                </div>
                <br>
                <form id="formSubmit" method="get">
                    <div class="card-body">
                        <div class="input-group">
                            <div class="form-outline" data-mdb-input-init>
                                <input type="search" id="search" name="search" placeholder="Search by name"
                                       class="form-control" value="${model.search}"/>
                            </div>
                            <button type="button" id="btnSearch" class="btn btn-primary" data-mdb-ripple-init>
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                        <br>
                        <table class="table table-bordered">
                            <thead>
                            <tr>
                                <th scope="col"><input type="checkbox" name="" id="checkAll"></th>
                                <th scope="col">Username</th>
                                <th scope="col">Full name</th>
                                <th scope="col">Email</th>
                                <th scope="col">Số điện thoại</th>
                                <th scope="col">Trạng thái</th>
                                <th scope="col">Ngày đăng ký</th>
                                <th scope="col">Edit</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:if test="${not empty model}">
                                <c:forEach items="${model.listResult}" var="item">
                                    <tr>
                                        <th scope="row"><input type="checkbox" value="${item.id}"></th>
                                        <td>${item.username}</td>
                                        <td>${item.fullName}</td>
                                        <td>${item.email}</td>
                                        <td>${item.phone}</td>
                                        <td>
                                            <c:if test="${item.status == 0}">
                                                <span class="badge bg-danger">Đang khóa</span>
                                            </c:if>
                                            <c:if test="${item.status == 1}">
                                                <span class="badge bg-success">Đang hoạt động</span>
                                            </c:if>
                                            <c:if test="${item.status == 2}">
                                                <span class="badge bg-secondary">Đã xóa</span>
                                            </c:if>
                                        </td>
                                        <td>${item.createdDate}</td>
                                        <td>
                                            <a href="<c:url value="/admin/user/edit?id=${item.id}"/>">
                                                <i class="fa-solid fa-pen-to-square"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                            </tbody>
                        </table>
                        <ul class="pagination" id="pagination"></ul>
                        <input type="hidden" id="page" name="page">
                        <input type="hidden" id="limit" name="limit">
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>
<script type="text/javascript">
    var totalPages = ${model.totalPage};
    var currentPage = ${model.page};
    // $("#search").on("keypress", (e) => {
    //     e.preventDefault();
    // });
    $("#search").on("change", e => {
        console.log(e.target.value);
    });
    $("#btnSearch").on("click", (e) => {
        e.preventDefault();
        $('#search').val();
        $('#limit').val(10);
        $('#page').val(1);
        $('#formSubmit').submit();
    });
    $(function () {
        window.pagObj = $('#pagination').twbsPagination({
            totalPages: totalPages,
            visiblePages: 10,
            startPage: currentPage,
            onPageClick: function (event, page) {
                event.preventDefault();
                if (currentPage != page) {
                    $('#search').val();
                    $('#limit').val(10);
                    $('#page').val(page);
                    $('#formSubmit').submit();
                }
            }
        });
    });
    $("#checkAll").click(function () {
        $("input[type=checkbox]").prop('checked', $(this).prop('checked'));
    });
    $("#btnDelete").on("click", function () {
        var data = {};
        var ids = $('tbody input[type=checkbox]:checked').map(function () {
            return $(this).val();
        }).get();
        data["ids"] = ids;
        if (ids.length) {
            deleteUser(data);
        }
    });

    function deleteUser(data) {
        $.ajax({
            url: '${userAPIUrl}',
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function (rs) {
                window.location.href = "/admin/user?page=1&limit=10&msg=delete_success";
                console.log(rs);
            },
            error: function (err) {
                console.log(err);
            }
        });
    }

    $("#btnLock").click((e) => {
        var data = {};
        var ids = $('tbody input[type=checkbox]:checked').map(function () {
            return $(this).val();
        }).get();
        data["ids"] = ids;
        if (ids) {

        }
    })
</script>
</body>
</html>