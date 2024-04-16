<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<html>
<head>
    <title>Profile user</title>
    <link href="<c:url value="/template/web/css/profile.css"/>">
</head>
<body>
<div class="container-xl px-4 mt-4" style="height: 748px;">
    <!-- Account page navigation-->
    <nav class="nav nav-borders">
        <a class="nav-link active ms-0" href="https://www.bootdey.com/snippets/view/bs5-edit-profile-account-details"
           target="__blank">Profile</a>
        <a class="nav-link" href="https://www.bootdey.com/snippets/view/bs5-profile-billing-page" target="__blank">Billing</a>
        <a class="nav-link" href="https://www.bootdey.com/snippets/view/bs5-profile-security-page" target="__blank">Security</a>
        <a class="nav-link" href="https://www.bootdey.com/snippets/view/bs5-edit-notifications-page" target="__blank">Notifications</a>
    </nav>
    <hr class="mt-0 mb-4">
    <div class="row">
        <div class="col-xl-4">
            <!-- Profile picture card-->
            <div class="card mb-4 mb-xl-0">
                <div class="card-header">Ảnh đại diện</div>
                <div class="card-body text-center">
                    <!-- Profile picture image-->
                    <img id="userAvatar" class="img-account-profile rounded-circle mb-2"
                         src="http://bootdey.com/img/Content/avatar/avatar1.png" alt="" height="200" width="200">
                    <!-- Profile picture help block-->
                    <div class="small font-italic text-muted mb-4">JPG hoặc PNG không lớn hơn 5 MB</div>
                    <!-- Profile picture upload button-->
                    <input type="file" id="imgUpload" style="display:none"/>
                    <button class="btn btn-primary" type="button" id="btnOpenDialog">Upload new image</button>
                </div>
            </div>
        </div>
        <div class="col-xl-8">
            <!-- Account details card-->
            <div class="card mb-4">
                <div class="card-header">Thông tin người dùng</div>
                <div class="card-body">
                    <form>
                        <c:if test="${not empty model}">
                            <!-- Form Group (username)-->
                            <div class="row gx-3 mb-3">
                                <div class="col-md-6">
                                    <label class="small mb-1" for="username">Tên đăng nhập</label>
                                    <input required class="form-control" id="username" name="username" type="text"
                                           placeholder="Enter your username" value="${model.username}">
                                </div>
                            </div>
                            <!-- Form Row-->
                            <div class="row gx-3 mb-3">
                                <!-- Form Group (first name)-->
                                <div class="col-md-6">
                                    <label class="small mb-1" for="fullName">Họ tên</label>
                                    <input required class="form-control" id="fullName" name="fullName" type="text"
                                           placeholder="Enter your first name" value="${model.fullName}">
                                </div>
                            </div>
                            <!-- Form Group (email address)-->
                            <div class="row gx-3 mb-3">
                                <div class="col-md-6">
                                    <label class="small mb-1" for="email">Email</label>
                                    <input required class="form-control" id="email" name="email" type="email"
                                           placeholder="Enter your email address" value="${model.email}">
                                </div>
                            </div>
                            <!-- Form Row-->
                            <div class="row gx-3 mb-3">
                                <div class="col-md-6">
                                    <label class="small mb-1" for="phone">Số điện thoại</label>
                                    <input required class="form-control" id="phone" name="phone" type="tel"
                                           placeholder="Enter your phone number" value="${model.phone}">
                                </div>
                            </div>
                        </c:if>
                        <!-- Save changes button-->
                        <button class="btn btn-primary" type="button">Save changes</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
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
</script>
</body>
</html>
