<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title><dec:title default="Trang chủ"/></title>
    <meta content="" name="description">
    <meta content="" name="keywords">

    <!-- Favicons -->
    <link href="<c:url value="/template/admin/assets/img/favicon.png"/>" rel="icon">
    <link href="<c:url value="/template/admin/assets/img/apple-touch-icon.png"/>" rel="apple-touch-icon">

    <!-- Google Fonts -->
    <link href="https://fonts.gstatic.com" rel="preconnect">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
          rel="stylesheet">

    <!-- Vendor CSS Files -->
    <link href="<c:url value="/template/admin/assets/vendor/bootstrap/css/bootstrap.min.css"/>" rel="stylesheet">
    <link href="<c:url value="/template/admin/assets/vendor/bootstrap-icons/bootstrap-icons.css"/>" rel="stylesheet">
    <link href="<c:url value="/template/admin/assets/vendor/boxicons/css/boxicons.min.css"/>" rel="stylesheet">
    <%--    <link href="<c:url value="/template/admin/assets/vendor/quill/quill.snow.css"/>" rel="stylesheet">--%>
    <%--    <link href="<c:url value="/template/admin/assets/vendor/quill/quill.bubble.css"/>" rel="stylesheet">--%>
    <%--    <link href="<c:url value="/template/admin/assets/vendor/remixicon/remixicon.css"/>" rel="stylesheet">--%>
    <%--    <link href="<c:url value="/template/admin/assets/vendor/simple-datatables/style.css"/>" rel="stylesheet">--%>
    <!-- Template Main CSS File -->
    <link href="<c:url value="/template/admin/assets/css/style.css"/>" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
    <script src="<c:url value='/template/paging/jquery.twbsPagination.js'/>"></script>
</head>
<body>
<%--header--%>
<%@include file="/common/admin/header.jsp" %>
<%--menu--%>
<%@include file="/common/admin/sidebar.jsp" %>
<main id="main" class="main">
    <%--body--%>
    <dec:body/>
</main>
<%--footer--%>
<%@include file="/common/admin/footer.jsp" %>
<!-- Vendor JS Files -->
<script src="<c:url value="/template/admin/assets/vendor/apexcharts/apexcharts.min.js"/>"></script>
<script src="<c:url value="/template/admin/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"/>"></script>
<script src="<c:url value="/template/admin/assets/vendor/chart.js/chart.umd.js"/>"></script>
<script src="<c:url value="/template/admin/assets/vendor/echarts/echarts.min.js"/>"></script>
<script src="<c:url value="/template/admin/assets/vendor/quill/quill.min.js"/>"></script>
<script src="<c:url value="/template/admin/assets/vendor/simple-datatables/simple-datatables.js"/>"></script>
<%--<script src="<c:url value="/template/admin/assets/vendor/tinymce/tinymce.min.js"/>"></script>--%>
<script src="<c:url value="/template/admin/assets/vendor/php-email-form/validate.js"/>"></script>
<script src="<c:url value="/template/admin/assets/js/main.js"/>"></script>
</body>
</html>
