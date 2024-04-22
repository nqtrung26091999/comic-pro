<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Side widgets-->
<div class="col-lg-4">
    <!-- Search widget-->
    <div class="card mb-4">
        <div class="card-header">Tìm kiếm</div>
        <div class="card-body">
            <div class="input-group">
                <input class="form-control" type="text" placeholder="Enter search term..."
                       aria-label="Enter search term..." aria-describedby="button-search"/>
            </div>
        </div>
    </div>
    <!-- Categories widget-->
    <div class="card mb-4">
        <div class="card-header">Thể loại</div>
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
        <div class="card-header">Lịch sử</div>
        <div class="card-body">You can put anything you want inside of these side widgets. They are easy to use,
            and feature the Bootstrap 5 card component!
        </div>
    </div>
</div>