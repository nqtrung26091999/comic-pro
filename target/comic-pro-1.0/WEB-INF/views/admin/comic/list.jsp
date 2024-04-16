<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<html>
<head>
    <title>Comic</title>
</head>
<body>
<div class="pagetitle">
    <h1>Quản lý truyện tranh</h1>
    <nav>
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<c:url value="/admin/home"/> ">Home</a></li>
            <li class="breadcrumb-item">Quản lý truyện tranh</li>
            <li class="breadcrumb-item active">Danh sách truyện tranh</li>
        </ol>
    </nav>
</div>
<c:if test="${not empty model}">
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
                        <h5 class="card-title">Danh sách truyện tranh</h5>
                        <a href="<c:url value="/admin/comic/edit" />" title="Add new comic" style="margin-right: 10px;">
                            <i class="fa-solid fa-square-plus fa-xl"></i>
                        </a>
                        <a href="#" title="delete category" id="btnDelete" style="margin-right: 10px;">
                            <i class="fa-solid fa-trash-can fa-xl" style="color: #e60000;"></i>
                        </a>
                    </div>
                    <br>
                    <div class="card-body">
                        <div class="input-group">
                            <div class="form-outline" data-mdb-input-init>
                                <input type="search" id="form1" placeholder="Search by name" class="form-control"/>
                            </div>
                            <button type="button" class="btn btn-primary" data-mdb-ripple-init>
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                        <br>
                        <!-- Table with hoverable rows -->
                        <table class="table table-bordered">
                            <thead>
                            <tr>
                                <th><input type="checkbox" value=""></th>
                                <th>Tên truyện</th>
                                <th>Số chapter</th>
                                <th>Thể loại</th>
                                <th>Tác giả</th>
                                <th>Lượt xem</th>
                                <th>Ngày đăng</th>
                                <th>Ngày update</th>
                                <th>Edit</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="item" items="${model.listResult}">
                                <tr>
                                    <td><input type="checkbox" value=""></td>
                                    <td>${item.name}</td>
                                    <td>
                                        <strong>
                                            <a href="<c:url value="/admin/chapter?page=1&limit=10&comicId=${item.id}"/>">${item.totalChapters}</a>
                                        </strong>
                                    </td>
                                    <td>
                                        <c:forEach items="${item.listCategory}" var="category">
                                            <span class="badge bg-secondary">${category.name}</span>
                                        </c:forEach>
                                    </td>
                                    <td>${item.author}</td>
                                    <td>4567</td>
                                    <td>${item.createdDate}</td>
                                    <td>${item.modifiedDate}</td>
                                    <td>
                                        <a href="<c:url value="/admin/comic/edit?id=${item.id}"/>">
                                            <i class="fa-solid fa-pen-to-square"></i></a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <ul class="pagination" id="pagination"></ul>
                        <input type="hidden" id="page" name="page">
                        <input type="hidden" id="limit" name="limit">
                    </div>
                </div>
            </div>
        </div>
    </section>
</c:if>
<script>
    var totalPages = ${model.totalPage};
    var currentPage = ${model.page};
    $("#search").on("keypress", (e) => {
        e.preventDefault();
    })
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
            url: '/api/comic',
            type: 'DELETE',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function (rs) {
                window.location.href = "/admin/comic?page=1&limit=10&msg=delete_success";
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
