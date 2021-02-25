e<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<script>
var appRoot = "${root}";
var no = ${festival.no};

</script>
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

<title>Insert title here</title>
</head>
<body>
<u:topNav/>
<div class="container-sm">
		<div class="row">
			<div class="col-12 col-sm-6 offset-sm-3">
				<h1>게시물 보기</h1>
			</div>
		</div> <br/>
		
		<div class="row">
			<div class="col-12 col-sm-6 offset-sm-3">
			
			
               <!--산 이름  
				<div class="form-group">
					<label for="input1"></label> <input name="ename" class="form-control"
						type="text" id="input1" readonly value="${festival.ename }"/>
				</div>
				-->
				
				<div class="form-group">
				<label for="input5"></label>
				<input type="hidden" readonly value="${festival.no }" name="fboardNo"/>
			
				</div>
				
				
				
                <div class="form-group">
					<label for="input3">축제 기간(월)</label> <input readonly
						value='<c:out value="${festival .month}" />' type="number"
						class="form-control" id="input3">
				</div>
				
				
				
				<!-- 2021.02.23 추가-->
					<div>
				<img alt="" class="img-fluid"src="/static/${festival.filename}">
				</div>
				
				
				<div class="form-group">
					<label for="input2">축제 설명</label> <input readonly
						value='<c:out value="${festival.description }" />' type="text"
						class="form-control" id="input2" >
				</div>
                 <!--  
				<div class="form-group">
					<label for="input4">산 위치</label> <input readonly
						value='<c:out value="${mountain.mloc}" />' type="text"
						class="form-control" id="input4">
				</div>
				-->
				  <!--산 이름  -->
				<div class="form-group">
					<label for="input1">축제 이름</label> <input name="ename" class="form-control"
						type="text" id="input1" readonly value="${festival.ename }"/>
				</div>
				
				<c:url value="/festival/modify" var="modifyLink">
				<c:param name="no" value="${festival.no }"></c:param>
				<c:param name="mname" value="${festival.ename }"></c:param>
				<c:param name="pageNum" value="${cri.pageNum }"></c:param>
				<c:param name="amount" value="${cri.amount }"></c:param>
				</c:url>
				
				 
				<div class="form-group">
				<label for="input6">산 위치</label>
				<input name="mloc" class="form-control" type="text" id="input6" readonly value="${mountain.mloc }"/>
				</div>
				
				
			<c:if test="${authUser.manager == 1 }">
		       <a href="${modifyLink }" class="btn btn-outline-success"> 수정 </a>
		     
		      
		     <!-- 버튼 -->
		     <input class="btn btn-outline-success" type="button" value="취소" onclick="history.back(-1)">
		    </c:if> 
		     
		   <!--   <button type="submit" id="back-Btn" class="btn btn-warning">취소</button>
		     
		 
                 <script>
                   $("#back_Btn").click(function(){
                  history.back();
                 location.href = "/mountain/festival/list?n=" + ${festival.no};
                  });   
                  </script>
		     
		     -->
		      <a href="/mountain/festival/list" class="btn btn-outline-success">게시물 목록</a>
		
		      <div style="float:left; margin-right:10px; ">
		     <form action="${root}/festival/remove" method="post">
		     <input type="hidden" name="no" value="${param.no }">
		     <c:if test="${authUser.manager == 1 }">
		       <button id="remove-btn" type="submit" data-oper="remove" class="btn btn-outline-success">삭제</button> <br/>
		     </c:if>
	         </form>
	         </div>
	
		  
		 
		 
		 
		 <!--  
		        <c:url value="/festival/list" var="listLink">
				<c:param name="no" value="${festival.no }"></c:param>
				<c:param name="pageNum" value="${cri.pageNum  }"></c:param>
				<c:param name="amount" value="${cri.amount  }"></c:param>
				</c:url>
				
				<a href='${listLink }' class="btn btn-outline-success"> 목록보기 </a>
		-->
		
		
		
		
		<!--  
		   
        <c:forEach items="${list}" var="festivalVO">
          <tr>
          <td>${festivalVO.no }</td>
          <td>${festivalVO.ename }</td>
          <td>${festivalVO.description }</td>
          <td>${festivalVO.month }</td>
          <td>${festivalVO.mountain_no }</td>
            </tr>
        </c:forEach>
      	<a href="${modifyLink }" class="btn btn-secondary"> 수정 </a>
		-->
		
		</div>
		</div>
		</div>
		
		<%-- modal 수정 form --%>
	<div class="modal fade" id="modify-reply-modal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">수정 / 삭제</h5>
					<button type="button" class="close" data-dismiss="modal">
						<span>&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label for="reply-input2" class="col-form-label"> 댓글 </label> <input
							type="text" class="form-control" id="reply-input2">
					</div>
					<div class="form-group">
						<label for="replyer-input2" class="col-form-label"> 작성자 </label> <input
							type="text" class="form-control" id="replyer-input2">
					</div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
					<button id="reply-modify-button" type="button" class="btn btn-primary">수정</button>
					<button id="reply-delete-button" type="button" class="btn btn-danger">삭제</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>