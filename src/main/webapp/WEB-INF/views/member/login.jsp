<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags"%>
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

<script type="text/javascript" src="${root }/resources/js/member/login.js"></script>

<title>산산산</title>
</head>
<body>

<m:topNav />

<div class="container-sm">
	<div class="row">
		<div class="col-12 col-sm-6 offset-sm-3">
			<h3 class="text-center pt-5 pb-4">로그인</h3>
			<form name="loginForm">
				<c:if test="${notFoundUser }">
				<small class="form-text" style="color: tomato" >
					일정 시간이 지나 로그아웃 되었습니다. 다시 로그인을 해주세요.
				</small>
				</c:if>
			
				<div class="form-group row">
					<label for="inputId" class="col-sm-2 col-form-label">아이디</label>
					<div class="col-sm-10">
						<input type="text" name="id" class="form-control" id="inputId" >
						<small class="form-text" style="color: tomato" id="idNull" >
							아이디를 입력해주세요.
						</small>
					</div>
				</div>
				
				<div class="form-group row">
					<label for="inputPw" class="col-sm-2 col-form-label">비밀번호</label>
					<div class="col-sm-10">
						<input type="password" name="password" class="form-control" id="inputPw" >
						<small class="form-text" style="color: tomato" id="pwNull" >
							비밀번호를 입력해주세요.
						</small>
					</div>
				</div>
				<button class="btn btn-success" id="loginButton" >로그인</button>
			</form>
		</div>
	</div>
</div>	
</body>
</html>