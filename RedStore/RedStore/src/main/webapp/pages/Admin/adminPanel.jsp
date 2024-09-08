<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<%
    User admin = (User) session.getAttribute("User");
    if (admin == null || !admin.getEmail().equals("admin@gmail.com")) {
        response.sendRedirect("../login.jsp");
    }
%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/header.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f5f5;
            color: #333;
        }
        
        .content {
            padding: 50px;
        }
        
        .btn-container {
            display: flex;
            justify-content: center;
            margin-bottom: 30px;
        }
        
        .btn {
            padding: 12px 30px;
            margin: 0 10px;
            font-size: 16px;
            font-weight: 500;
            text-decoration: none;
            color: #fff;
            background-color: #007bff;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }
        
        .btn:hover {
            background-color: #0056b3;
        }
        
        .product-form-box {
            background-color: #fff;
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }
        
        .product-form-box h3 {
            font-size: 24px;
            margin-bottom: 20px;
        }
        
        .box {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-bottom: 15px;
        }
        
        .product-list-box {
            background-color: #fff;
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        
        .product-list {
            width: 100%;
            border-collapse: collapse;
        }
        
        .product-list th,
        .product-list td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ccc;
        }
        
        .product-list th {
            background-color: #f5f5f5;
            font-weight: 600;
        }
        
        .btn2 {
            padding: 8px 16px;
            font-size: 14px;
            font-weight: 500;
            text-decoration: none;
            color: #fff;
            background-color: #dc3545;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            border: none;
            cursor: pointer;
        }
        
        .btn2:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
    <%@include file="../header.jsp"%>

    <section class="content">


        <div class="product-form-box">
            <form name="product_form" action="<%=request.getContextPath()%>/ProductAddition" method="Post" enctype="multipart/form-data">
                <h3>Add Product</h3>
                <input type="text" placeholder="Enter product name" name="product_name" class="box">
                <input type="text" placeholder="Enter product category" name="product_category" class="box">
                <input type="text" placeholder="Enter brand name" name="brand_name" class="box">
                <input type="number" placeholder="Enter product price" name="product_price" class="box">
                <input type="number" placeholder="Enter stock amount" name="stockLeft" class="box">
                <input type="file" accept="image/png, image/jpeg, image/jpg" name="product_image" class="box">
                <input type="submit" class="btn" name="add_product" value="Add product">
            </form>
        </div>

        <div class="product-list-box">
            <sql:setDataSource var="dbConnection" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3307/redstore" user="root" password="root123" />
            <sql:query var="allProduct" dataSource="${dbConnection}">
                SELECT id, productName, productCategory, productBrand, productPrice, productImage, stockLeft FROM product;
            </sql:query>
            <table class="product-list">
                <thead>
                    <tr>
                        <th>Product Name</th>
                        <th>Product Category</th>
                        <th>Product Brand</th>
                        <th>Product Price</th>
                        <th>Stock Left</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="product" items="${allProduct.rows}">
                        <tr>
                            <td>${product.productName}</td>
                            <td>${product.productCategory}</td>
                            <td>${product.productBrand}</td>
                            <td>${product.productPrice}</td>
                            <td>${product.stockLeft}</td>
                            <td>
                                <form action="<%=request.getContextPath()%>/pages/Admin/editProduct.jsp" method="Get" style="display: inline;">
                                    <input type="hidden" name="id" value="${product.id}" />
                                    <button type="submit" class="btn">Edit</button>
                                </form>
                                <form action="<%=request.getContextPath()%>/DeleteProduct" method="post" style="display: inline;">
                                    <input type="hidden" name="id" value="${product.id}" />
                                    <button type="submit" class="btn2">Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </section>
            <div class="btn-container">
            <a href="orders.jsp" class="btn">View Orders</a>
        </div>
</body>
</html>