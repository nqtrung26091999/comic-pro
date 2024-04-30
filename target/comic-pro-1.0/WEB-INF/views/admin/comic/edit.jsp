<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<html>
<head>
    <title>Chỉnh sửa truyện tranh</title>
</head>
<body>
<div class="pagetitle">
    <c:if test="${not empty model.id}">
        <h1>Cập nhật truyện</h1>
    </c:if>
    <c:if test="${model.id == null}">
        <h1>Thêm mới truyện</h1>
    </c:if>
    <nav>
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<c:url value="/admin/home"/>">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="<c:url value="/admin/comic?page=1&limit=10"/>">Danh sách truyện tranh</a>
            </li>
            <c:if test="${not empty model.id}">
                <li class="breadcrumb-item active">Cập nhật truyện</li>
            </c:if>
            <c:if test="${model.id == null}">
                <li class="breadcrumb-item active">Thêm mới truyện</li>
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
                            <h5 class="card-title">Cập nhật truyện</h5>
                        </c:if>
                        <c:if test="${model.id == null}">
                            <h5 class="card-title">Thêm mới truyện</h5>
                        </c:if>
                        <form id="formSubmit">
                            <div class="row mb-3">
                                <label for="name" class="col-sm-2 col-form-label">Tên truyện</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" name="name" id="name"
                                           value="${model.name}" required>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <label for="author" class="col-sm-2 col-form-label">Tác giả</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="author" name="author"
                                           value="${model.author}" required>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <label class="col-sm-2 col-form-label">Thể loại</label>
                                <div class="col-sm-10">
                                    <div id="categoryAfterAdd">
                                        <c:forEach var="item" items="${model.listCategory}" varStatus="loop">
                                            <span id='item${loop.index}' class='badge bg-secondary me-1'>
                                                ${item.name}
                                                <a href='#' title='remove' onclick='removeItem(${loop.index})'
                                                   style='color: white'>
                                                    <i class='bi bi-x-circle'></i>
                                                </a>
                                                <input class='itemCategory' type='hidden' value='${item.id}'/>
                                            </span>
                                        </c:forEach>
                                        <button type="button" class="btn btn-success btn-sm" style="margin-right: 5px;"
                                                data-bs-toggle="modal" data-bs-target="#verticalycentered">
                                            <strong>+</strong>
                                        </button>
                                    </div>
                                    <div class="modal fade" id="verticalycentered" tabindex="-1">
                                        <div class="modal-dialog modal-dialog-centered">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">Chọn thể loại</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                            aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body" style="max-height: 400px;overflow-y: scroll">
                                                    <div class="input-group">
                                                        <div class="form-outline" data-mdb-input-init>
                                                            <input type="search" name="strSearch"
                                                                   id="inputSearchCategory" placeholder="Search by name"
                                                                   class="form-control"/>
                                                        </div>
                                                        <button id="btnSearchCategory" type="button"
                                                                class="btn btn-primary" data-mdb-ripple-init>
                                                            <i class="fas fa-search"></i>
                                                        </button>
                                                    </div>
                                                    <br>
                                                    <table class="table table-bordered">
                                                        <thead>
                                                        <tr class="table-header">
                                                            <th>
                                                                <label>
                                                                    <input type="checkbox"/>
                                                                </label>
                                                            </th>
                                                            <th>Tên thể loại</th>
                                                        </tr>
                                                        </thead>
                                                        <tbody id="table-body">
                                                        </tbody>
                                                    </table>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary"
                                                            data-bs-dismiss="modal">Close
                                                    </button>
                                                    <button type="button" class="btn btn-primary" id="btnSaveCategory">
                                                        Save
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div><!-- End Vertically centered Modal-->
                                </div>
                            </div>
                            <div class="row mb-3">
                                <label for="description" class="col-sm-2 col-form-label">Mô tả</label>
                                <div class="col-sm-10">
                                    <textarea class="form-control" name="description"
                                              id="description">${model.description}</textarea>
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
            <div class="col-lg-3">
                <div class="card">
                    <div class="card mb-4 mb-xl-0">
                        <div class="card-header">Ảnh bìa</div>
                        <div class="card-body text-center">
                            <!-- Profile picture image-->
                            <c:if test="${not empty model.cover}">
                                <img id="imageCover" class="img-account-profile mb-2"
                                     src='${model.cover}' alt="" height="250" width="200">
                            </c:if>
                            <c:if test="${empty model.cover}">
                                <img id="imageCover" class="img-account-profile mb-2"
                                     src='<c:url value="/template/default_image.png"/> ' alt="" height="250"
                                     width="200">
                            </c:if>
                            <!-- Profile picture help block-->
                            <div class="small font-italic text-muted mb-4">JPG hoặc PNG không lớn hơn 5 MB</div>
                            <!-- Profile picture upload button-->
                            <form id="formUploadImage">
                                <input type="file" id="imgUpload" style="display:none" name="imgUpload"/>
                            </form>
                            <button class="btn btn-primary" type="button" id="btnOpenDialog">Upload new image</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</c:if>
<script>
    $("#btnOpenDialog").click(function () {
        $("#imgUpload").trigger('click');
    })

    $("#imgUpload").on('change', function (e) {
        e.preventDefault();
        readUrl(this);
    })

    function readUrl(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $('#imageCover').attr('src', e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
        }
    }

    $("#btnSearchCategory").click(function (e) {
        var ids = $('.itemCategory').map(function () {
            return $(this).val();
        }).get();
        e.preventDefault();
        $("tr.item").remove();
        var str = $("#inputSearchCategory").val().trim();
        searchCategory(str, ids);
    })

    function searchCategory(str, ids) {
        var data = {};
        data["search"] = str;
        $.ajax({
            url: "/api/category/search",
            method: "post",
            contentType: "application/json",
            data: JSON.stringify(data),
            dataType: "JSON",
            success: rs => {
                console.log(rs);
                if (rs) {
                    var disable = "";
                    var textColor = "";
                    $.each(rs["listResult"], function (index, value) {
                        if (jQuery.inArray(String(value["id"]), ids) != -1) {
                            disable = "disabled";
                            textColor = "style='color:#cfcfcf'";
                        } else {
                            disable = "";
                            textColor = "";
                        }
                        $("#table-body").append(
                            "<tr class='item'>" +
                            "<th><input type='checkbox' value='" + value["id"] + "' " + disable + "/></th>" +
                            "<td " + textColor + ">" + value["name"] + "</td>" +
                            "</tr>");
                    });
                }
            },
            error: err => {
                console.log(err)
            }
        })
    }

    $("#btnSaveCategory").click(function (e) {
        e.preventDefault();
        var data = {};
        data['ids'] = $('tbody input[type=checkbox]:checked').map(function () {
            return $(this).val();
        }).get();
        $.ajax({
            url: "/api/category/find",
            method: "POST",
            contentType: "application/json",
            data: JSON.stringify(data),
            dataType: "JSON",
            success: rs => {
                if (rs) {
                    $.each(rs["listResult"], function (index, value) {
                        $("#categoryAfterAdd").prepend(
                            "<span id='item" + index + "' class='badge bg-secondary me-1'>" + value['name'] + " " +
                            "<a href='#' title='remove' onclick='removeItem(" + index + ")' style='color: white'><i class='bi bi-x-circle'></i></a>" +
                            "<input class='itemCategory' type='hidden' value='" + value["id"] + "'/>" +
                            "</span>");
                    });
                }
            },
            error: err => {
                console.log(err)
            }
        });
        $("#verticalycentered").modal("hide");
    });

    function removeItem(index) {
        $("#item" + index).remove();
    }

    function removeAccents(str) {
        return str.normalize('NFD')
            .replace(/[\u0300-\u036f]/g, '')
            .replace(/đ/g, 'd').replace(/Đ/g, 'D');
    }

    $("#btnSubmit").click(function () {
        var data = {};
        data['arrayCategoryId'] = $('.itemCategory').map(function () {
            return $(this).val();
        }).get();
        var formData = $("#formSubmit").serializeArray();
        $.each(formData, function (i, v) {
            data["" + v.name + ""] = v.value;
        });
        var code = (data['name'].replace(" ", "-")).toLowerCase();
        data['code'] = removeAccents(code);
        if (data["id"] == "") {
            addNewComic(data);
        } else {
            updateComic(data);
        }
    });

    function addNewComic(data) {
        var file = $('input[name="imgUpload"]')[0].files[0];
        $.ajax({
            url: "/api/comic",
            type: "post",
            contentType: "application/json",
            data: JSON.stringify(data),
            dataType: "JSON",
            success: (rs) => {
                if (file) {
                    uploadFile(file, rs);
                }
                window.location.href = "/admin/comic?page=1&limit=10&msg=insert_success";
            },
            error: (e) => {
                window.location.href = "/admin/comic?page=1&limit=10&msg=insert_failed"
                console.log(e)
            }
        });
    }

    function uploadFile(file, rs) {
        var formData = new FormData();
        formData.append("comicId", rs["id"]);
        formData.append("imageCover", file);
        $.ajax({
            url: "/api/upload-cover",
            type: "POST",
            method: "POST",
            enctype: "multipart/form-data",
            contentType: false,
            processData: false,
            cache: false,
            data: formData,
            success: (rs) => {
                console.log(rs)
            },
            error: (e) => {
                console.log(e)
            }
        });
    }

    function updateComic(data) {
        var file = $('input[name="imgUpload"]')[0].files[0];
        $.ajax({
            url: "/api/comic",
            method: "PUT",
            contentType: "application/json",
            data: JSON.stringify(data),
            dataType: "JSON",
            success: rs => {
                if (file) {
                    uploadFile(file, rs);
                }
                window.location.href = "/admin/comic?page=1&limit=10&msg=update_success";
            },
            error: err => {
                window.location.href = "/admin/comic?page=1&limit=10&msg=update_failed";
            }
        });
    }
</script>
</body>
</html>
