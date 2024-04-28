<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Side widgets-->
<div class="col-lg-4">
    <!-- Search widget-->
    <div class="card mb-4">
        <div class="card-header">Tìm kiếm</div>
        <div class="card-body">
            <div class="input-group">
                <input id="inputSearch" class="form-control" type="text" placeholder="Enter search term..."
                       aria-label="Enter search term..." aria-describedby="button-search" list="listSearch"/>
                <datalist id="listSearch">
                    <c:forEach var="item" items="${modelAll}">
                        <option value="${item.name}"></option>
                    </c:forEach>
                </datalist>
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
                            <li><a href="<c:url value="/home?category=${item.id}"/> ">${item.name}</a></li>
                        </ul>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    <!-- Side widget-->
    <div class="card mb-4">
        <div class="card-header">Lịch sử đọc truyện</div>
        <div class="card-body" id="items-history">
        </div>
    </div>
</div>
<script>
</script>