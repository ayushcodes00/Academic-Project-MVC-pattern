<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
User admin=(User)session.getAttribute("User");
if(!admin.getEmail().equals("admin@gmail.com")){
    response.sendRedirect("../login.jsp");
}
%>
<%
int id = Integer.parseInt(request.getParameter("id"));
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Edit Product</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/header.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }

        .content {
            max-width: 800px;
            margin: 0 auto;
            padding: 40px;
            background-color: #ffffff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
        }

        .product_form_box {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .product_form_box h3 {
            text-align: center;
            margin-bottom: 20px;
        }

        .box {
            width: 100%;
            padding: 12px 20px;
            margin: 8px 0;
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .btn {
            background-color: #333;
            color: #ffffff;
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 10px;
        }

        .btn3 {
            background-color: #ccc;
            color: #333;
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            margin-left: 10px;
        }

        .btn:hover, .btn3:hover {
            opacity: 0.8;
        }
    </style>
</head>
<body>
    <%@include file="../header.jsp"%>

    <section class="content">
        <div class="main_content">
            <div class="product_form_box">
                <form name="product_form" action="<%=request.getContextPath()%>/EditProduct" method="Post" enctype="multipart/form-data">
                    <h3>Edit Product Details</h3>
                    <input type="text" placeholder="Enter new product name" name="product_name" class="box">
                    <input type="text" placeholder="Enter new product category" name="product_category" class="box">
                    <input type="text" placeholder="Enter new brand name" name="brand_name" class="box">
                    <input type="number" placeholder="Enter new price" name="product_price" class="box">
                    <input type="text" placeholder="Enter stock left" name="stockLeft" class="box">
                    <input type="file" accept="image/png, image/jpeg, image/jpg" name="product_image" class="box">
                    <input type="hidden" name="id" value="<%=id%>"/>
                    <input type="submit" class="btn" name="edit_product" value="Edit Product">
                    <a href="adminPanel.jsp" class="btn3">Return</a>
                </form>
            </div>
        </div>
    </section>
</body>
</html>