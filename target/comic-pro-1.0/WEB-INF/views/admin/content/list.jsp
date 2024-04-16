<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<html>
<head>
    <title>Content</title>
</head>
<body>
<div class="pagetitle">
    <h1>Quản lý ảnh truyện</h1>
    <nav>
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<c:url value="/admin/home"/>">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="<c:url value="/admin/chapter?page=1&limit=10&comicId=${comicId}"/>">Danh sách chapter</a></li>
            <li class="breadcrumb-item active">Danh sách ảnh truyện</li>
        </ol>
    </nav>
</div>
<section class="section">
    <div class="row">
        <div class="col-lg-12">
<%--            <c:if test="${not empty model.msg && not empty model.alert}">--%>
<%--                <div class="alert alert-${model.alert} alert-dismissible">--%>
<%--                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>--%>
<%--                        ${model.msg}--%>
<%--                </div>--%>
<%--            </c:if>--%>
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title">Danh sách ảnh truyện</h5>
                    <a href="<c:url value="/admin/content/edit?chapterId=${chapterId}&comicId=${comicId}" />" title="Add new chapter"
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
                            <div class="form-outline w-100" data-mdb-input-init>
                                <input type="text" name="search" disabled
                                       class="form-control" value="${comicName} - ${chapterName}"/>
                            </div>
                        </div>
                        <br>
                        <table class="table table-bordered">
                            <thead>
                            <tr>
                                <th><input type="checkbox" name="" id="checkAll"></th>
                                <th>Ảnh truyện</th>
                                <th>Edit</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:if test="${not empty model}">
                                <c:forEach items="${model}" var="item">
                                    <tr>
                                        <th scope="row"><input type="checkbox" value="${item.id}"></th>
                                        <td>
                                            <img src="${item.name}" alt="" width="150" height="300"/>
                                        </td>
                                        <td>
                                            <a href="<c:url value="/admin/content/edit?id=${item.id}&comicId=${comicId}&chapterId=${chapterId}"/>">
                                                <i class="fa-solid fa-pen-to-square"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                            </tbody>
                        </table>
                        <input type="hidden" id="comicId" name="comicId">
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>
<script type="text/javascript">
    $("#checkAll").click(function () {
        $("input[type=checkbox]").prop('checked', $(this).prop('checked'));
    });
    $("#btnDelete").on("click", function () {
        var data = {};
        var ids = $('tbody input[type=checkbox]:checked').map(function () {
            return $(this).val();
        }).get();
        data["ids"] = ids;
        data["comicId"] = $("#comicId").val();
        if (ids.length) {
            deleteChapter(data);
        }
    });

    function deleteChapter(data) {
        $.ajax({
            url: '/api/chapter',
            type: 'DELETE',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function (rs) {
                window.location.href = "/admin/chapter?page=1&limit=10&msg=delete_success&comicId=" + data["comicId"];
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