<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<%@page import="com.example.util.SecurityUtils" %>
<!-- Responsive navbar-->
<nav class="navbar navbar-expand-lg navbar-dark bg-black">
    <div class="container">
        <a class="navbar-brand" href="<c:url value="/home"/>">Start Bootstrap</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span
                class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link" href="#">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="#">About</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Contact</a></li>
            </ul>
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0 navbar-right">
                <security:authorize access="isAnonymous()">
                    <li class="nav-item">
                        <a class="nav-link active" href="#" id="myBtnLogin">
                            <span class="glyphicon glyphicon-user"></span> Đăng nhập
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="#" id="myBtnSignUp">
                            <span class="glyphicon glyphicon-log-in"></span> Đăng Ký
                        </a>
                    </li>
                </security:authorize>
                <security:authorize access="isAuthenticated()">
                    <li class="nav-item">
                        <img
                             class="img-account-profile rounded-circle"
                             src="<%=SecurityUtils.getPrincipal().getAvatar()%>"
                             height="45"
                             width="45" alt="">
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="<c:url value="/profile"/>"> Xin
                            chào, <%=SecurityUtils.getPrincipal().getFullName()%>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="<c:url value="/logout"/>" id="myBtnLogout">
                            <span class="glyphicon glyphicon-log-out"></span> Thoát
                        </a>
                    </li>
                </security:authorize>
            </ul>
        </div>
        <!-- Modal -->
        <div class="modal fade" id="myModalLogin" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header" style="padding:35px 50px;">
                        <h4><span class="glyphicon glyphicon-lock"></span>Đăng nhập</h4>
                    </div>
                    <div class="modal-body" style="padding:40px 50px;">
                        <form role="form" method="post" action="j_spring_security_check">
                            <div class="form-group">
                                <label for=username><span class="glyphicon glyphicon-user"></span> Tên đăng nhập</label>
                                <input type="text" class="form-control" name="j_username" id="username"
                                       placeholder="Enter username" required>
                            </div>
                            <div class="form-group">
                                <label for="password"><span class="glyphicon glyphicon-eye-open"></span> Mật
                                    khẩu</label>
                                <input type="password" class="form-control" name="j_password" id="password"
                                       placeholder="Enter password" required>
                            </div>
                            <div class="checkbox">
                                <label><input type="checkbox" value="" checked>Giữ đăng nhập</label>
                            </div>
                            <button type="submit" class="btn btn-success btn-block"><span
                                    class="glyphicon glyphicon-off"></span> Đăng nhập
                            </button>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-danger btn-default pull-left" data-dismiss="modal"><span
                                class="glyphicon glyphicon-remove"></span> Cancel
                        </button>
                        <p>Quên <a href="#">Mật khẩu?</a></p>
                    </div>
                </div>

            </div>
        </div>
        <!-- Modal -->
        <div class="modal fade" id="myModalSignUp" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header" style="padding:35px 50px;">
                        <h4><span class="glyphicon glyphicon-lock"></span>Đăng ký</h4>
                    </div>
                    <div class="modal-body" style="padding:40px 50px;">
                        <form role="form" id="formSubmit">
                            <div id="message"></div>
                            <div class="form-group">
                                <label for=new-username><span class="glyphicon glyphicon-user"></span> Tên đăng
                                    nhập</label>
                                <input type="text" class="form-control" name="username" id="new-username"
                                       placeholder="Enter email">
                            </div>
                            <div class="form-group">
                                <label for=fullName><span class="glyphicon glyphicon-pencil"></span> Họ và tên</label>
                                <input type="text" class="form-control" name="fullName" id="fullName"
                                       placeholder="Enter email">
                            </div>
                            <div class="form-group">
                                <label for=email><span class="glyphicon glyphicon-envelope"></span> Email</label>
                                <input type="text" class="form-control" name="email" id="email"
                                       placeholder="Enter email">
                            </div>
                            <div class="form-group">
                                <label for=phone><span class="glyphicon glyphicon-phone"></span> Số điện thoại</label>
                                <input type="text" class="form-control" name="phone" id="phone"
                                       placeholder="Enter email">
                            </div>
                            <div class="form-group">
                                <label for="new-password"><span class="glyphicon glyphicon-eye-open"></span> Mật
                                    khẩu</label>
                                <input type="password" class="form-control" name="password" id="new-password"
                                       placeholder="Enter password">
                            </div>
                            <div class="form-group">
                                <label for="rePassword"><span class="glyphicon glyphicon-eye-open"></span> Xác nhận mật
                                    khẩu</label>
                                <input type="password" class="form-control" name="rePassword" id="rePassword"
                                       placeholder="Enter password again">
                            </div>
                            <div class="checkbox">
                                <label><input type="checkbox" value="" checked>Tôi đồng ý với các điều khoản</label>
                            </div>
                            <button type="button" class="btn btn-success btn-block" id="btnRegister"><span
                                    class="glyphicon glyphicon-off"></span> Đăng ký
                            </button>
                        </form>
                    </div>
                </div>

            </div>
        </div>
    </div>
</nav>
<br>
<script>
    $("#btnRegister").click(function (e) {
        e.preventDefault();
        let formData = $("#formSubmit").serializeArray();
        let data = {};
        $.each(formData, function (i, v) {
            data["" + v.name + ""] = v.value;
        });
        $.ajax({
            url: "/api/user",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(data),
            dataType: "json",
            success: rs => {
                window.location.href = "/profile?id=" + rs.id + "message=success";
            },
            error: err => {
                $("#message").append($("<div class='alert alert-danger'>Đăng ký thất bại !</div>"))
            }
        })
    })
</script>
<!-- Page header with logo and tagline-->