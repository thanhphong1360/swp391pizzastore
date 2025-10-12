


<main id="content" role="main" class="main">

    <div class="content container-fluid">

        <div class="page-header">
            <div class="row align-items-center">
                <div class="col-sm mb-2 mb-sm-0">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb breadcrumb-no-gutter">
                            <li class="breadcrumb-item"><a class="breadcrumb-link" href="${pageContext.request.contextPath}/products">Discounts</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Discount Detail</li>
                        </ol>
                    </nav>
                    <h1 class="page-header-title text-center blinking">Discount Detail</h1>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-8 offset-md-2">
                <div class="product-details">
                    <div class="container mt-4">
                        <h1>Edit Discount</h1>
                        <form method="POST" action="${pageContext.request.contextPath}/EditDiscountServlet" enctype="multipart/form-data" class="needs-validation" novalidate>
                            <input type="hidden" name="productID" value="${discount.discountID}">
                            <div class="form-group">
                                <label>Code:</label>
                                <input type="text" class="form-control" name="code" value="${discount.code}" required>
                                <div class="invalid-feedback">
                                    Please provide a valid code.
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Description:</label>
                                <textarea class="form-control" name="description" rows="3">${discount.description}</textarea>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label>Type: </label>
                                    <input type="number" class="form-control" name="type" required>
                                    <div class="invalid-feedback">
                                        Please provide a valid type.
                                    </div>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label>Value: </label>
                                    <input type="number" class="form-control" name="value" required>
                                    <div class="invalid-feedback">
                                        Please provide a valid value.
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label>Start Date:</label>
                                <input type="number" class="form-control" name="start_date" required>
                                <div class="invalid-feedback">
                                    Please provide a valid date.
                                </div>
                            </div>

                            <div class="form-group">
                                <label>End Date:</label>
                                <input type="number" class="form-control" name="end_date" required>
                                <div class="invalid-feedback">
                                    Please provide a valid date.
                                </div>
                            </div>

                            <div class="form-group">
                                <label>Min Invoice Price:</label>
                                <input type="number" class="form-control" name="min_invoice_price" required>
                                <div class="invalid-feedback">
                                    Please provide a valid price.
                                </div>
                            </div>

                            <div class="form-group">
                                <label>Max Discount Amount:</label>
                                <input type="number" class="form-control" name="max_discount_amount" required>
                                <div class="invalid-feedback">
                                    Please provide a valid amount.
                                </div>
                            </div>

                            <div class="form-group">
                                <label>Status:</label>
                                <select class="form-control" name="status" required>
                                    <option value="true">Active</option>
                                    <option value="false">Inactive</option>
                                </select>
                                <div class="invalid-feedback">
                                    Please select a valid status.
                                </div>
                            </div>
                            <button type="submit" class="btn btn-primary">Update</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
</main>