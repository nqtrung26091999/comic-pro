<%@ include file="/common/taglib.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="com.example.util.SecurityUtils" %>
<html>
<head>
    <title>${model.name}</title>
</head>
<body>
<div class="col-lg-8">
    <!-- Post content-->
    <article>
        <!-- Post header-->
        <header class="mb-4">
            <!-- Post title-->
            <h1 class="fw-bolder mb-1">${model.name}</h1>
            <!-- Post meta content-->
            <div class="text-muted fst-italic mb-2">${model.createdDate}</div>
            <!-- Post categories-->
            <c:forEach items="${model.listCategory}" var="category">
                <a class="badge bg-secondary text-decoration-none link-light"
                   href="<c:url value="/home?category=${category.id}"/>">${category.name}</a>
            </c:forEach>
        </header>
        <!-- Preview image figure-->
        <div class="row">
            <div class="col-4">
                <figure class="mb-4"><img class="img-fluid rounded" src="${model.cover}" alt="..."/></figure>
            </div>
            <div class="col-8 mb-4">
                <div class="row">
                    <p><strong><i class="fa-solid fa-user-pen mb-3"></i> Tác giả: </strong><a href="#"
                                                                                              style="text-decoration: none;">${model.author}</a>
                    </p>
                    <p><strong><i class="fa-solid fa-rss mb-3"></i> Tình trạng: </strong>Đang tiến hành</p>
                    <p><strong><i class="fa-solid fa-eye mb-3"></i> Lượt xem: </strong>194.278</p>
                    <p><strong><i class="fa-solid fa-heart mb-3"></i> Lượt theo dõi: 2.456</strong> Lươt theo dõi</p>
                    <div class="col mb-3">
                        <c:set var="disabled" scope="session" value=""/>
                        <c:if test="${empty chapters}">
                            <c:set var="disabled" scope="session" value="disabled"/>
                        </c:if>
                        <button class="btn btn-success"><i class="fa-solid fa-heart"></i> Theo dõi</button>
                        <button class="btn btn-danger" id="btnReadFirst"
                                onclick="location.href='/content?comic=${model.id}&chapter=${chapters[0].id}'" <c:out
                                value="${disabled}"/>>Đọc từ đầu
                        </button>
                        <button class="btn btn-danger" <c:out value="${disabled}"/>>Đọc mới nhất</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Post content-->
        <section class="mb-5">
            <h3 class="mb-4 mt-5"><i class="fa-regular fa-file-lines"></i> Nội dung</h3>
            <hr>
            <p class="fs-5 mb-4">${model.description}</p>
            <h3 class="mb-4 mt-5"><i class="fa-solid fa-list"></i> Danh sách chapter</h3>
            <hr>
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>Chapter</th>
                    <th>Cập nhật</th>
                    <th>Lượt xem</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="item" items="${chapters}">
                    <tr>
                        <td>
                            <button class="btn btn-link"
                                    onclick="handleStorage('${item.name}', '${item.id}')">${item.name}</button>
                        </td>
                        <td>${item.modifiedDate}</td>
                        <td>456</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </section>
    </article>
    <!-- Comments section-->
    <section class="mb-5">
        <div class="card bg-light">
            <div class="card-body">
                <!-- Comment form-->
                <form class="mb-4"><textarea class="form-control" rows="3"
                                             placeholder="Join the discussion and leave a comment!"></textarea>
                </form>
                <!-- Comment with nested comments-->
                <div class="d-flex mb-4">
                    <!-- Parent comment-->
                    <div class="flex-shrink-0"><img class="rounded-circle"
                                                    src="https://dummyimage.com/50x50/ced4da/6c757d.jpg"
                                                    alt="..."/></div>
                    <div class="ms-3">
                        <div class="fw-bold">Commenter Name</div>
                        If you're going to lead a space frontier, it has to be government; it'll never be
                        private enterprise. Because the space frontier is dangerous, and it's expensive, and it
                        has unquantified risks.
                        <!-- Child comment 1-->
                        <div class="d-flex mt-4">
                            <div class="flex-shrink-0"><img class="rounded-circle"
                                                            src="https://dummyimage.com/50x50/ced4da/6c757d.jpg"
                                                            alt="..."/></div>
                            <div class="ms-3">
                                <div class="fw-bold">Commenter Name</div>
                                And under those conditions, you cannot establish a capital-market evaluation of
                                that enterprise. You can't get investors.
                            </div>
                        </div>
                        <!-- Child comment 2-->
                        <div class="d-flex mt-4">
                            <div class="flex-shrink-0"><img class="rounded-circle"
                                                            src="https://dummyimage.com/50x50/ced4da/6c757d.jpg"
                                                            alt="..."/></div>
                            <div class="ms-3">
                                <div class="fw-bold">Commenter Name</div>
                                When you put money directly to a problem, it makes a good headline.
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Single comment-->
                <div class="d-flex">
                    <div class="flex-shrink-0"><img class="rounded-circle"
                                                    src="https://dummyimage.com/50x50/ced4da/6c757d.jpg"
                                                    alt="..."/></div>
                    <div class="ms-3">
                        <div class="fw-bold">Commenter Name</div>
                        When I look at the universe and all the ways the universe wants to kill us, I find it
                        hard to reconcile that with statements of beneficence.
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
<script>
    let username = "";
    <security:authorize access="isAuthenticated()">
    username = "<%=SecurityUtils.getPrincipal().getUsername()%>"
    </security:authorize>
    const cover = "${model.cover}";
    const name = "${model.name}";
    const comicId = "${model.id}";
    const chapterIdFirst = "${chapters[0].id}"
    const chapterNameFirst = "${chapters[0].name}"

    $("#btnReadFirst").bind("click", function() {
        handleStorage(chapterNameFirst, chapterIdFirst);
    })

    function handleStorage(chapterName, chapterId) {
        if (username != "") {
            const formData = new FormData();
            formData.append("username", username);
            formData.append("chapterId", chapterId);
            $.ajax({
                url: "/api/history",
                method: "POST",
                type: "POST",
                contentType: false,
                processData: false,
                cache: false,
                data: formData
            });
        } else {
            let obj = {};
            let key = name + "_" + chapterName;
            obj = {
                cover,
                name,
                chapterName,
            }
            localStorage.setItem(key, JSON.stringify(obj));
        }
        location.href = "/content?comic=" + comicId + "&chapter=" + chapterId;
    }
</script>
</body>
</html>
