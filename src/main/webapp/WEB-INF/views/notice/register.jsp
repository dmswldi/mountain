<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="${root }/resources/js/notice/register.js"></script>
<link rel="stylesheet" type="text/css" href="${root }/resources/css/font.css">
<title>산산산</title>
</head>
<body>
<m:topNav></m:topNav>

<div class="container-sm my-5">
	<div class="row">
		<div class="col-12 col-md-6 offset-md-3">
			<h3 class="text-center">새 공지/이벤트</h3>
			<br>
			<form id="registerForm" method="post">
			  <div class="form-group">
			    <label for="category">분류</label>
			    <select class="form-control" name="category" id="category">
			      <c:if test="${notice.category eq 'notice' }">
			      	<c:set var="n" value="selected" />
			      </c:if>
			      <c:if test="${notice.category eq 'event' }">
			      	<c:set var="e" value="selected" />
			      </c:if>
			      <option value="notice" ${n } selected>공지</option>
			      <option value="event" ${e }>이벤트</option>
			    </select>
			  </div>
			  <div class="form-group">
			    <input type="hidden" class="form-control" name="member_no" value="${authUser.no }" readonly>
			  </div>
			  <div class="form-group">
			    <label for="title">제목</label>
			    <small class="text-danger" id="titleNull">제목을 입력해주세요.</small>
			    <input type="text" class="form-control" name="title" id="title" value="${notice.title }">
			  </div>
			  <div class="form-group">
			    <label for="content">내용</label>
			    <small class="text-danger" id="contentNull">내용을 입력해주세요.</small>
			    <textarea class="form-control" name="content" id="content" rows="10">${notice.content }</textarea>
			  </div>
			  <div class="form-group form-check">
			    <input type="checkbox" class="form-check-input" id="replyCheck" value="${notice.reply }">
			    <label class="form-check-label" for="replyCheck">댓글 금지</label>
			  </div>
			  <input type="hidden" name="reply" id="reply" value="1">
			  <input type="submit" class="btn btn-success float-right" id="submitBtn" value="등록">
			</form>	
			<a href="javascript:history.back()" class="btn btn-danger float-right mr-1">취소</a>
		</div>
	</div>
</div>
</body>
</html>