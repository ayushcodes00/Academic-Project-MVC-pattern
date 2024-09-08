<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="Model.User.User"%>
<%@page import="Model.User.UserMessage"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Cart</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/header.css" />
    <style>
        .content {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f8f8f8;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .cart-header {
            text-align: center;
            margin-bottom: 20px;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
        }

        .table th, .table td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .table th {
            background-color: #333;
            color: #fff;
        }

        .btn {
            background-color: #333;
            color: #fff;
            padding: 8px 16px;
            border: none;
            cursor: pointer;
        }

        .btn:hover {
            background-color: #555;
        }

        .total-price {
            text-align: right;
            margin-top: 20px;
            font-size: 18px;
            font-weight: bold;
        }

        .checkout {
            text-align: right;
            margin-top: 20px;
        }

        .checkout input[type="submit"] {
            background-color: #333;
            color: #fff;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }

        .checkout input[type="submit"]:hover {
            background-color: #555;
        }
    </style>
</head>
<body>
    <%@include file="header.jsp"%>
    <section class="content">
        <div class="cart-header">
            <h1>My Cart</h1>
        </div>

        <%
        UserMessage msg = (UserMessage) session.getAttribute("Message");
        if (msg != null) {
        %>
        <h1><%=msg.getContent()%></h1>
        <%
            session.removeAttribute("Message");
        }
        %>

        <table class="table">
            <thead>
                <tr>
                    <th>Product Name</th>
                    <th>Product Category</th>
                    <th>Brand Name</th>
                    <th>Product Price</th>
                    <th>Stock Left</th>
                    <th>Cancel</th>
                </tr>
            </thead>
            <c:set var="totalPrice" value="0" />
            <tbody>
                <c:forEach var="product" items="${cart}">
                    <sql:setDataSource var="dbConnection" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3307/redstore" user="root" password="root123" />
                    <sql:query var="productInfo" dataSource="${dbConnection}">
                        SELECT productName, productCategory, productBrand, productPrice, stockLeft FROM product WHERE id = ${product};
                    </sql:query>
                    <c:forEach var="info" items="${productInfo.rows}">
                        <tr>
                            <td>${info.productName}</td>
                            <td>${info.productCategory}</td>
                            <td>${info.productBrand}</td>
                            <td>${info.productPrice}</td>
                            <td>${info.stockLeft}</td>
                            <td>
                                <form action="<%=request.getContextPath()%>/RemoveCart" method="post">
                                    <input type="hidden" name="id" value="${product}">
                                    <button type="submit" class="btn">Remove</button>
                                </form>
                            </td>
                        </tr>
                        <c:set var="totalPrice" value="${totalPrice + info.productPrice}" />
                    </c:forEach>
                </c:forEach>
            </tbody>
        </table>

        <div class="total-price">Total Price: $<c:out value="${totalPrice}" /></div>

        <form action="<%=request.getContextPath()%>/Order" method="post">
            <div class="checkout">
                <input type="submit" name="Order" value="Order" class="btn">
            </div>
        </form>
    </section>
</body>
</html>