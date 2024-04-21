<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home page</title>
</head>
<body>
<!-- Page content-->
<div class="container">
    <div class="row">
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
                                <a href="#">
                                    <img src="${comicNewest.cover}" height="200" width="200" alt="" title="${comicNewest.name}">
                                </a>
                            </div>
                        </div>
                    </div>
                    <c:forEach items="${model}" var="item">
                        <div class="carousel-item">
                            <div class="col-md-3">
                                <div class="card-img">
                                    <a href="">
                                        <img src="${item.cover}" class="" alt="" height="200" width="200" title="${item.name}">
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
                                <img class="card-img-top" src="${item.cover}" height="220" alt="..."/>
                            </a>
                            <div class="card-body">
                                <div class="small text-muted">${item.createdDate}</div>
                                <h2 class="small card-title h4">${item.name}</h2>
                                <a class="btn btn-primary btn-sm" href="#!">Read →</a>
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
        <!-- Side widgets-->
        <div class="col-lg-4">
            <!-- Search widget-->
            <div class="card mb-4">
                <div class="card-header">Search</div>
                <div class="card-body">
                    <div class="input-group">
                        <input class="form-control" type="text" placeholder="Enter search term..."
                               aria-label="Enter search term..." aria-describedby="button-search"/>
                        <button class="btn btn-primary" id="button-search" style="border-radius: 3px; margin-top: 5px;"
                                type="button">Go!
                        </button>
                    </div>
                </div>
            </div>
            <!-- Categories widget-->
            <div class="card mb-4">
                <div class="card-header">Categories</div>
                <div class="card-body">
                    <div class="row">
                        <c:forEach items="${categories}" var="item">
                            <div class="col-sm-6">
                                <ul class="list-unstyled mb-0">
                                    <li><a href="#!">${item.name}</a></li>
                                </ul>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <!-- Side widget-->
            <div class="card mb-4">
                <div class="card-header">Side Widget</div>
                <div class="card-body">You can put anything you want inside of these side widgets. They are easy to use,
                    and feature the Bootstrap 5 card component!
                </div>
            </div>
        </div>
    </div>
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