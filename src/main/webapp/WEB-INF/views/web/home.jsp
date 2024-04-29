<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ</title>
</head>
<body>
<!-- Blog entries-->
<div class="col-lg-8">
    <!-- Nested row for non-featured blog posts-->
    <h3><strong>Truyện đề cử <i class="fa-solid fa-arrow-down"></i></strong></h3>
    <hr>
    <div id="recipeCarousel" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-inner" role="listbox">
            <div class="carousel-item active">
                <div class="col-md-3">
                    <div class="card-img">
                        <a href="<c:url value="/comic?id=${comicNewest.id}"/>">
                            <img src="${comicNewest.cover}" class="border rounded" height="200" width="200" alt="" title="${comicNewest.name}">
                        </a>
                    </div>
                </div>
            </div>
            <c:forEach items="${model}" var="item">
                <div class="carousel-item">
                    <div class="col-md-3">
                        <div class="card-img">
                            <a href="<c:url value="/comic?id=${item.id}"/>">
                                <img src="${item.cover}" class="border rounded" alt="" height="200" width="200" title="${item.name}">
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        <a class="carousel-control-prev bg-transparent w-aut" href="#recipeCarousel" role="button"
           data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        </a>
        <a class="carousel-control-next bg-transparent w-aut" href="#recipeCarousel" role="button"
           data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
        </a>
    </div>
    <hr>
    <h3><strong>Truyện tổng hợp <i class="fa-solid fa-arrow-down"></i></strong></h3>
    <div class="row">
        <c:forEach var="item" items="${modelAll}">
            <div class="col-lg-3">
                <!-- Blog post-->
                <div class="card mb-4">
                    <a href="#!">
                        <img class="card-img-top" src="${item.cover}" height="200" alt="..."/>
                    </a>
                    <div class="card-body">
                        <div class="small text-muted">${item.createdDate}</div>
                        <h2 class="small card-title h4">${item.name}</h2>
                        <a class="btn btn-primary btn-sm" href="<c:url value="/comic?id=${item.id}"/>">Read →</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    <!-- Pagination-->
    <nav aria-label="Pagination">
        <hr class="my-0"/>
        <ul class="pagination justify-content-center my-4">
            <li class="page-item disabled"><a class="page-link" href="#" tabindex="-1"
                                              aria-disabled="true">Newer</a>
            </li>
            <li class="page-item active" aria-current="page"><a class="page-link" href="#!">1</a></li>
            <li class="page-item"><a class="page-link" href="#!">2</a></li>
            <li class="page-item"><a class="page-link" href="#!">3</a></li>
            <li class="page-item disabled"><a class="page-link" href="#!">...</a></li>
            <li class="page-item"><a class="page-link" href="#!">15</a></li>
            <li class="page-item"><a class="page-link" href="#!">Older</a></li>
        </ul>
    </nav>
</div>
<script>
    let items = document.querySelectorAll('.carousel .carousel-item')

    items.forEach((el) => {
        const minPerSlide = 4
        let next = el.nextElementSibling
        for (var i = 1; i < minPerSlide; i++) {
            if (!next) {
                // wrap carousel by using first child
                next = items[0]
            }
            let cloneChild = next.cloneNode(true)
            el.appendChild(cloneChild.children[0])
            next = next.nextElementSibling
        }
    })
</script>
</body>
</html>