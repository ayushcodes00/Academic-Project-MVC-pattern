<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
User user1=(User)session.getAttribute("User");
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>User Profile - Purchase History</title>
    <style>
        /* Reset styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Body styles */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
        }

        /* Content section styles */
        .content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px;
            background-color: #ffffff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
        }

        /* Navigation panel styles */
        .panel_nav {
            display: flex;
            justify-content: center;
            margin-bottom: 40px;
        }

        .panel_nav .btn {
            background-color: #333;
            color: #ffffff;
            padding: 12px 24px;
            text-decoration: none;
            border-radius: 5px;
            margin: 0 10px;
            transition: background-color 0.3s ease;
            font-size: 16px;
        }

        .panel_nav .btn:hover {
            background-color: #555;
        }

        /* Order history box styles */
        .order_history_box {
            max-width: 800px;
            margin: 0 auto;
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .order_list {
            width: 100%;
            border-collapse: collapse;
        }

        .order_list th, .order_list td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .order_list th {
            background-color: #333;
            color: #ffffff;
        }
    </style>
</head>
<body>
    <%@include file="header.jsp"%>
    <%
    String email=user1.getEmail();
    String query = "SELECT OrderId, UserName, id, Date FROM `Order` Where UserEmail='"+email+"'";
    %>
    <sql:setDataSource var="dbConnection" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3307/redstore" user="root" password="root123"/>
    <sql:query var="allOrders" dataSource="${dbConnection}">
        <%=query%>
    </sql:query>

    <section class="content">


        <div class="order_history_box">
            <table class="order_list">
                <thead>
                    <tr>
                        <th>Order Id</th>
                        <th>User Name</th>
                        <th>Product Id</th>
                        <th>Order Date</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="order" items="${allOrders.rows}">
                        <tr>
                            <td>${order.OrderId}</td>
                            <td>${order.UserName}</td>
                            <td>${order.id}</td>
                            <td>${order.Date}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </section>
</body>
</html>