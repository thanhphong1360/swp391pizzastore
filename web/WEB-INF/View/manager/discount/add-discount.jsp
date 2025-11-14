<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Create Discount | Pizza House</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
        <style>
            body {
                font-family: 'Poppins', sans-serif;
                background: #fff8f3;
                margin: 30px;
            }
            h2 {
                color: #e63946;
                font-weight: 600;
            }
            .home-btn, .add-btn {
                border-radius: 8px;
                font-weight: 500;
                padding: 8px 14px;
                text-decoration: none;
                color: white;
                transition: 0.3s;
            }
            .home-btn {
                background: #718093;
            }
            .home-btn:hover {
                background: #9c9c9c;
            }
            .add-btn {
                background: #e63946;
            }
            .add-btn:hover {
                background: #c72e3b;
            }
            .card {
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            }
            .btn-primary {
                background: #e63946;
                border: none;
            }
            .btn-primary:hover {
                background: #c72e3b;
            }
            .btn-secondary {
                background: #718093;
                border: none;
            }
            .btn-secondary:hover {
                background: #9c9c9c;
            }
            .invalid-feedback {
                display: none;
                width: 100%;
                margin-top: 0.25rem;
                font-size: 0.875em;
                color: #dc3545;
            }
            .was-validated .invalid-feedback {
                display: block;
            }
            .was-validated .form-control:invalid,
            .was-validated .form-select:invalid {
                border-color: #dc3545;
            }
        </style>
    </head>
    <body>

        <div class="d-flex justify-content-between mb-3">
            <h2>Create New Discount</h2>
            <a href="${pageContext.request.contextPath}/manager/discount/list" class="home-btn">Back to List</a>
        </div>

        <div class="card p-4 mb-4" style="max-width: 700px; margin: auto;">
            <!-- Server-side error -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert">${error}</div>
            </c:if>

            <!-- Form -->
            <form method="POST" 
                  action="${pageContext.request.contextPath}/manager/discount/add-discount" 
                  class="needs-validation" 
                  novalidate>

                <!-- Code -->
                <div class="mb-3">
                    <label class="form-label">Code</label>
                    <input type="text" 
                           name="code" 
                           class="form-control" 
                           value="${code}" 
                           required>
                    <div class="invalid-feedback">Please enter a discount code.</div>
                </div>

                <!-- Description -->
                <div class="mb-3">
                    <label class="form-label">Description</label>
                    <textarea name="description" 
                              class="form-control" 
                              rows="3" 
                              required>${description}</textarea>
                    <div class="invalid-feedback">Please enter a description.</div>
                </div>

                <!-- Type (Dropdown) -->
                <div class="mb-3">
                    <label class="form-label" for="discountType">Type</label>
                    <select id="discountType" 
                            name="type" 
                            class="form-select" 
                            required>
                        <option value="percentage" ${type == 'percentage' ? 'selected' : ''}>Percentage</option>
                        <option value="fixed" ${type == 'fixed' ? 'selected' : ''}>Fixed</option>
                    </select>
                    <div class="invalid-feedback">Please select a type.</div>
                </div>

                <!-- Value -->
                <div class="mb-3">
                    <label class="form-label">Value</label>
                    <input type="number" 
                           step="0.01" 
                           name="value" 
                           class="form-control" 
                           value="${value}" 
                           required>
                    <div class="invalid-feedback">Please enter a valid value.</div>
                </div>

                <!-- Start Date -->
                <div class="mb-3">
                    <label class="form-label">Start Date</label>
                    <input type="date" 
                           id="startDate" 
                           name="start_date" 
                           class="form-control" 
                           value="${start_date}" 
                           required>
                    <div class="invalid-feedback">Please select a valid start date.</div>
                </div>

                <!-- End Date -->
                <div class="mb-3">
                    <label class="form-label">End Date</label>
                    <input type="date" 
                           id="endDate" 
                           name="end_date" 
                           class="form-control" 
                           value="${end_date}" 
                           required>
                    <div class="invalid-feedback">End date must be after start date.</div>
                </div>

                <!-- Min Invoice Price -->
                <div class="mb-3">
                    <label class="form-label">Min Invoice Price</label>
                    <input type="number" 
                           step="1" 
                           name="min_invoice_price" 
                           class="form-control" 
                           value="${min_invoice_price}" 
                           required>
                    <div class="invalid-feedback">Please enter the minimum invoice price.</div>
                </div>

                <!-- Max Discount Amount -->
                <div class="mb-3">
                    <label class="form-label">Max Discount Amount</label>
                    <input type="number" 
                           step="1" 
                           name="max_discount_amount" 
                           class="form-control" 
                           value="${max_discount_amount}" 
                           required>
                    <div class="invalid-feedback">Please enter the maximum discount amount.</div>
                </div>

                <!-- Status -->
                <div class="mb-3">
                    <label class="form-label">Status</label>
                    <select name="status" 
                            class="form-select" 
                            required>
                        <option value="true" ${status == 'true' ? 'selected' : ''}>Active</option>
                        <option value="false" ${status == 'false' ? 'selected' : ''}>Inactive</option>
                    </select>
                    <div class="invalid-feedback">Please select a status.</div>
                </div>

                <!-- Buttons -->
                <button type="submit" class="btn btn-primary w-100">Create Discount</button>
                <a href="${pageContext.request.contextPath}/manager/discount/list" 
                   class="btn btn-secondary w-100 mt-2">Cancel</a>
            </form>
        </div>

        <!-- Bootstrap + Custom Validation JS -->
        <script>
            (function () {
                'use strict';

                const forms = document.querySelectorAll('.needs-validation');
                forms.forEach(form => {
                    const startDateInput = form.querySelector('#startDate');
                    const endDateInput = form.querySelector('#endDate');

                    // Validate ngày
                    function validateDates() {
                        const start = startDateInput.value;
                        const end = endDateInput.value;

                        startDateInput.setCustomValidity('');
                        endDateInput.setCustomValidity('');

                        if (start && end && new Date(start) >= new Date(end)) {
                            endDateInput.setCustomValidity('End date must be after start date.');
                        }
                    }

                    // Realtime + min auto
                    if (startDateInput && endDateInput) {
                        startDateInput.addEventListener('input', validateDates);
                        endDateInput.addEventListener('input', validateDates);

                        startDateInput.addEventListener('change', () => {
                            endDateInput.min = startDateInput.value;
                        });
                    }

                    // Submit
                    form.addEventListener('submit', function (e) {
                        validateDates();

                        if (!form.checkValidity()) {
                            e.preventDefault();
                            e.stopPropagation();
                        }

                        form.classList.add('was-validated');
                    }, false);
                });
            })();
        </script>

    </body>
</html>