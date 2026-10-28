
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>LOGIN REGISTER PAGE</title>

<style >

body{

background-image:url("https://static.vecteezy.com/system/resources/thumbnails/048/587/373/small/modern-bank-building-entrance-free-photo.jpeg");

background-repeat:no-repeat;

background-size:cover;

margin:0;

padding:0;

display:flex;

justify-content:center;

align-items:center;

height:100vh;

}

a{

text-decoration:none;

color:white;

padding:10px;

border-radius:10px;

background-color:black;

margin:5px;

display:inline-block;

}

.center-box{

text-align:center;

}
.home-btn {
    background: linear-gradient(135deg, #2695c7, #1876a7);
    color: white;
    text-decoration: none;
    padding: 12px 25px;
    border-radius: 12px;
    margin: 20px auto 0;
    display: inline-block;
    font-size: 15px;
    font-weight: bold;
    letter-spacing: 1px;
    border: 2px solid white;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
    transition: all 0.3s ease;
}

.home-btn:hover {
    background: linear-gradient(135deg, #1876a7, #105b82);
    transform: translateY(-3px);
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.4);
}

</style>

</head>

<body>

<div class="center-box">

<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRykA2km8SJYV7KxBfIvh0Ixvo3VNiUtzgY4MvHHufzg&s=10"
height="300px"
width="300px"
alt="NO IMAGE"/>

<br/><br/>

<a href="Register.jsp">REGISTER</a>

<a href="Login.jsp">LOGIN</a>

 <div class="divider"></div>

    <a href="FrontPage.jsp" class="home-btn">
        &#8592; BACK TO HOME
    </a>

</div>

</body>

</html>
