<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- MOBILE최적화 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
  href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
  src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
  src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
  src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://use.fontawesome.com/releases/v5.15.2/js/all.js" data-auto-replace-svg="nest"></script>
<link rel="stylesheet" type="text/css" href="${root }/resources/css/font.css">

<script>
$(document).ready(function() {
	
	var result = '${result}';
	var message = '${message}';
	
	checkModal(result);
	checkModal2(message);
	
	//히스토리를 비워서 모달창 두번 안뜨게
	history.replaceState({}, null, null);
	
	function checkModal2(message) {
		if (message && history.state == null) {
			
			$("#myModal .modal-body p").html(message);
		    $("#myModal").modal("show");
		  }
		}
	
	function checkModal(result) {
		if (result === '' || history.state) {
			return;
		}
		
       // parseInt : 문자열 -> 숫자
		if (parseInt(result) > 0) {
			$("#myModal .modal-body p")
				 .html("쓰신 글 " + result + "번이 등록완료!");
		}
		$("#myModal").modal("show");
	}
	/*
	var actionForm = $("#actionForm");
	$(".pagination a").click(function(e) {
		// 페이지네이션을 클릭하는 이벤트 발생후의 모든것 prevent
		e.preventDefault();
		
		actionForm.find("[name='pageNum']").val($(this).attr('href'));
		
		actionForm.submit();
		
		});*/
		
	#('a').on('click', function(e){
		e.preventDefault();
	});	
	});

</script>
<title>Insert title here</title>
</head>
<body>
<u:topNav/>
<div class="container-sm">
<div class="row">
 <div class="col-12 col-sm-6 offset-sm-3">
							<form action="${root }/festival/list" id="searchForm"
					class="form-inline my-2 my-lg-0 d-flex bd-highlight mb-3">
				<div class="d-flex p-1 bd-highlight align-items-center">
						<input class="form-control" type="search"
						name="keyword" value="${pageMaker.cri.keyword }" 
						aria-label="Search" required="required"> <input
						type="hidden" name="pageNum" value="1" /> <input type="hidden"
						name="amount" value="${pageMaker.cri.amount }" />
</div>
					<button class="btn btn-outline-info"
						type="submit">검색</button></form>
						
	 <table class="table table-striped table-hover">
		  
      <thead>
        <tr>
          <th>#No</th>
          <th>#축제 기간</th>
          <th>#축제 이름</th>
          <th>#산</th> 
        </tr>
      </thead>
      
 
      
      <tbody>
        <c:forEach items="${list}" var="festivalVO">
          <tr>
        <td>${festivalVO.no }</td>
         <!--  <td>${festivalVO.ename }</td> -->
         
         <td>${festivalVO.month }월</td>
         
        
          <td>
            <c:url value="/festival/get" var="festivalLink">
            <c:param value="${festivalVO.no }" name="no" />
            <c:param value="${festivalVO.ename }" name="mname" />
             <c:param value="${pageMaker.cri.pageNum }" name="pageNum" />
             <c:param value="${pageMaker.cri.amount }" name="amount" />
             <c:param value="${pageMaker.cri.type }" name="type" />
             <c:param value="${pageMaker.cri.keyword }" name="keyword" />
            </c:url>
           
          <a href="${festivalLink }"> 
	           <c:out value="${festivalVO.ename}" />
  			 </a>
  			 </td>
  			 
           <td>${festivalVO.mname }</td> 
           
            </tr>
        </c:forEach>
                        
      </tbody>
      <a href="/mountain/festival/register" class="btn btn-outline-success">게시물 작성</a>
    </table>				
</div>
</div>
</div>

<div id="myModal" class="modal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">알림</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>처리가 완료되었습니다.</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

 
<div class="container-sm mt-3">
	<div class="row justify-content-center">
		<nav aria-label="Page navigation example">
		  <ul class="pagination">
		  
		  	<c:if test="${pageMaker.prev }">
		  		<c:url value="/festival/list" var="prevLink">
		  			<c:param value="${pageMaker.startPage -1 }" name="pageNum" />
		  			<c:param value="${pageMaker.cri.amount }" name="amount" />
		  			<c:param name="type" value="${pageMaker.cri.type }"/>
		    		<c:param name="keyword" value="${pageMaker.cri.keyword }" />
		  		</c:url>
			    <li class="page-item">
			    <%-- <a class="page-link" href="${prevLink }">Previous</a> --%>
			    <a class="page-link" href="${pageMaker.startPage -1 }">Previous</a>
			    </li>
		  	</c:if>
		    
		    <c:forEach var="num" begin="${pageMaker.startPage }"
		    					 end="${pageMaker.endPage }">
		    	<c:url value="/festival/list" var="pageLink" >
		    		<c:param name="pageNum" value="${num }" />
		    		<c:param name="amount" value="${pageMaker.cri.amount }" />
		    		<c:param name="type" value="${pageMaker.cri.type }"/>
		    		<c:param name="keyword" value="${pageMaker.cri.keyword }" />
		    	</c:url>
		    	<li class="page-item ${pageMaker.cri.pageNum eq num ? 'active' : '' }">
		    	<!--<a class="page-link" href="${pageLink }">${num }</a> -->
		    	  <a class="page-link" href="${pageLink }">${num }</a>
		    	</li>
		    </c:forEach>
		    
		    <c:if test="${pageMaker.next }">
		    	<c:url value="/festival/list" var="nextLink">
		    		<c:param name="pageNum" value="${pageMaker.endPage +1 }"/>
		    		<c:param name="amount" value="${pageMaker.cri.amount }" />
		    		<c:param name="type" value="${pageMaker.cri.type }"/>
		    		<c:param name="keyword" value="${pageMaker.cri.keyword }" />
		    	</c:url>
			    <li class="page-item">
			    	<%-- <a class="page-link" href="${nextLink }">Next</a> --%>
		    		<a class="page-link" href="${pageMaker.endPage +1 }">Next</a>
			    </li>
			     
			     
          
                 
		
		    </c:if>
		  </ul>
		</nav>
	</div>
</div>
</body>
</html>