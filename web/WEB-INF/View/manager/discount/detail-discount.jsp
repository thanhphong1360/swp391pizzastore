<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<main id="content" role="main" class="main">
    <div class="content container-fluid">
        <div class="page-header">
            <div class="row align-items-center">
                <div class="col-sm mb-2 mb-sm-0">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb breadcrumb-no-gutter">
                            <li class="breadcrumb-item"><a class="breadcrumb-link" href="${pageContext.request.contextPath}/manager/discount/list">Discounts</a></li>
                            <li class="breadcrumb-item active" aria-current="page">${readonly ? "View Discount" : "Edit Discount"}</li>
                        </ol>
                    </nav>
                    <h1 class="page-header-title">
                        ${readonly ? "View Discount" : "Edit Discount"}
                    </h1>
                </div>
            </div>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <c:if test="${not empty discount}">
            <form method="POST" action="${pageContext.request.contextPath}/EditDiscountServlet"
                  class="js-validate" id="discountForm" novalidate>

                <input type="hidden" name="discount_id" value="${discount.discountId}">

                <div class="form-group">
                    <label>Code:</label>
                    <c:if test="${readonly && (empty discount.code)}">
                        <div class="alert alert-warning">Code is required and cannot be empty.</div>
                    </c:if>
                    <input type="text" class="form-control" name="code"
                           value="${not empty discount.code ? discount.code : ''}" ${readonly ? "readonly" : ""} required>
                </div>

                <div class="form-group">
                    <label>Description:</label>
                    <c:if test="${readonly && (empty discount.description)}">
                        <div class="alert alert-warning">Description is required and cannot be empty.</div>
                    </c:if>
                    <textarea class="form-control" name="description" rows="3"
                              ${readonly ? "readonly" : ""} required>${not empty discount.description ? discount.description : ''}</textarea>
                </div>

                <div class="form-group">
                    <label>Type:</label>
                    <c:if test="${readonly && (empty discount.type)}">
                        <div class="alert alert-warning">Type is required and cannot be empty.</div>
                    </c:if>
                    <input type="text" class="form-control" name="type"
                           value="${not empty discount.type ? discount.type : ''}" ${readonly ? "readonly" : ""} required>
                </div>

                <div class="form-group">
                    <label>Value:</label>
                    <c:if test="${readonly && (empty discount.value)}">
                        <div class="alert alert-warning">Value is required and cannot be empty.</div>
                    </c:if>
                    <input type="number" step="0.01" class="form-control" name="value"
                           value="${not empty discount.value ? discount.value : ''}" ${readonly ? "readonly" : ""} required>
                </div>

                <div class="form-group">
                    <label>Start Date:</label>
                    <c:if test="${readonly && (empty discount.startDate)}">
                        <div class="alert alert-warning">Start Date is required and cannot be empty.</div>
                    </c:if>
                    <input type="date" class="form-control" name="start_date"
                           value="${not empty discount.startDate ? discount.startDate : ''}" ${readonly ? "readonly" : ""} required>
                </div>

                <div class="form-group">
                    <label>End Date:</label>
                    <c:if test="${readonly && (empty discount.endDate)}">
                        <div class="alert alert-warning">End Date is required and cannot be empty.</div>
                    </c:if>
                    <input type="date" class="form-control" name="end_date"
                           value="${not empty discount.endDate ? discount.endDate : ''}" ${readonly ? "readonly" : ""} required>
                </div>

                <div class="form-group">
                    <label>Min Invoice Price:</label>
                    <c:if test="${readonly && (empty discount.minInvoicePrice)}">
                        <div class="alert alert-warning">Minimum Invoice Price is required and cannot be empty.</div>
                    </c:if>
                    <input type="number" step="1" class="form-control" name="min_invoice_price"
                           value="${not empty discount.minInvoicePrice ? discount.minInvoicePrice.intValue() : ''}" ${readonly ? "readonly" : ""} required>
                </div>

                <div class="form-group">
                    <label>Max Discount Amount:</label>
                    <c:if test="${readonly && (empty discount.maxDiscountAmount)}">
                        <div class="alert alert-warning">Maximum Discount Amount is required and cannot be empty.</div>
                    </c:if>
                    <input type="number" step="1" class="form-control" name="max_discount_amount"
                           value="${not empty discount.maxDiscountAmount ? discount.maxDiscountAmount.intValue() : ''}" ${readonly ? "readonly" : ""} required>
                </div>

                <div class="form-group">
                    <label>Status:</label>
                    <c:if test="${readonly && (empty discount.status)}">
                        <div class="alert alert-warning">Status is required and cannot be empty.</div>
                    </c:if>
                    <select class="form-control" name="status" ${readonly ? "disabled" : ""} required>
                        <option value="true" ${not empty discount.status && discount.status == true ? "selected" : ""}>Active</option>
                        <option value="false" ${not empty discount.status && discount.status == false ? "selected" : ""}>Inactive</option>
                    </select>
                </div>

                <c:if test="${!readonly}">
                    <button type="submit" class="btn btn-primary">Update</button>
                </c:if>
            </form>
        </c:if>
        <c:if test="${empty discount}">
            <div class="alert alert-warning">No discount data available.</div>
        </c:if>
    </div>
</main>

<script>
    (function () {
        'use strict';
        var form = document.getElementById('discountForm');
        if (form) {
            form.addEventListener('submit', function (event) {
                var isValid = true;
                var fields = [
                    { name: 'code', message: 'Code is required and cannot be empty.' },
                    { name: 'description', message: 'Description is required and cannot be empty.' },
                    { name: 'type', message: 'Type is required and cannot be empty.' },
                    { name: 'value', message: 'Value is required and cannot be empty.' },
                    { name: 'start_date', message: 'Start Date is required and cannot be empty.' },
                    { name: 'end_date', message: 'End Date is required and cannot be empty.' },
                    { name: 'min_invoice_price', message: 'Minimum Invoice Price is required and cannot be empty.' },
                    { name: 'max_discount_amount', message: 'Maximum Discount Amount is required and cannot be empty.' },
                    { name: 'status', message: 'Status is required and cannot be empty.' }
                ];

                fields.forEach(function (field) {
                    var input = form.querySelector('[name="' + field.name + '"]');
                    if (input && !input.value.trim() && !input.disabled) {
                        isValid = false;
                        var warning = document.createElement('div');
                        warning.className = 'alert alert-warning';
                        warning.textContent = field.message;
                        input.parentNode.appendChild(warning);
                        // Remove warning after 3 seconds
                        setTimeout(function () { warning.remove(); }, 3000);
                    }
                });

                if (!isValid) {
                    event.preventDefault();
                    event.stopPropagation();
                } else if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            });
        }
    })();
</script>