<%@ page language="java" contentType="text/html; charset=utf-8"
pageEncoding="utf-8"%>
<!DOCTYPE html>
<!--Including the core tag library-->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!--Including the formatting tag library-->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!--Including the SQL tag library-->
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="Model.User.User" %>

<%
User admin=(User)session.getAttribute("User");
if(admin==null || !admin.getEmail().equals("admin@gmail.com")){
response.sendRedirect("../login.jsp");
}
%>

<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Order Management</title>
<style>
    /* General Styles */
    body {
        background-color: #000;
        color: #fff;
        font-family: 'Mukta', sans-serif;
    }

    /* Header Styles */
    header {
        background-color: #333;
        padding: 20px;
        text-align: center;
    }

    /* Navigation Styles */
    nav {
        display: flex;
        justify-content: center;
        margin-bottom: 20px;
    }

    nav a {
        background-color: #444;
        color: #fff;
        padding: 10px 20px;
        text-decoration: none;
        margin: 0 10px;
        border-radius: 20px;
    }

    nav a:hover {
        background-color: #666;
    }

    /* Table Styles */
    table {
        width: 100%;
        border-collapse: collapse;
    }

    th, td {
        padding: 10px;
        text-align: left;
        border-bottom: 1px solid #333;
    }

    th {
        background-color: #444;
    }

    tr:hover {
        background-color: #222;
    }
</style>
</head>
<body>
<sql:setDataSource var="dbConnection" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3307/redstore" user="root" password="root123"/>

<sql:query var="allOrders" dataSource="${dbConnection}">
SELECT `OrderId`, `id`, `UserName`, `UserEmail`, `Date`
FROM `order`;
</sql:query>

<header>
    <h1>Order Management</h1>
</header>


<div class="main_content2" style="margin: 30px 70px 30px 170px; width: 90%;">
    <div class="order_list_box">
        <table>
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Product ID</th>
                    <th>Customer Name</th>
                    <th>Customer Email</th>
                    <th>Order Date</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="order" items="${allOrders.rows }">
                    <tr>
                        <td>${order.OrderId}</td>
                        <td>${order.id}</td>
                        <td>${order.UserName}</td>
                        <td>${order.UserEmail}</td>
                        <td>${order.Date}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>