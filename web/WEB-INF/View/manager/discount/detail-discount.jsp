<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="content" role="main" class="main">
    <div class="content container-fluid">
        <div class="page-header">
            <div class="row align-items-center">
                <div class="col-sm mb-2 mb-sm-0">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb breadcrumb-no-gutter">
                            <li class="breadcrumb-item"><a class="breadcrumb-link" href="${pageContext.request.contextPath}/manager/discount/list">Discounts</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Discount Detail</li>
                        </ol>
                    </nav>
                    <h1 class="page-header-title">Edit Discount</h1>
                </div>
            </div>
        </div>
        <form method="POST" action="${pageContext.request.contextPath}/EditDiscountServlet" class="js-validate" novalidate>
            <input type="hidden" name="discount_id" value="${discount.discountId}">
            <div class="form-group">
                <label>Code:</label>
                <input type="text" class="form-control" name="code" value="${discount.code}" required>
            </div>
            <div class="form-group">
                <label>Description:</label>
                <textarea class="form-control" name="description" rows="3" required>${discount.description}</textarea>
            </div>
            <div class="form-group">
                <label>Type:</label>
                <input type="text" class="form-control" name="type" value="${discount.type}" required>
            </div>
            <div class="form-group">
                <label>Value:</label>
                <input type="number" step="0.01" class="form-control" name="value" value="${discount.value}" required>
            </div>
            <div class="form-group">
                <label>Start Date:</label>
                <input type="date" class="form-control" name="start_date" value="${discount.startDate}" required>
            </div>
            <div class="form-group">
                <label>End Date:</label>
                <input type="date" class="form-control" name="end_date" value="${discount.endDate}" required>
            </div>
            <div class="form-group">
                <label>Min Invoice Price:</label>
                <input type="number" step="1" class="form-control" name="min_invoice_price" value="${discount.minInvoicePrice.intValue()}" required>
            </div>
            <div class="form-group">
                <label>Max Discount Amount:</label>
                <input type="number" step="1" class="form-control" name="max_discount_amount" value="${discount.maxDiscountAmount.intValue()}" required>
            </div>
            <div class="form-group">
                <label>Status:</label>
                <select class="form-control" name="status" required>
                    <option value="true" ${discount.status == true ? 'selected' : ''}>Active</option>
                    <option value="false" ${discount.status == false ? 'selected' : ''}>Inactive</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Update</button>
        </form>
    </div>
</main>
<script>
    (function () {
        'use strict'
        var forms = document.querySelectorAll('.js-validate')
        Array.prototype.slice.call(forms).forEach(function (form) {
            form.addEventListener('submit', function (event) {
                if (!form.checkValidity()) {
                    event.preventDefault()
                    event.stopPropagation()
                }
                form.classList.add('was-validated')
            }, false)
        })
    })()
</script>