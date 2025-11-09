<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Discount" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<main id="content" role="main" class="main">
    <div class="content container-fluid">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1 class="page-header-title">Discounts <span class="badge badge-soft-dark ml-2"></span></h1>
            <a class="btn btn-primary" href="${pageContext.request.contextPath}/manager/discount/add-discount">Add Discount</a>
        </div>
        <div class="card">
            <div class="table-responsive datatable-custom">
                <table id="datatable" class="table table-hover table-thead-bordered table-nowrap table-align-middle card-table">
                    <thead>
                        <tr>
                            <th scope="col">ID</th>
                            <th>Discount Code</th>
                            <th>Description</th>
                            <th>Type</th>
                            <th>Value</th>
                            <th>Start Date</th>
                            <th>End Date</th>
                            <th>Min Invoice Price</th>
                            <th>Max Discount Amount</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="discount" items="${discounts}">
                            <tr>
                                <td>${discount.discountId}</td>
                                <td>${discount.code}</td>
                                <td>${discount.description}</td>
                                <td>${discount.type}</td>
                                <td>${discount.value}</td>
                                <td>${discount.startDate}</td>
                                <td>${discount.endDate}</td>
                                <td><fmt:formatNumber value="${discount.minInvoicePrice}" pattern="#,###" /> VND</td>
                                <td><fmt:formatNumber value="${discount.maxDiscountAmount}" pattern="#,###" /> VND</td>
                                <td>${discount.status ? 'Active' : 'Inactive'}</td>
                                <td>
                                    <div class="btn-group" role="group">
                                        <form action="${pageContext.request.contextPath}/GetDiscountByIdServlet" method="GET" style="display: inline;">
                                            <input type="hidden" name="id" value="${discount.discountId}">
                                            <input type="hidden" name="action" value="view">
                                            <button type="submit" class="btn btn-sm btn-dark" style="margin-right: 5px;">
                                                <i class="tio-eye"></i> View
                                            </button>
                                        </form>
                                        </form>
                                        <form action="${pageContext.request.contextPath}/GetDiscountByIdServlet" method="GET" style="display: inline;">
                                            <input type="hidden" name="id" value="${discount.discountId}">
                                            <input type="hidden" name="action" value="edit">
                                            <button type="submit" class="btn btn-sm btn-warning" style="margin-right: 5px;">
                                                <i class="tio-edit"></i> Edit
                                            </button>
                                        </form>
                                        <form action="${pageContext.request.contextPath}/DeleteDiscountServlet" method="POST" style="display: inline;" onsubmit="return confirm('Bạn chắc chắn muốn xóa mã giảm giá này?');">
                                            <input type="hidden" name="id" value="${discount.discountId}">
                                            <button type="submit" class="btn btn-sm btn-danger">
                                                <i class="tio-delete"></i> Delete
                                            </button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</main>