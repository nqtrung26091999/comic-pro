<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<html>
<head>
    <title>Danh sách thể loại</title>
</head>
<body>
<div class="pagetitle">
    <h1>Quản lý thể loại</h1>
    <nav>
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<c:url value="/admin/home"/>">Trang chủ</a></li>
            <li class="breadcrumb-item active">Danh sách thể loại</li>
        </ol>
    </nav>
</div>
<section class="section">
    <div class="row">
        <div class="col-lg-12">
            <c:if test="${not empty msg}">
                <div class="alert alert-${msg.alert} alert-dismissible">
                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                        ${msg.message}
                </div>
            </c:if>
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title">Danh sách thể loại</h5>
                    <a href="<c:url value="/admin/category/edit" />" title="Add new category"
                       style="margin-right: 10px;">
                        <i class="fa-solid fa-square-plus fa-xl"></i>
                    </a>
                    <a href="#" title="delete category" id="btnDelete" style="margin-right: 10px;">
                        <i class="fa-solid fa-trash-can fa-xl" style="color: #e60000;"></i>
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
                                <th><input type="checkbox" name="" id="checkAll"></th>
                                <th>Name</th>
                                <th>Mô tả</th>
                                <th>Edit</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:if test="${not empty model}">
                                <c:forEach items="${model.listResult}" var="item">
                                    <tr>
                                        <th scope="row"><input type="checkbox" value="${item.id}"></th>
                                        <td>${item.name}</td>
                                        <td>${item.description}</td>
                                        <td>
                                            <a href="<c:url value="/admin/category/edit?id=${item.id}"/>">
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
    var search = $('#search').val();
    $("#search").on("keypress", (e) => {
        e.preventDefault();
    })
    $("#btnSearch").on("click", (e) => {
        e.preventDefault();
        if (search !== "") {
            $('#search').val();
            $('#limit').val(10);
            $('#page').val(1);
            $('#formSubmit').submit();
        }
    });
    $(function () {
        window.pagObj = $('#pagination').twbsPagination({
            totalPages: totalPages,
            visiblePages: 10,
            startPage: currentPage,
            onPageClick: function (event, page) {
                event.preventDefault();
                if (currentPage != page) {
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
            url: '/api/category',
            type: 'DELETE',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function (rs) {
                window.location.href = "/admin/category?page=1&limit=10&msg=delete_success";
                console.log(rs);
            },
            error: function (err) {
                console.log(err);
            }
        });
    }
</script>
</body>
</html>