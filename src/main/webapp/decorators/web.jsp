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
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <style>
        .modal-header, h4, .close {
            background-color: #5cb85c;
            color:white !important;
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
         .col-centered {
             float: none;
             margin: 0 auto;
         }

        .carousel-control {
            width: 8%;
            width: 0px;
        }
        .carousel-control.left,
        .carousel-control.right {
            margin-right: 40px;
            margin-left: 32px;
            background-image: none;
            opacity: 1;
        }
        .carousel-control > a > span {
            color: white;
            font-size: 29px !important;
        }

        .carousel-col {
            position: relative;
            min-height: 1px;
            padding: 5px;
            float: left;
        }

        .active > div { display:none; }
        .active > div:first-child { display:block; }

        /*xs*/
        @media (max-width: 767px) {
            .carousel-inner .active.left { left: -50%; }
            .carousel-inner .active.right { left: 50%; }
            .carousel-inner .next        { left:  50%; }
            .carousel-inner .prev		     { left: -50%; }
            .carousel-col                { width: 50%; }
            .active > div:first-child + div { display:block; }
        }

        /*sm*/
        @media (min-width: 768px) and (max-width: 991px) {
            .carousel-inner .active.left { left: -50%; }
            .carousel-inner .active.right { left: 50%; }
            .carousel-inner .next        { left:  50%; }
            .carousel-inner .prev		     { left: -50%; }
            .carousel-col                { width: 50%; }
            .active > div:first-child + div { display:block; }
        }

        /*md*/
        @media (min-width: 992px) and (max-width: 1199px) {
            .carousel-inner .active.left { left: -33%; }
            .carousel-inner .active.right { left: 33%; }
            .carousel-inner .next        { left:  33%; }
            .carousel-inner .prev		     { left: -33%; }
            .carousel-col                { width: 33%; }
            .active > div:first-child + div { display:block; }
            .active > div:first-child + div + div { display:block; }
        }

        /*lg*/
        @media (min-width: 1200px) {
            .carousel-inner .active.left { left: -25%; }
            .carousel-inner .active.right{ left:  25%; }
            .carousel-inner .next        { left:  25%; }
            .carousel-inner .prev		     { left: -25%; }
            .carousel-col                { width: 25%; }
            .active > div:first-child + div { display:block; }
            .active > div:first-child + div + div { display:block; }
            .active > div:first-child + div + div + div { display:block; }
        }

        .block {
            width: 306px;
            height: 230px;
        }

        .red {background: red;}

        .blue {background: blue;}

        .green {background: green;}

        .yellow {background: yellow;}
    </style>
</head>
<body class="main-body">
<%--header--%>
<%@include file="/common/web/header.jsp" %>
<%--body--%>
<dec:body/>
<%-- Footer --%>
<div class="footer">
    <%@include file="/common/web/footer.jsp" %>
</div>
<script>
    $(document).ready(function(){
        $("#myBtnLogin").click(function(){
            $("#myModalLogin").modal('toggle');
        });
        $("#myBtnSignUp").click(function(){
            $("#myModalSignUp").modal('toggle');
        });
    });
</script>
</body>
</html>
