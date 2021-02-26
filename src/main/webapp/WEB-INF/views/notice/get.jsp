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
<script src="https://use.fontawesome.com/releases/v5.15.2/js/all.js" data-auto-replace-svg="nest"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
var result = '${result }';
var logined = ('${authUser}' != 0);// T, F
var isManager = ('${authUser.manager}' == 1);// T, F
var canReply = ('${notice.reply}' == 1);// T, F

var root = '${root}';
var no = '${notice.no }';
var user_no = '${authUser.no}';
</script>
<script src="${root }/resources/js/notice/get.js"></script>
<link rel="stylesheet" type="text/css" href="${root }/resources/css/font.css">
<link rel="stylesheet" type="text/css" href="${root }/resources/css/notice/get.css">
<title>산산산</title>
</head>
<body>
<m:topNav></m:topNav>

<div class="container-sm my-5">
	<div class="row">
		<div class="col-12 col-md-6 offset-md-3">
<!-- 		<div class="col-12 col-md-8 offset-md-2"> -->
			<h3 class="text-center">공지/이벤트</h3>
			<br>
			<form id="removeForm" action="${root }/notice/remove?no=${notice.no}" method="post">
			  <div>
			  	<fmt:formatDate var="regdate" value="${notice.regdate }" pattern="yyyy-MM-dd HH:mm" />
			  	<span>No. ${notice.no }</span>
			  	<span class="float-right">작성일시: ${regdate }</span>
			  </div>
			  <br>
			  <div class="form-group">
			    <label for="category">분류</label>
			    <select class="form-control" name="category" id="category" disabled>
			      <c:if test="${notice.category eq 'notice' }">
			      	<c:set var="n" value="selected" />
			      </c:if>
			      <c:if test="${notice.category eq 'event' }">
			      	<c:set var="e" value="selected" />
			      </c:if>
			      <option value="notice" ${n } selected>공지</option> <%-- ? 잘 되는지 --%>
			      <option value="event" ${e }>이벤트</option>
			    </select>
			  </div>
			  <div class="form-group">
			    <label for="writer">작성자</label>
			    <input type="text" class="form-control" name="writer" id="writer" value="${notice.nickname }" readonly>
			  </div>
			  <div class="form-group">
			    <label for="title">제목</label>
			    <input type="text" class="form-control" name="title" id="title" value="${notice.title }" readonly>
			  </div>
			  <div class="form-group">
			    <label for="content">내용</label>
			    <textarea class="form-control" name="content" id="content" rows="10" readonly>${notice.content }</textarea>
			  </div>
			  <button id="removeBtn" class="btn btn-danger float-right">삭제</button>
			</form>	
			
			<input type="hidden" id="keyword" value="${cri.keyword }" />
			<input type="hidden" id="curPage" value="${cri.curPage }" />
			<input type="hidden" id="amount" value="${cri.amount }" />			
			
			<c:url var="modUrl" value="/notice/modify">
				<c:param name="no" value="${notice.no }"></c:param>
				<c:param name="category" value="${cri.category }"></c:param>
				<c:param name="keyword" value="${cri.keyword }"></c:param>
				<c:param name="curPage" value="${cri.curPage }"></c:param>
				<c:param name="amount" value="${cri.amount }"></c:param>
			</c:url>
			<a id="modifyBtn" href="${modUrl }" class="btn btn-primary float-right mr-1">수정</a>
			
			<c:url var="listUrl" value="/notice/list">
				<c:param name="no" value="${notice.no }"></c:param>
				<c:param name="category" value="${cri.category }"></c:param>
				<c:param name="keyword" value="${cri.keyword }"></c:param>
				<c:param name="curPage" value="${cri.curPage }"></c:param>
				<c:param name="amount" value="${cri.amount }"></c:param>
			</c:url>
			<a href="${listUrl }" class="btn btn-success">목록</a>
		</div>
	</div>
	
	<hr>
	<%-- new Reply --%>
	<div class="row m-3">
		<div class="col-md-8 offset-md-2">
			<form id="replyForm" action="${root }/nreplies/new" method="post">
			  <div class="d-flex justify-content-between align-items-center">
				<label for="reply">${authUser.nickname }</label>
				<input type="text" class="form-control mx-1" name="reply" id="reply">
				<input type="hidden" name="notice_no" id="notice_no" value="${notice.no }">
				<input type="hidden" name="member_no" id="member_no" value="${authUser.no }">
				<button class="btn btn-light float-right" id="newReplyBtn">등록</button>
			  </div>
			</form>
		</div>
	</div>
	<%-- Reply List --%>
	<div class="row m-3" id="replyList">
		<div class="col-md-8 offset-md-2">
			<table class="table">
			  <tbody id="replyTable">
			  
			  <!--
			 
			    <tr>
			      <td>
			      	<div>닉네임<small class="float-right">5일 전</small></div>
			      	<div>댓글 ㅇ어쩌고 저쩌고</div>
			      	<div> <%-- 대댓글존 --%>
			      		<hr>
		      			<div><i class="fas fa-reply mr-2" data-fa-transform="rotate-180" style="color:lightgrey"></i>미요<small class="float-right">5일 전</small></div>
		      			<div>대댓글임</div>
			      		<hr>
			      		<div><i class="fas fa-reply" data-fa-transform="rotate-180" style="color:lightgrey"></i>하이<small class="float-right">4일 전</small></div>
		      			<div>나도임</div>
			      	</div>
			      </td>
			    </tr>
			    
			    <tr>
			      <td>
			      	<div>닉네임<small class="float-right">3시간 전</small></div>
			      	<div>댓글 ㅇ어쩌고 저쩌고</div>
			      	<div> <%-- 대댓글존 --%>
			      		<hr>
		      			<div><i class="fas fa-reply" data-fa-transform="rotate-180" style="color:lightgrey"></i>미요<small class="float-right">3시간 전</small></div>
		      			<div>대댓글임</div>
		      			<div class="ml-2">
		      				<hr>
				      		<div><i class="fas fa-reply" data-fa-transform="rotate-180" style="color:lightgrey"></i>하이<small class="float-right">1시간 전</small></div>
			      			<div>나는 대대댓글</div>		      			
		      			</div>
			      	</div>
			      </td>
			    </tr>
			      -->
			      
			  </tbody>
			</table>
		</div>
	</div>
</div>
<%-- session에서 modSuccess 삭제 --%>
<c:remove var="result" />
</body>
</html>