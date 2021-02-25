<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet"
  href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
  src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
  src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
  src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/a076d05399.js"></script>
<link rel="stylesheet" type="text/css" href="${root }/resources/css/font.css">

<style>
<%-- 적용 X
#navbarSupportedContent ul {
	padding-left:0px;
}

#navbarSupportedContent li  {
	display:inline;
	border-left: 1px solide #c0c0c0;
	padding:0px 10px 0px 10px;
	margin:0px 50px 0px 50px;
	}
--%>
</style>

<title>산산산</title>
</head>
<body>
<m:topNav />
	<div id="carouselExampleSlidesOnly" class="carousel slide" data-ride="carousel">
	  <div class="carousel-inner">
	    <div class="carousel-item active">
			<img src="<spring:url value='/resources/img/main/mountain_main2.jpg' />" class="img-fluid d-block center-block" width="auto" height="auto" alt="메인배너">
	    </div>
	  </div>
	</div>
</body>
</html>