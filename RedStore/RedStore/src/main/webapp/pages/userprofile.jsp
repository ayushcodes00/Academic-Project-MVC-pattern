<%@ page language="java" contentType="text/html; charset=utf-8"
pageEncoding="utf-8"%>
<!DOCTYPE html>
<%
User user1=(User)session.getAttribute("User");
if(user1==null){
response.sendRedirect("login.jsp");
}
%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>User Profile - Profile Details</title>
<style>
    /* Reset styles */
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    /* Body styles */
    body {
        font-family: 'Mukta', sans-serif;
        background-color: #f5f5f5;
    }

    /* Content section styles */
    .content {
        max-width: 800px;
        margin: 0 auto;
        padding: 20px;
        background-color: #ffffff;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        border-radius: 5px;
    }

    /* Navigation panel styles */
    .panel_nav {
        display: flex;
        justify-content: center;
        margin-bottom: 20px;
    }

    .panel_nav .btn {
        background-color: #333;
        color: #ffffff;
        padding: 10px 20px;
        text-decoration: none;
        border-radius: 5px;
        margin: 0 10px;
        transition: background-color 0.3s ease;
    }

    .panel_nav .btn:hover {
        background-color: #555;
    }

    /* Profile form box styles */
    .profile_form_box {
        max-width: 500px;
        margin: 0 auto;
        padding: 20px;
        background-color: #f5f5f5;
        border-radius: 5px;
    }

    .profile_form_box h3 {
        margin-bottom: 10px;
    }

    .pfp_container {
        display: flex;
        justify-content: center;
        margin-bottom: 20px;
    }

    .pfp_container img {
        max-width: 150px;
        max-height: 150px;
        border-radius: 50%;
    }

    .box {
        display: block;
        width: 100%;
        padding: 10px;
        margin-bottom: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-family: inherit;
    }

    .btn {
        background-color: #333;
        color: #ffffff;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .btn:hover {
        background-color: #555;
    }
</style>
</head>
<body>
<%@include file = "header.jsp" %>

<!--This is the section of the webpage that contains all of the main content-->
<section class="content">


    <div class="main_content">
        <div class="profile_form_box">
            <form name="profile_form" action="<%=request.getContextPath() %>/editProfile" method="post" enctype="multipart/form-data">
                <h3>Edit Profile details</h3>
                <div class="pfp_container">
                    <img src="<%=request.getContextPath()%>/images/profileimage/<%=user1.getProfilePicture()%>" alt="Profile Picture">
                </div>
                <h3>Name : <%=user1.getFirstName() %></h3>
                <h3>Contact: <%=user1.getContact() %></h3>
                <br>
                <label for="Profile_pic">Update Details</label>
                <input type="text" placeholder="Enter new Name" name="FirstName" class="box">
                <input type="text" placeholder="Enter new contact" name="Contact" class="box">
                <input type="password" placeholder="Create new password" name="Password" class="box">
                <label for="Profile_pic">Update Profile Picture</label>
                <input type="file" id="profile_pic" accept="image/png, image/jpeg, image/jpg" name="ProfilePicture" class="box">
                <input type="submit" class="btn" name="save_changes" value="Save Changes">
            </form>
        </div>
    </div>
        <div class="panel_nav">
        <a href="orderHistory.jsp" class="btn" id="history_btn">Purchase History</a>
    </div>
</section>
</body>
</html>