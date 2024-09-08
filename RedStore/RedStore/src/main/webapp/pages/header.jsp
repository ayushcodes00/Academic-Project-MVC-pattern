<%@ page language="java" contentType="text/html; charset=utf-8"
pageEncoding="utf-8"%>
<%@page import="Model.User.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Navigation Bar</title>
    <style>
        /* Import the Roboto font from Google Fonts */
        @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap');

        /* Reset default styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Apply the Roboto font to the navigation bar */
        .navbar ul {
            font-family: 'Roboto', sans-serif;
            list-style-type: none;
            display: flex;
            justify-content: center;
            background-color: #333;
            padding: 10px;
        }

        .navbar ul li {
            margin: 0 10px;
        }

        .navbar ul li a {
            color: #fff;
            text-decoration: none;
            padding: 5px 10px;
        }

        .navbar ul li a:hover {
            background-color: #555;
        }
    </style>
</head>
<body>
    <%
    User user = (User) session.getAttribute("User");
    %>

    <!--This is the section of the webpage which contains the navigation bar-->
    <section class="navigation_bar">
        <div class="navbar">
            <ul>
                <li class="menu"><a href="<%=request.getContextPath()%>/pages/home.jsp">Home</a></li>
                <li class="menu"><a href="<%=request.getContextPath()%>/pages/cart.jsp">Cart</a></li>
                <%
                if (user != null) {
                    if (user.getFirstName().equals("Admin")) {
                        out.print("<li class='menu'><a href='" + request.getContextPath() + "/pages/Admin/adminPanel.jsp'>" + user.getFirstName() + "</a></li>");
                    } else {
                        out.print("<li class='menu'><a href='" + request.getContextPath() + "/pages/userprofile.jsp'>" + user.getFirstName() + "</a></li>");
                    }
                } else {
                    out.print("<li class='menu'><a href='" + request.getContextPath() + "/pages/userlogin.jsp'>" + "Profile" + "</a></li>");
                }
                %>
                <%
                if (user != null) {
                    out.print("<li class='menu'><a href='" + request.getContextPath() + "/Logout'>" + "Logout" + "</a></li>");
                } else {
                    out.print("<li class='menu'><a href='" + request.getContextPath() + "/pages/userlogin.jsp'>" + "Login" + "</a></li>");
                }
                %>
            </ul>
        </div>
    </section>
</body>
</html>