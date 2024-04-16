<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<html>
<head>
    <title>Category</title>
</head>
<body>
<div class="pagetitle">
    <c:if test="${not empty model.id}">
        <h1>Cập nhật thể loại</h1>
    </c:if>
    <c:if test="${model.id == null}">
        <h1>Tạo thể loại</h1>
    </c:if>
    <nav>
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<c:url value="/admin/home"/>">Home</a></li>
            <li class="breadcrumb-item"><a href="<c:url value="/admin/category?page=1&limit=10"/>">Danh sách thể loại</a>
            </li>
            <c:if test="${not empty model.id}">
                <li class="breadcrumb-item active">Cập nhật thể loại</li>
            </c:if>
            <c:if test="${model.id == null}">
                <li class="breadcrumb-item active">Tạo thể loại</li>
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
                            <h5 class="card-title">Cập nhật thể loại</h5>
                        </c:if>
                        <c:if test="${model.id == null}">
                            <h5 class="card-title">Tạo thể loại</h5>
                        </c:if>
                        <form id="formSubmit">
                            <div class="row mb-3">
                                <label for="name" class="col-sm-2 col-form-label">Tên thể loại</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" name="name" id="name"
                                           value="${model.name}" required>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <label for="description" class="col-sm-2 col-form-label">Mô tả</label>
                                <div class="col-sm-10">
                                    <textarea class="form-control" name="description" id="description"
                                              value="${model.description}" required></textarea>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-sm-10">
                                    <button type="button" class="btn btn-primary" id="btnSubmit">Submit</button>
                                </div>
                            </div>
                            <input type="hidden" name="id" value="${model.id}">
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
            var name = $("#name").val().trim();
            var description = $("#description").val().trim();
            var code = (name.replace(" ","")).toUpperCase();
            var codex = removeAccents(code);
            data["id"] = id;
            data["name"] = name;
            data["description"] = description;
            data["code"] = codex;
            if (data["id"] === undefined) {
                addNewCategory(data);
            } else {
                updateCategory(data);
            }
        });

        function updateCategory(data) {

        }

        function addNewCategory(data) {
            $.ajax({
                url: "/api/category",
                type: "post",
                contentType: "application/json",
                data: JSON.stringify(data),
                dataType: "JSON",
                success: (rs) => {
                    window.location.href = "/admin/category?page=1&limit=10&msg=insert_success";
                },
                error: (e) => {
                    window.location.href = "/admin/category?page=1&limit=10&msg=insert_failed"
                    console.log(e)
                }
            });
        }
    });
</script>
</body>
</html>
