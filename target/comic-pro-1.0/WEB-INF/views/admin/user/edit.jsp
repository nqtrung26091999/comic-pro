<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<html>
<head>
    <title>Chỉnh sửa người dùng</title>
</head>
<body>
<div class="pagetitle">
    <c:if test="${not empty model.id}">
        <h1>Cập nhật tài khoản</h1>
    </c:if>
    <c:if test="${model.id == null}">
        <h1>Tạo tài khoản</h1>
    </c:if>
    <nav>
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<c:url value="/admin/home"/>">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="<c:url value="/admin/user?page=1&limit=10"/>">Danh sách người dùng</a>
            </li>
            <c:if test="${not empty model.id}">
                <li class="breadcrumb-item active">Cập nhật tài khoản</li>
            </c:if>
            <c:if test="${model.id == null}">
                <li class="breadcrumb-item active">Tạo tài khoản</li>
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
                            <h5 class="card-title">Cập nhật tài khoản</h5>
                        </c:if>
                        <c:if test="${model.id == null}">
                            <h5 class="card-title">Tạo tài khoản</h5>
                        </c:if>
                        <form id="formSubmit">
                            <div class="row mb-3">
                                <label for="username" class="col-sm-2 col-form-label">Username</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" name="username" id="username"
                                           value="${model.username}" required>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <label for="fullName" class="col-sm-2 col-form-label">Full Name</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" name="fullName" id="fullName"
                                           value="${model.fullName}" required>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <label for="email" class="col-sm-2 col-form-label">Email</label>
                                <div class="col-sm-10">
                                    <input type="email" class="form-control" id="email" name="email"
                                           value="${model.email}" required>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <label for="password" class="col-sm-2 col-form-label">Password</label>
                                <div class="col-sm-10">
                                    <input type="password" class="form-control" id="password" name="password" required>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <label for="rePassword" class="col-sm-2 col-form-label">Re-password</label>
                                <div class="col-sm-10">
                                    <input type="password" class="form-control" id="rePassword" name="rePassword"
                                           required>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <label for="phone" class="col-sm-2 col-form-label">Phone Number</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" name="phone" id="phone"
                                           value="${model.phone}">
                                </div>
                            </div>
                            <div class="row mb-3">
                                <label class="col-sm-2 col-form-label">Quyền</label>
                                <div class="col-sm-10">
                                    <select class="form-select" aria-label="Default select example" required
                                            name="roleCode">
                                        <option></option>
                                        <c:if test="${not empty roles}">
                                            <c:forEach var="item" items="${roles}">
                                                <option value="${item.code}"
                                                <c:if test="${model.roleCode == item.code}">
                                                    selected
                                                </c:if>
                                                >${item.name}</option>
                                            </c:forEach>
                                        </c:if>
                                    </select>
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
                        <div class="card-header">Ảnh đại diện</div>
                        <div class="card-body text-center">
                            <!-- Profile picture image-->
                            <c:if test="${not empty model.avatar}">
                                <img id="userAvatar" class="img-account-profile rounded-circle mb-2"
                                     src='${model.avatar}' alt="" height="200" width="200">
                            </c:if>
                            <c:if test="${empty model.avatar}">
                                <img id="userAvatar" class="img-account-profile rounded-circle mb-2"
                                     src='<c:url value="/template/default_avatar.png"/> ' alt="" height="200"
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
    $(document).ready(function () {
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
                    $('#userAvatar').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
    });

    $("#btnSubmit").click(function () {
        var data = {};
        var file = $('input[name="imgUpload"]')[0].files[0];
        var formData = $("#formSubmit").serializeArray();
        $.each(formData, function (i, v) {
            data["" + v.name + ""] = v.value;
        });
        if (data["id"] == "") {
            addNewUser(data);
        } else {
            updateUser(data);
        }

        function addNewUser(data) {
            $.ajax({
                url: "/api/user",
                type: "post",
                contentType: "application/json",
                data: JSON.stringify(data),
                dataType: "JSON",
                success: (rs) => {
                    if (file) {
                        uploadFile(file, rs);
                    }
                    window.location.href = "/admin/user?page=1&limit=10&msg=insert_success";
                },
                error: (e) => {
                    window.location.href = "/admin/user?page=1&limit=10&msg=insert_failed"
                    console.log(e)
                }
            });
        }

        function uploadFile(file, rs) {
            var formData = new FormData();
            formData.append("userId", rs["id"]);
            formData.append("avatar", file);
            $.ajax({
                url: "/api/upload-avatar",
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

        function updateUser(data) {
            $.ajax({
                url: "/api/user",
                method: "PUT",
                contentType: "application/json",
                data: JSON.stringify(data),
                dataType: "JSON",
                success: rs => {
                    if (file) {
                        uploadFile(file, rs);
                    }
                    window.location.href = "/admin/user?page=1&limit=10&msg=update_success";
                },
                error: err => {
                    window.location.href = "/admin/user?page=1&limit=10&msg=update_failed";
                }
            });
        }
    });
</script>
</body>
</html>
