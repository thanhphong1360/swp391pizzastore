<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="content" role="main" class="main">
    <div class="content container-fluid">
        <div class="page-header">
            <div class="row align-items-center">
                <div class="col-sm mb-2 mb-sm-0">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb breadcrumb-no-gutter">
                            <li class="breadcrumb-item"><a class="breadcrumb-link" href="${pageContext.request.contextPath}/manager/discount/list">Discounts</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Confirm Delete</li>
                        </ol>
                    </nav>
                    <h1 class="page-header-title">Confirm Delete Discount</h1>
                </div>
            </div>
        </div>
        <div class="alert alert-warning">
            Bạn chắc chắn muốn xóa mã giảm giá <strong>${discount.code}</strong>?
        </div>
        <form action="${pageContext.request.contextPath}/DeleteDiscountServlet" method="POST" style="display: inline;">
            <input type="hidden" name="id" value="${discount.discountId}">
            <button type="submit" class="btn btn-danger">Có</button>
            <a href="${pageContext.request.contextPath}/manager/discount/list" class="btn btn-secondary">Không</a>
        </form>
    </div>
</main>