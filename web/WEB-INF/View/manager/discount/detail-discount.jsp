<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>${readonly ? "View" : (discount != null ? "Edit" : "Add")} Discount | Pizza House</title>
        <base href="${pageContext.request.contextPath}/"> <!-- BẮT BUỘC -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
        <style>
            body {
                font-family:'Poppins',sans-serif;
                background:#fff8f3;
                margin:30px;
            }
            h2 {
                color:#e63946;
                font-weight:600;
                text-align:center;
            }
            .card {
                border-radius:12px;
                box-shadow:0 4px 12px rgba(0,0,0,0.1);
            }
            .btn-red {
                background:#e63946;
                color:white;
                transition:0.3s;
            }
            .btn-red:hover {
                background:#c72e3b;
            }
            .btn-gray {
                background:#718093;
                color:white;
                transition:0.3s;
            }
            .btn-gray:hover {
                background:#9c9c9c;
            }
        </style>
    </head>
    <body>
        <div class="container my-4">
            <h2>${readonly ? "View Discount" : (discount != null ? "Edit Discount" : "Add Discount")}</h2>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <div class="card p-4 mx-auto" style="max-width:700px;">
                <form method="POST" action="EditDiscountServlet"
                      class="js-validate" id="discountForm" novalidate>

                    <c:if test="${discount != null}">
                        <input type="hidden" name="discount_id" value="${discount.discountId}">
                    </c:if>

                    <c:set var="readonlyAttr" value="${readonly ? 'readonly' : ''}" />
                    <c:set var="disabledAttr" value="${readonly ? 'disabled' : ''}" />

                    <div class="mb-3">
                        <label class="form-label">Code</label>
                        <input type="text" class="form-control" name="code" value="${discount.code}" ${readonlyAttr} required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Description</label>
                        <textarea class="form-control" name="description" rows="3" ${readonlyAttr} required>${discount.description}</textarea>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Type</label>
                        <input type="text" class="form-control" name="type" value="${discount.type}" ${readonlyAttr} required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Value</label>
                        <input type="number" step="0.01" class="form-control" name="value" value="${discount.value}" ${readonlyAttr} required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Start Date</label>
                        <input type="date" class="form-control" name="start_date" value="${discount.startDate}" ${readonlyAttr} required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">End Date</label>
                        <input type="date" class="form-control" name="end_date" value="${discount.endDate}" ${readonlyAttr} required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Min Invoice Price (VND)</label>
                        <input type="number" step="1" class="form-control" name="min_invoice_price"
                               value="${discount.minInvoicePrice != null ? discount.minInvoicePrice.intValue() : ''}" ${readonlyAttr} required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Max Discount Amount (VND)</label>
                        <input type="number" step="1" class="form-control" name="max_discount_amount"
                               value="${discount.maxDiscountAmount != null ? discount.maxDiscountAmount.intValue() : ''}" ${readonlyAttr} required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Status</label>
                        <select class="form-control" name="status" ${disabledAttr} required>
                            <option value="true" ${discount == null || discount.status ? 'selected' : ''}>Active</option>
                            <option value="false" ${discount != null && !discount.status ? 'selected' : ''}>Inactive</option>
                        </select>
                    </div>

                    <c:if test="${!readonly}">
                        <button type="submit" class="btn btn-red w-100 mb-2">
                            ${discount != null ? 'Update Discount' : 'Create Discount'}
                        </button>
                    </c:if>

                    <a href="manager/discount/list" class="btn btn-gray w-100">
                        ${readonly ? 'Back to List' : 'Cancel'}
                    </a>
                </form>
            </div>
        </div>

        <script>
            (function () {
                'use strict';
                var form = document.getElementById('discountForm');
                if (form) {
                    form.addEventListener('submit', function (event) {
                        var isValid = true;
                        var fields = [
                            {name: 'code', message: 'Code is required and cannot be empty.'},
                            {name: 'description', message: 'Description is required and cannot be empty.'},
                            {name: 'type', message: 'Type is required and cannot be empty.'},
                            {name: 'value', message: 'Value is required and cannot be empty.'},
                            {name: 'start_date', message: 'Start Date is required and cannot be empty.'},
                            {name: 'end_date', message: 'End Date is required and cannot be empty.'},
                            {name: 'min_invoice_price', message: 'Minimum Invoice Price is required and cannot be empty.'},
                            {name: 'max_discount_amount', message: 'Maximum Discount Amount is required and cannot be empty.'},
                            {name: 'status', message: 'Status is required and cannot be empty.'}
                        ];

                        fields.forEach(function (field) {
                            var input = form.querySelector('[name="' + field.name + '"]');
                            if (input && !input.value.trim() && !input.disabled) {
                                isValid = false;
                                var warning = document.createElement('div');
                                warning.className = 'alert alert-warning';
                                warning.textContent = field.message;
                                input.parentNode.appendChild(warning);
                                setTimeout(function () {
                                    warning.remove();
                                }, 3000);
                            }
                        });

                        if (!isValid || !form.checkValidity()) {
                            event.preventDefault();
                            event.stopPropagation();
                        }
                        form.classList.add('was-validated');
                    });
                }
            })();
        </script>
    </body>
</html>
