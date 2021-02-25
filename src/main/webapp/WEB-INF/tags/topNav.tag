<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags"%>


<!-- <style>
#navbarSupportedContent li {
 	margin-left: 35px;
	margin-right: 35px;
}
	border-left: 10px solide #c0c0c0; // border 안됨
</style> -->

<!-- <style>
#navbarSupportedContent ul {
	padding-left:0px;
}

#navbarSupportedContent li  {
	font-size: 20px;
	display:inline;
	padding:0px 10px 0px 10px;
	margin:0px 50px 0px 50px;
	}
</style> -->

<style>
.nav3{
	padding-left:0px;
}

.nav3 li  {
	font-size: 17px;
	display:inline;
	padding:0px 10px 0px 10px;
	margin:0px 50px 0px 50px;
	}
</style>
<nav class="navbar navbar-expand-lg navbar-light bg-light p-0">
	<button class="navbar-toggler offcanvas-toggle" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		     
		<c:if test="${empty sessionScope.authUser }">
				 <ul class="navbar-nav ml-auto">
				      <li class="nav-item">
				       <a class="nav-link" href="${root }/member/join">회원가입</a>
				      </li>
				      <li class="nav-item">
				       <a class="nav-link" href="${root }/member/login">로그인</a>
				      </li>
				</ul>
				     
		</c:if>
		
		<!-- 일반회원과 관리자 -->
		<c:if test="${not empty sessionScope.authUser }">
	     <c:choose>
			  <c:when test="${sessionScope.authUser.manager eq '0'}">
				     <ul class="navbar-nav ml-auto">
				    	 <li class="nav-item">
				      		 <a class="nav-link" href="${root }/member/myHome">마이홈</a>
				   		 </li>
				   		 <li class="nav-item">
				    		<a class="nav-link" href="${root }/member/logout">로그아웃</a>
				    	 </li>
				    </ul>
		     </c:when>
	     	
		     <c:otherwise>
		    	 <ul class="navbar-nav ml-auto">
		    		 <li class="nav-item">
			      		 <a class="nav-link" href="${root }/member/myHome">마이홈</a>
			   		 </li>
			   		 <li class="nav-item">
			    		<a class="nav-link" href="${root }/member/logout">로그아웃</a>
			    	 </li>
		    		 <li class="nav-item">
				       <a class="nav-link" href="${root }/admin/index">관리자 페이지</a>
				     </li>
				</ul>
		     </c:otherwise>
	     </c:choose>
	     </c:if>

	    
	</div>
</nav>

<nav class="navbar navbar-expand-lg navbar-light bg-light p-0 m-0">
	<div class="collapse navbar-collapse ml-5 p-0" id="navbarSupportedContent">
		<div class="d-flex justify-content-around">
		<a class="navbar-brand" href="${root }/index.jsp">
			<img src="<spring:url value='/resources/img/mountainLogo.png' />" class="center-block mb-3" height="100" width="auto" alt="마운팀">
		</a>
	 		<m:search />
		</div>
	</div>
</nav> 

<nav class="navbar navbar-expand-lg navbar-light bg-light p-0 m-0 ">
  <div class="collapse navbar-collapse " id="navbarSupportedContent">
   <ul class="navbar-nav d-flex justify-content-around nav3">
	  	    <li class="nav-item">
	       		<a class="nav-link" href="${root }/list"><b>산 게시판</b></a>
	   	  	</li>
	  	    <li class="nav-item">
	       		<a class="nav-link" href="${root }/festival/list"><b>산 축제</b></a>
	   	  	</li>
	  	    <li class="nav-item">
	       		<a class="nav-link" href="${root }/place/list"><b>산 명소</b></a>
	   	  	</li>
	  	    <li class="nav-item">
	       		<a class="nav-link" href="${root }/restaurant/list"><b>맛집게시판</b></a>
	   	  	</li>
	      	<li class="nav-item">
	       		<a class="nav-link" href="${root }/freeboard/list"><b>자유게시판</b></a>
	    	</li>
	    	<li class="nav-item">
	        	<a class="nav-link" href="${root }/notice/list"><b>공지사항</b></a>
	     	</li>
		</ul>
  </div>
</nav>