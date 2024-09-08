<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="Model.User.UserMessage" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Create Account</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/header.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/formStyle.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
        }
        
        .content {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: calc(100vh - 200px);
        }
        
        .form_box {
            width: 400px;
            padding: 40px;
            background-color: #f5f5f5;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        
        .form_title {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 30px;
            text-align: center;
        }
        
        .input_field {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        
        .btn {
            width: 100%;
            padding: 12px;
            background-color: #4285f4;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 500;
        }
        
        .btn:hover {
            background-color: #3367d6;
        }
    </style>
</head>
<body>
    <%@include file = "header.jsp" %>
    
    <section class="content">
        <div class="form_box">
            <form name="registerForm" action="<%=request.getContextPath()%>/Register" method="post" enctype="multipart/form-data">
                <div class="form_title">Register an Account</div>
                
                <%
                UserMessage msg=(UserMessage)session.getAttribute("Message");
                if(msg!=null){
                %>
                    <h1><%=msg.getContent() %></h1>
                <%
                    session.removeAttribute("Message");
                }
                %>
                
                <label for="FirstName">First Name</label>
                <input type="text" name="FirstName" id="FirstName" class="input_field" required>
                <br>
                
                <label for="LastName">Last Name</label>
                <input type="text" name="LastName" id="LastName" class="input_field" required>
                <br>
                
                <label for="Contact">Contact Number</label>
                <input type="tel" name="Contact" id="Contact" class="input_field" required>
                <br>
                
                <label for="Email">Email Address</label>
                <input type="email" name="Email" id="Email" class="input_field" required>
                <br>
                
                <label for="Password">Create Password</label>
                <input type="password" name="Password" id="Password" class="input_field" required>
                <br>
                
                <label for="ProfilePicture">Upload Profile Picture</label>
                <input type="file" name="ProfilePicture" id="ProfilePicture" accept="image/*">
                <br>
                
                <button type="submit" class="btn" value="send">Register Now</button>
                
                <div style="margin-top: 20px; text-align: center;">
                    Already have an account? <a href="login.jsp">Login.</a>
                </div>
            </form>
        </div>
    </section>
    
</body>
</html>