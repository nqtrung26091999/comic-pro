<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>
    <title>Blog Home - Start Bootstrap Template</title>
    <!-- Favicon-->
    <link rel="icon" type="image/x-icon" href="<c:url value='/template/web/assets/favicon.ico'/>"/>
    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="<c:url value='/template/web/css/styles.css'/>" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <style>
        .modal-header, h4, .close {
            background-color: #5cb85c;
            color: white !important;
            text-align: center;
            font-size: 30px;
        }

        .modal-footer {
            background-color: #f9f9f9;
        }

        .main-body {
            display: flex;
            flex-direction: column;
        }

        .footer-flex {
            width: 100%;
        }

        .footer {
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
        }

        /*carousel*/
        @media (max-width: 767px) {
            .carousel-inner .carousel-item > div {
                display: none;
            }

            .carousel-inner .carousel-item > div:first-child {
                display: block;
            }
        }

        .carousel-inner .carousel-item.active,
        .carousel-inner .carousel-item-next,
        .carousel-inner .carousel-item-prev {
            display: flex;
        }

        /* medium and up screens */
        @media (min-width: 768px) {

            .carousel-inner .carousel-item-end.active,
            .carousel-inner .carousel-item-next {
                transform: translateX(25%);
            }

            .carousel-inner .carousel-item-start.active,
            .carousel-inner .carousel-item-prev {
                transform: translateX(-25%);
            }
        }

        .carousel-inner .carousel-item-end,
        .carousel-inner .carousel-item-start {
            transform: translateX(0);
        }
    </style>
</head>
<body class="main-body">
<%--header--%>
<%@include file="/common/web/header.jsp" %>
<%--body--%>
<div class="container">
    <div class="row">
        <dec:body/>
        <c:if test="${not empty categories}">
            <%@include file="/common/web/menu.jsp" %>
        </c:if>
    </div>
</div>
<%-- Footer --%>
<div class="footer">
    <%@include file="/common/web/footer.jsp" %>
</div>
<script>
    $(document).ready(function () {
        $("#myBtnLogin").click(function () {
            $("#myModalLogin").modal('toggle');
        });
        $("#myBtnSignUp").click(function () {
            $("#myModalSignUp").modal('toggle');
        });
    });
</script>
</body>
</html>
