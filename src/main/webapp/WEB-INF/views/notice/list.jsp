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
<!-- <script src="https://kit.fontawesome.com/a076d05399.js"></script> -->
<script src="https://use.fontawesome.com/releases/v5.15.2/js/all.js" data-auto-replace-svg="nest"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
var root = '${root}';	
var result = '${result }';
var isManager = ('${authUser.manager}' == 1);
</script>
<script src="${root }/resources/js/notice/list.js"></script>
<link rel="stylesheet" type="text/css" href="${root }/resources/css/font.css">
<link rel="stylesheet" type="text/css" href="${root }/resources/css/notice/list.css">
<title>산산산</title>
</head>
<body>
<m:topNav></m:topNav>

<div class="container-sm my-5">
	<div class="row">
		<div class="col-12 col-md-8 offset-md-2">
			<h3 class="text-center">공지/이벤트</h3>
			<br>
			
			<%-- search : category, title, content --%>
			<form action="${root }/notice/list" class="form-inline my-2 float-right">
			  <div class="form-group">
			  	<c:if test="${pages.cri.category eq 'notice' }"><c:set var="notice" value="selected" /></c:if>
			  	<c:if test="${pages.cri.category eq 'event' }"><c:set var="event" value="selected" /></c:if>
		        <select name="category" class="form-control">
		          <option value="" selected >전체</option>
		          <option value="notice" ${notice }>공지</option>
		          <option value="event" ${event }>이벤트</option>
		        </select>
		      </div>
		      <input class="form-control mr-sm-1" type="search" name="keyword" value="${pages.cri.keyword }" placeholder="Search">
		      <input type="hidden" name="curPage" value="1">
		      <input type="hidden" name="amount" value="${pages.cri.amount }">
		      <button class="btn btn-outline-success my-2"><i class="fas fa-search"></i></button>
		    </form>
			<br>
			
			<%-- notice list --%>
			<table class="table table-hover">
			  <thead>
			    <tr id="list-head">
			      <th scope="col">No.</th>
			      <th scope="col">분류</th>
			      <th scope="col">제목</th>
			      <th scope="col">작성일</th>
			      <th scope="col"><i class="far fa-eye"></i></th>
			    </tr>
			  </thead>
			  <tbody>
			  	<c:if test="${empty list}">
			  		<tr class="list-item">
				      <th scope="row" colspan="5">
				      	<span>게시물이 존재하지 않습니다.</span>
				      </th>
			  		</tr>
			  	</c:if>
				<c:forEach items="${list }" var="notice">
					<fmt:formatDate var="regdate" value="${notice.regdate }" pattern="yyyy-MM-dd HH:mm" />
					<c:choose>
						<c:when test="${notice.category eq 'notice' }"><c:set var="category" value="공지" /></c:when>
						<c:when test="${notice.category eq 'event' }"><c:set var="category" value="이벤트" /></c:when>
					</c:choose>
					<c:url var="getUrl" value="/notice/get">
						<c:param name="no" value="${notice.no }"></c:param>
						<c:param name="category" value="${pages.cri.category }"></c:param>
						<c:param name="keyword" value="${pages.cri.keyword }"></c:param>
						<c:param name="curPage" value="${pages.cri.curPage }"></c:param>
						<c:param name="amount" value="${pages.cri.amount }"></c:param>
					</c:url>
				    <tr class="list-item" onclick="location='${getUrl}'">
				      <th scope="row" class="no">${notice.no }</th>
				      <td>${category }</td>
				      <td>${notice.title } 
				      	<c:if test="${notice.reply eq 1 }"><small class="text-success">${notice.replycnt }</small></c:if> <%-- 댓글 개수 --%>
				      	<jsp:useBean id="date" class="java.util.Date" />						
						<fmt:parseNumber var="nowtime" value="${date.time}" integerOnly="true" />
						<fmt:parseNumber var="regtime" value="${notice.regdate.time}" integerOnly="true" />
				      	<c:if test="${((nowtime - regtime) / (1000*60*60) - 9 ) / 24  < 7}">
				      		<span class="badge badge-danger">New</span> <%-- 7일 미만 --%>
				      	</c:if>
				      </td>
				      <td>${regdate }</td>
				      <td>${notice.cnt }</td>
				    </tr>
				</c:forEach>
			  </tbody>
			</table>			
			<a id="newNoticeBtn" href="${root }/notice/register" class="btn btn-success float-right">새 공지</a>					
		</div>
	</div>
	
	<br>
	
	<%-- Pagination --%>
	<div class="row">
		<div class="col-md-8 offset-md-2">
			<nav aria-label="Page navigation example">
			  <ul class="pagination justify-content-center">
			    <c:if test="${!pages.prev }">
			    	<c:set var="prev" value="disabled" />
			    </c:if>
 				<c:url var="prevUrl" value="/notice/list">
					<c:param name="category" value="${pages.cri.category }"></c:param>
					<c:param name="keyword" value="${pages.cri.keyword }"></c:param>
					<c:param name="curPage" value="${pages.startPage-1 }"></c:param>
					<c:param name="amount" value="${pages.cri.amount }"></c:param>
				</c:url>
			    <li class="page-item ${prev }">
			      <a class="page-link" href="${prevUrl }">Previous</a>
			    </li>
			    
			    <c:forEach var="pageNum" begin="${pages.startPage }" end="${pages.endPage }">
			    	<c:if test="${pageNum eq pages.cri.curPage }">
			    		<c:set var="active" value="active" />
			    	</c:if>
				    <c:url var="pageUrl" value="/notice/list">
						<c:param name="category" value="${pages.cri.category }"></c:param>
						<c:param name="keyword" value="${pages.cri.keyword }"></c:param>
						<c:param name="curPage" value="${pageNum }"></c:param>
						<c:param name="amount" value="${pages.cri.amount }"></c:param>
					</c:url>
				    <li class="page-item ${active }">
				    	<a class="page-link" href="${pageUrl }">${pageNum }</a>
				    </li>	    
				    <c:remove var="active" />
			    </c:forEach>
			    
			    <c:if test="${!pages.next }">
			    	<c:set var="next" value="disabled" />
			    </c:if>
			    <c:url var="nextUrl" value="/notice/list">
					<c:param name="category" value="${pages.cri.category }"></c:param>
					<c:param name="keyword" value="${pages.cri.keyword }"></c:param>
					<c:param name="curPage" value="${pages.endPage+1 }"></c:param>
					<c:param name="amount" value="${pages.cri.amount }"></c:param>
				</c:url>
			    <li class="page-item ${next }">
			      <a class="page-link" href="${nextUrl }">Next</a>
			    </li>
			  </ul>
			</nav>
		</div>
	</div>
</div>
<%-- session에서 delSuccess 삭제 --%>
<c:remove var="result" />
</body>
</html>