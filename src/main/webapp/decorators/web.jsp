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
