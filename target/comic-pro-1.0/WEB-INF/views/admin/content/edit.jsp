<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<html>
<head>
    <title>Content</title>
</head>
<body>
<div class="pagetitle">
    <c:if test="${not empty model.id}">
        <h1>Cập nhật nội dung</h1>
    </c:if>
    <c:if test="${model.id == null}">
        <h1>Tạo mới nội dung</h1>
    </c:if>
    <nav>
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<c:url value="/admin/home"/>">Home</a></li>
            <li class="breadcrumb-item"><a href="<c:url value="/admin/content?comicId=${comicId}&chapterId=${chapterId}"/>">Danh sách ảnh
                truyện</a>
            </li>
            <c:if test="${not empty model.id}">
                <li class="breadcrumb-item active">Cập nhật nội dung</li>
            </c:if>
            <c:if test="${model.id == null}">
                <li class="breadcrumb-item active">Tạo mới nội dung</li>
            </c:if>
        </ol>
    </nav>
</div><!-- End Page Title -->
<c:if test="${not empty model}">
    <section class="section">
        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-body">
                        <c:if test="${not empty model.id}">
                            <h5 class="card-title">Cập nhật ảnh truyện</h5>
                        </c:if>
                        <c:if test="${model.id == null}">
                            <h5 class="card-title">Tạo mới ảnh truyện</h5>
                        </c:if>
                        <form id="formSubmit">
                            <div class="row mb-3">
                                <label for="comicName" class="col-sm-2 col-form-label">Tên truyện</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="comicName"
                                           value="${comicName}" disabled>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <label for="name" class="col-sm-2 col-form-label">Tên chapter</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="name"
                                           value="${chapterName}" disabled>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <label for="name" class="col-sm-2 col-form-label">Upload ảnh truyện</label>
                                <div class="col-sm-10">
                                    <button id="btnOpenDialog" type="button" class="btn btn-info">
                                        <i class="fa-solid fa-folder-open"></i> Browser...
                                    </button>
                                    <button type="button" class="btn btn-secondary" id="btnClear">
                                        <i class="fa-solid fa-delete-left"></i> Clear Image
                                    </button>
                                    <input type="file" name="inputImages[]" id="inputImages" style="display: none;"
                                           multiple>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <label for="name" class="col-sm-2 col-form-label"></label>
                                <div class="row" id="imageList">
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-sm-10">
                                    <button type="button" class="btn btn-primary" id="btnSubmit">
                                        <i class="fa-solid fa-floppy-disk"></i> Save
                                    </button>
                                </div>
                            </div>
                            <input type="hidden" name="id" id="id" value="${model.id}">
                            <input type="hidden" name="chapterId" id="chapterId" value="${chapterId}">
                        </form>
                        <!-- End General Form Elements -->
                    </div>
                </div>
            </div>
        </div>
    </section>
</c:if>
<script>
    $("#btnOpenDialog").on("click", () => {
        $("#inputImages").trigger('click');
    });
    $("#btnClear").on("click", (e) => {
        e.preventDefault();
        $("#imageList").empty();
    });
    $("#inputImages").on("change", (e) => {
        var files = {};
        files = e.target.files;
        if (files.length !== 0) {
            for (var i = 0; i < files.length; i++) {
                $("#imageList").append(
                    "<div class='col'>" +
                    "<span>" + files[i].name + "</span>" +
                    "<div class='col'>" +
                    "<img class='me-2' id='imageItem" + i + "' src='' alt='...' height='500' width='250'/>" +
                    "</div>" +
                    "</div>"
                );
                readUrl(files[i], i);
            }
        }
    });

    function readUrl(file, i) {
        var reader = new FileReader();
        reader.onload = function (e) {
            $('#imageItem' + i).attr('src', e.target.result);
        }
        reader.readAsDataURL(file);
    }

    $("#btnSubmit").on("click", () => {
        uploadFile();
    });

    function uploadFile() {
        var formData = new FormData();
        var files = $("#inputImages").prop('files');
        var id = $("#id").val();
        var chapterId = $("#chapterId").val();
        formData.append("id", id);
        formData.append("chapterId", chapterId);
        $.each(files, (i, v) => {
            formData.append("arrayImages", v);
        });
        $.ajax({
            url: "/api/content",
            type: "POST",
            method: "POST",
            enctype: "multipart/form-data",
            contentType: false,
            processData: false,
            cache: false,
            data: formData,
            success: (rs) => {
                console.log(rs)
                if (rs) {
                    window.location.href = "admin/content?comicId=" + rs["comicId"] + "&chapterId=" + rs["chapterId"];
                }
            },
            error: (e) => {
                console.log(e)
            }
        });
    }
</script>
</body>
</html>
