<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="shortcut icon" href="#">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://use.fontawesome.com/releases/v5.15.2/js/all.js" data-auto-replace-svg="nest"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link rel="stylesheet" type="text/css" href="${root }/resources/css/font.css">
<link rel="stylesheet" type="text/css" href="${root }/resources/css/mountain/list.css">
<script>
var result = '${result}';
var src = '${root }/resources/img/mountain/';

var isManager = ('${authUser.manager}' == 1);
var available = '${available}';
var root = '${root}';
</script>
<script src="${root }/resources/js/mountain/list.js"></script>
<title>산산산</title>
</head>
<body>
<m:topNav />

<div class="container-fluid my-5">
	<div class="row d-block">
		<div class="col-12 col-md-8 offset-md-2">  
      		<h3 class="text-center">산</h3>
      		<br>
      		<form id="search" class="d-flex justify-content-end align-items-center mt-3">
      			<input class="form-control mr-sm-1" type="search" name="keyword" value="${pages.cri.keyword }" placeholder="Search">
		    	<button class="btn btn-outline-success my-2 mr-5"><i class="fas fa-search"></i></button>
		    	<a href="${root }/register" id="newMountain" class="btn btn-outline-success ml-5">산 등록</a>
      		</form>

	      	
      		<c:forEach var="mountain" items="${list}" varStatus="status">
       			<c:if test="${status.count % 4 == 1 }"> 
					<div class="row">
	          	</c:if>
			
	        	<div class="col-sm-12 col-md-6 col-lg-3 mt-4"> <%-- 모바일xs에서 100% 너비, 데스크탑md에서 33.3%너비  --%>
<!-- 	        	<div class="col-xs-12 col-sm-6 col-lg-4 mt-4"> -->
					<div class="card h-100">
					
					 <%--
	                 	<img src="${root }/resources/img/mountain/${mountain.mname}.jpg" class="card-img-top" 
	                 		alt="${mountain.mname }" onerror="this.src = '${root }/resources/img/mountain/default.png';">
					  --%>
					 	<c:choose>
						    <c:when test="${empty mountain.filename }">
								<c:set var="src" value="${root }/resources/img/mountain/default.png" />
						    </c:when>
						    <c:otherwise>
						    	<c:set var="src" value="${staticPath }/${mountain.filename}" />
						    </c:otherwise>
						</c:choose>
	                 	<img src="${src }" class="card-img-top" alt="${mountain.filename }">	
	                 		
	                 	<div class="card-body h-100">
	                 		<div>
		                 		<h4 class="card-title">${mountain.mname }</h4>
		                 		<p class="card-text">${mountain.mloc }</p>
	                 		</div>
	                 		<c:url var="getUrl" value="/get">
				    		  <c:param name="no">${mountain.no}</c:param>
				    		  <c:param name="curPage">${cri.curPage }</c:param>
				    		  <c:param name="amount">${cri.amount }</c:param>
				    		  <c:param name="keyword">${cri.keyword }</c:param>
				    	    </c:url>
	                		<a href="${getUrl }" class="btn btn-success float-right"><i class="fas fa-sign-in-alt"></i></a>
	               		</div>
	             	</div>
	        	</div>
		      
		        <c:if test="${status.count % 4 == 0 }">
					</div>
		        </c:if>
		    </c:forEach>
		</div>
	</div>
	
	
	<!-- 페이지네이션 처리 -->
	<div class="row justify-content-center mt-4">
		<nav aria-label="Page navigation example">
		  <ul class="pagination justify-content-center">
		    <c:if test="${not pages.prev }"><c:set var="prevDisabled" value="disabled" /></c:if> <%-- disabled -> hidden --%>
		    <li class="page-item ${prevDisabled }">
		      <c:url var="prevUrl" value="/list">
	    		<c:param name="curPage">${pages.startPage-1 }</c:param>
	    		<c:param name="amount">${cri.amount }</c:param>
	    		<c:param name="keyword">${cri.keyword }</c:param>
	    	  </c:url>
		      <a class="page-link" href="${prevUrl }">Prev</a>
		    </li>
		    
		    <c:forEach var="page" begin="${pages.startPage }" end="${pages.endPage }">
		    	<c:url var="pageUrl" value="/list">
		    		<c:param name="curPage">${page }</c:param>
		    		<c:param name="amount">${cri.amount }</c:param>
		    		<c:param name="keyword">${cri.keyword }</c:param>
		    	</c:url>
		    	<c:if test="${page eq cri.curPage }"><c:set var="active" value="active" /></c:if>
			    <li class="page-item ${active }"><a class="page-link" href="${pageUrl }">${page }</a></li>			    
			    <c:remove var="active"/>
		    </c:forEach>
				    
			<c:if test="${not pages.next }"><c:set var="nextDisabled" value="disabled" /></c:if>
		    <li class="page-item ${nextDisabled }">
		      <c:url var="nextUrl" value="/list">
	    		<c:param name="curPage">${pages.endPage+1 }</c:param>
	    		<c:param name="amount">${cri.amount }</c:param>
	    		<c:param name="keyword">${cri.keyword }</c:param>
	    	  </c:url>
		      <a class="page-link" href="${nextUrl }">Next</a>
		    </li>
		  </ul>
		</nav>
	</div>
	
</div>
<%-- 삭제 성공 결과 삭제 --%>
<c:remove var="result"/>
<%-- 접근 금지 결과 삭제 --%>
<c:remove var="available"/>
</body>
</html>