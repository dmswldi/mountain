<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<!-- MOBILE최적화 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
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

<script type="text/javascript">
//버튼에 따라서 다른동작을 하게끔 설정

$(document).ready(function(){
	var formObj = $("form");
	
	$('button').on("click", function(e){
		// 기본 동작 막기
		e.preventDafault();
		
		var operation = $(this).data("oper");
		console.log(operation);
			
		if(operation ==='remove'){
			formObj.attr("action", "/festival/remove");
		}else if(operation ==='list') {
			self.location ="/festival/list";
			return;
			
		}
		formObj.submit();
		
	});
});





/*$(document).ready(function() {
	$("#remove-btn").click(function(e) {
		e.preventDefault();
		
		// #modify-form 의 action attr 값을 바꿔야함.
		$("#modify-form").attr("action", "${root}/festival/remove");
		
		$("#modify-form").submit();
	});
});
*/
</script>

<title>Insert title here</title>
</head>
<body>
<u:topNav/>
<c:if test="${authUser.manager != 1 }">
<script>
	alert('어디서 개수작을');
	location.href="${root}/festival/list";
</script>

</c:if>
<div class="container-sm">
<div class="row">
<div class="col-12 col-sm-6 offset-sm-3">
<h1>Board Modify Page</h1>

<form action="${root}/festival/modify"  method="post" name="modify" enctype="Multipart/form-data">

<input type="hidden" name="no" value="${param.no }">

<div class="form-group">
<label for="input1">산</label> 
<select name="ename"
class="custom-select my-1 mr-sm-2 bd-highlight" id="input1">
<option ${festival.ename eq '북한산' ? 'selected' : ''}>북한산</option>
<option ${festival.ename eq '도봉산' ? 'selected' : ''}>도봉산</option>
<option ${festival.ename eq '수락산' ? 'selected' : ''}>수락산</option>
<option ${festival.ename eq '인왕산' ? 'selected' : ''}>인왕산</option>
<option ${festival.ename eq '아차산' ? 'selected' : ''}>아차산</option>
<option ${festival.ename eq '관악산' ? 'selected' : ''}>관악산</option>
</select>
</div>
                    
                    
 <div class="form-group">
<label for="input2">설명</label> 
<textarea class="form-control" name="description" id="input2"
rows="6" required>${festival.description }</textarea>
</div>
					
<div class="form-group">
<label for=input3>축제가 있는 달</label>
<select name="month"
class="custom-select my-1 mr-sm-2 bd-highlight" id="input3" required>
<option>1</option>
<option>2</option>
<option>3</option>
<option>4</option>
<option>5</option>
<option>6</option>
<option>7</option>
<option>8</option>
<option>9</option>
<option>10</option>
<option>11</option>
<option>12</option>
</select>
</div>
	           <!--   <form action="${root}/festival/modify" method="post">-->
	            <c:url value="/festival/modify" var="modifyLink">
				<c:param name="no" value="${festival.no}"></c:param>
				<c:param name="pageNum" value="${cri.pageNum }"></c:param>
				<c:param name="amount" value="${cri.amount }"></c:param>
				</c:url>
				
				<!-- 수정에서 안뜸!!!! -->
				 <div class="form-group">
						<label for="input3">파일</label> <input name="file" type="file"
						   accept="image/*"
							class="form-control" id="input3">
					</div>
					  
				<div style="float:left; margin-right:10px; ">
		       <a href="${modifyLink }" ><button type="submit" class="btn btn-outline-success"> 수정</button> </a>
		         </div>
		        </form>
		 
		    
		     
		      
		      <input class="btn btn-outline-success" type="button" value="취소" onclick="history.back(-1)">
		      
		     
		     <div style="float:left; margin-right:10px;">
		     <form action="${root}/festival/remove" method="post">
		     <input type="hidden" name="no" value="${param.no }">
		     <button id="remove-btn" type="submit" data-oper="remove" class="btn btn-outline-success">삭제</button> <br/>
	         </form>
	         </div>
	
	 <!-- <a href="/mountain/festival/modify" class="btn btn-outline-success">수정</a> --> 
		    <!-- mountain/festival/list ==> {{root}/festival/list -->
		    <div style="float:left; margin-right:10px;">
		     <a href="${root}/festival/list" class="btn btn-outline-success">게시물 목록</a> 
		     </div>
	
</div>
</div>          
</div>



</body>
</html>




