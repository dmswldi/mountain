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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> <!-- 주소 api -->
<script type="text/javascript" src="${root }/resources/js/member/myModify.js"></script>
<link rel="stylesheet" type="text/css" href="${root }/resources/css/font.css">

<title>산산산</title>
</head>
<body>

<m:topNav />

<div class="container-sm">
	<div class="row">
		<div class="col-12 col-sm-6 offset-sm-3">
			<h3 class="text-center pt-5 pb-4">정보 수정</h3>
			
			<form method="post" action="${root }/member/myModify" id="modifyForm1">
				<div class="form-group row">
					<label for="staticId" class="col-sm-2 col-form-label">아이디</label>
					<div class="col-sm-10">
						<input type="text" readonly name="id" class="form-control-plaintext" id="staticId" value="${sessionScope.authUser.id }">
						<small class="form-text" style="color: gray" >
							아이디는 수정할 수 없습니다.
						</small>
					</div>
				</div>
		  
				<div class="form-group row">
					<label for="staticName" class="col-sm-2 col-form-label">이름</label>
					<div class="col-sm-10">
						<input type="text" readonly name="name" class="form-control-plaintext" id="staticName" value="${sessionScope.authUser.name }">
						<small class="form-text" style="color: gray" >
							이름은 수정할 수 없습니다.
						</small>
					</div>
				</div>

				<div class="form-group row">
					<label for="staticPw" class="col-sm-2 col-form-label">변경 비밀번호</label>
					<div class="col-sm-10">
						<input type="password" name="password" class="form-control" id="staticPw" pattern="([a-zA-Z]+\d{1}\w*)|(\d+[a-zA-Z]{1}\w*)" value="${sessionScope.authUser.password }" required>
						<small class="form-text" style="color: gray" id="pwPattern">
							영문 대소문자, 숫자를 조합하여 입력하세요. (2글자 이상)
						</small>
					</div>
				</div>
				<div class="form-group row">
					<label for="pwConfirm" class="col-sm-2 col-form-label">비밀번호 확인</label>
					<div class="col-sm-10">
						<input type="password" name="pwConfirm" class="form-control" id="pwConfirm" required>
						<c:if test="${errors.pwNotMatch }" >
							<small class="form-text" style="color: tomato">
								비밀번호가 일치하지 않습니다.
							</small>
						</c:if>
					</div>
				</div>  

				<div class="form-group row">
					<label for="inputNickname" class="col-sm-2 col-form-label">닉네임</label>
					<div class="col-sm-10">
						<div class="input-group">
							<input type="text" name="nickname" class="form-control" id="inputNickname" value="${sessionScope.authUser.nickname }" required>
							<span class="input-group-btn">
								<button type="button" class="btn btn-success" id="nicknameDupCheck" disabled>닉네임 중복 확인</button>
							</span>
						</div>
						
						<input type="hidden" id="checkedNn" value="">
						
						<!-- 닉네임 중복검사 -->
						<small class="form-text" style="color: tomato" id="nicknameNull">
							닉네임을 입력해주세요.
						</small>
						<small class="form-text" style="color: DodgerBlue" id="nicknameOk" >
							사용 가능한 닉네임입니다.
						</small>
						<small class="form-text" style="color: tomato" id="nicknameDup" >
							중복된 닉네임입니다.
						</small>
						
					</div>
				</div>

				<div class="form-group row">
				<label for="staticEmail" class="col-sm-2 col-form-label">이메일</label>
					<div class="col-sm-10" id="staticEmail">
						<input type="text" id="emailFront" value="${emailDTO.emailFront }" class="form-control d-inline" style="width:30%" placeholder="이메일 입력" required > 
						<span>@</span>
						<input id="textEmail" value="${emailDTO.emailSelect }" class="form-control d-inline" style="width:30%" placeholder="이메일 선택" required> 
						<select id="email-select1">
							<option value="disabled" id="selected">E-Mail 선택</option>
							<option value="naver.com" id="naver.com">naver.com</option>
							<option value="hanmail.net" id="hanmail.net">hanmail.net</option>
							<option value="gmail.com" id="gmail.com">gmail.com</option>
							<option value="nate.com" id="nate.com">nate.com</option>
							<option value="directly" id="textEmail">직접 입력하기</option>
						</select>
						<small class="form-text" style="color: gray" id="emailPattern">
							이메일 형식에 알맞게 입력해주세요. (예 : kim@mounteam.com)
						</small>
						<input type="hidden" name="email" id="email-input" value="${sessionScope.authUser.email }"/>
					</div>
				</div>
						  
				<div class="form-group row">
					<label for="loc-input" class="col-sm-2 col-form-label">주소</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="loc-input" name="loc" value="${authUser.loc }" >
						<!-- //주소 api input 태그	 -->	 
						<input type="text" id="sample3_postcode" placeholder="우편번호" value="${locDiv.postcode }" >
						<input type="button" onclick="sample3_execDaumPostcode()" value="우편번호 찾기"><br>
						<input type="text" id="sample3_address" placeholder="주소" value="${locDiv.address }" ><br>
						<input type="text" id="sample3_detailAddress" placeholder="상세주소" value="${locDiv.detailAddress }">
						<input type="text" id="sample3_extraAddress" placeholder="참고항목" value="${locDiv.extraAddress }">
<%-- 						<c:if test="${errors.memberLoc }">
							<small class="form-text" style="color: tomato">
								주소를 입력해주세요.
							</small>
						</c:if> --%>
						<c:if test="${errors.memberLoc2 }">
							<small class="form-text" style="color: tomato" id="locNullError">
								주소를 입력해주세요.
							</small>
						</c:if>
						
						<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 0;position:relative">
							<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
						</div>
					</div>
				</div>
				<button type="submit" class="btn btn-success" id="modify" >수정</button>
			</form>
		</div>
	</div>
</div>
<script type="text/javascript" src="${root }/resources/js/member/addressAPI.js"></script> <!-- 주소 api -->
</body>
</html>