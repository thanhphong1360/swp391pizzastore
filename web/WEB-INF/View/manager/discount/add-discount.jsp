<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="content" role="main" class="main">
    <div class="content container-fluid">
        <div class="page-header">
            <div class="row align-items-center">
                <div class="col-sm mb-2 mb-sm-0">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb breadcrumb-no-gutter">
                            <li class="breadcrumb-item"><a class="breadcrumb-link" href="${pageContext.request.contextPath}/manager/discount/list">Discounts</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Add Discount</li>
                        </ol>
                    </nav>
                    <h1 class="page-header-title">Create New Discount</h1>
                </div>
            </div>
        </div>
        <form method="POST" action="${pageContext.request.contextPath}/AddDiscountServlet" class="needs-validation" novalidate>
            <div class="form-group">
                <label>Code:</label>
                <input type="text" class="form-control" name="code" required>
                <div class="invalid-feedback">Please provide a valid code.</div>
            </div>
            <div class="form-group">
                <label>Description:</label>
                <textarea class="form-control" name="description" rows="3" required></textarea>
                <div class="invalid-feedback">Please provide a description.</div>
            </div>
            <div class="form-group">
                <label>Type:</label>
                <input type="text" class="form-control" name="type" required>
                <div class="invalid-feedback">Please provide a valid type.</div>
            </div>
            <div class="form-group">
                <label>Value:</label>
                <input type="number" step="0.01" class="form-control" name="value" required>
                <div class="invalid-feedback">Please provide a valid value.</div>
            </div>
            <div class="form-group">
                <label>Start Date:</label>
                <input type="date" class="form-control" name="start_date" required>
                <div class="invalid-feedback">Please provide a valid date.</div>
            </div>
            <div class="form-group">
                <label>End Date:</label>
                <input type="date" class="form-control" name="end_date" required>
                <div class="invalid-feedback">Please provide a valid date.</div>
            </div>
            <div class="form-group">
                <label>Min Invoice Price:</label>
                <input type="number" step="0.01" class="form-control" name="min_invoice_price" required>
                <div class="invalid-feedback">Please provide a valid price.</div>
            </div>
            <div class="form-group">
                <label>Max Discount Amount:</label>
                <input type="number" step="0.01" class="form-control" name="max_discount_amount" required>
                <div class="invalid-feedback">Please provide a valid amount.</div>
            </div>
            <div class="form-group">
                <label>Status:</label>
                <select class="form-control" name="status" required>
                    <option value="true">Active</option>
                    <option value="false">Inactive</option>
                </select>
                <div class="invalid-feedback">Please select a status.</div>
            </div>
            <button type="submit" class="btn btn-primary">Create Discount</button>
        </form>
    </div>
</main>