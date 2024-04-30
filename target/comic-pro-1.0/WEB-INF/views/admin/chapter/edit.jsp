<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<html>
<head>
    <title>Chỉnh sửa chapter</title>
</head>
<body>
<div class="pagetitle">
    <c:if test="${not empty model.id}">
        <h1>Cập nhật chapter</h1>
    </c:if>
    <c:if test="${model.id == null}">
        <h1>Tạo mới chapter</h1>
    </c:if>
    <nav>
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<c:url value="/admin/home"/>">Home</a></li>
            <li class="breadcrumb-item"><a href="<c:url value="/admin/chapter?page=1&limit=10"/>">Danh sách thể loại</a>
            </li>
            <c:if test="${not empty model.id}">
                <li class="breadcrumb-item active">Cập nhật chapter</li>
            </c:if>
            <c:if test="${model.id == null}">
                <li class="breadcrumb-item active">Tạo mới chapter</li>
            </c:if>
        </ol>
    </nav>
</div><!-- End Page Title -->
<c:if test="${not empty model}">
    <section class="section">
        <div class="row">
            <div class="col-lg-9">
                <div class="card">
                    <div class="card-body">
                        <c:if test="${not empty model.id}">
                            <h5 class="card-title">Cập nhật chapter</h5>
                        </c:if>
                        <c:if test="${model.id == null}">
                            <h5 class="card-title">Tạo mới chapter</h5>
                        </c:if>
                        <form id="formSubmit">
                            <div class="row mb-3">
                                <label for="name" class="col-sm-2 col-form-label">Tên chapter</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" name="name" id="name"
                                           value="${model.name}" required>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <label for="comicName" class="col-sm-2 col-form-label">Tên truyện</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="comicName"
                                           value="${comicName}" disabled>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-sm-10">
                                    <button type="button" class="btn btn-primary" id="btnSubmit">Submit</button>
                                </div>
                            </div>
                            <input type="hidden" name="id" id="id" value="${model.id}">
                        </form>
                        <!-- End General Form Elements -->
                    </div>
                </div>
            </div>
        </div>
    </section>
</c:if>
<script>
    $(document).ready(function () {
        function removeAccents(str) {
            return str.normalize('NFD')
                .replace(/[\u0300-\u036f]/g, '')
                .replace(/đ/g, 'd').replace(/Đ/g, 'D');
        }

        $("#btnSubmit").click(function () {
            var data = {};
            var id = $("#id").val();
            var name = ($("#name").val().trim().replace(" ", "")).toUpperCase();
            data["name"] = removeAccents(name);
            data["id"] = id;
            data["comicId"] = ${comicId};
            if (data["id"] == "") {
                addChapter(data);
            } else {
                updateChapter(data);
            }
        });

        function updateChapter(data) {
            $.ajax({
                url: "/api/chapter",
                type: "put",
                contentType: "application/json",
                data: JSON.stringify(data),
                dataType: "JSON",
                success: (rs) => {
                    window.location.href = "/admin/chapter?page=1&limit=10&msg=update_success&comicId=" + ${comicId};
                },
                error: (e) => {
                    window.location.href = "/admin/chapter?page=1&limit=10&msg=update_failed&comicId=" + ${comicId};
                    console.log(e)
                }
            });
        }

        function addChapter(data) {
            $.ajax({
                url: "/api/chapter",
                type: "post",
                contentType: "application/json",
                data: JSON.stringify(data),
                dataType: "JSON",
                success: (rs) => {
                    window.location.href = "/admin/chapter?page=1&limit=10&msg=insert_success&comicId=" + ${comicId};
                },
                error: (e) => {
                    window.location.href = "/admin/chapter?page=1&limit=10&msg=insert_failed&comicId=" + ${comicId};
                    console.log(e)
                }
            });
        }
    });
</script>
</body>
</html>
