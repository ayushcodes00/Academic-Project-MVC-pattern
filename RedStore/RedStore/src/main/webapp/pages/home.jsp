<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="Model.User.User" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Home</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/header.css" />
    <style>
        .content {
            margin: 0;
            padding: 40px 0 100px;
            background-color: #f0f0f0;
            flex-grow: 1;
        }

        .product_flexbox {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 30px;
            padding: 30px;
        }

        .product_container {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: transform 0.3s ease;
            width: 300px;
        }

        .product_container:hover {
            transform: translateY(-5px);
        }

        .image_container {
            position: relative;
            overflow: hidden;
            height: 200px;
        }

        .image_link {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .product_container:hover .image_link {
            transform: scale(1.05);
        }

        .product_name {
            font-size: 20px;
            font-weight: 600;
            margin: 20px;
            text-align: center;
            color: #333333;
        }

        .btn {
            display: block;
            margin: 20px auto;
            padding: 10px 20px;
            font-size: 16px;
            font-weight: 500;
            text-align: center;
            color: #ffffff;
            background-color: #1c1c1c;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #333333;
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp"%>

    <%
    String sort = request.getParameter("sort");
    String orderBy = "id"; // Default sorting order

    String query = "SELECT id, productName, productCategory, productBrand, productPrice, productImage, stockLeft FROM product ORDER BY ";
    if (sort != null && sort.equalsIgnoreCase("productPrice DESC")) {
        query += "productPrice DESC";
    } else {
        query += "productPrice ASC";
    }
    %>

    <section class="content">
        <sql:setDataSource var="dbConnection" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3307/redstore" user="root" password="root123"/>
        <sql:query var="allProduct" dataSource="${dbConnection}">
            <%= query %>
        </sql:query>

        <div class="product_flexbox">
            <c:forEach var="product" items="${allProduct.rows}">
                <form action="<%=request.getContextPath()%>/mycart" method="Post">
                    <div class="product_container">
                        <div class="image_container">
                            <img src="<c:url value='/images/prodimage/${product.productImage}'/>" class="image_link">
                        </div>
                        <p class="product_name">${product.productName}</p>
                        <input type="hidden" name="id" value="${product.id}">
                        <input type="submit" class="btn" name="add_product" value="Add to Cart">
                    </div>
                </form>
            </c:forEach>
        </div>
    </section>
</body>
</html>