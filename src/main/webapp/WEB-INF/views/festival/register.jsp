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

<title>Insert title here</title>
<script>
/*
$(document).ready(function() {
	$("#register-select1").change(function() {
		var value = $('option:selected', this).attr("data-no")
		$("#register-select2").val(value);
	});
});
*/
</script>
</head>
<body>
<u:topNav/>
<div class="container-sm">
		<div class="row">
			<div class="col-12 col-sm-6 offset-sm-3">
				<h1>축제 등록</h1>
			</div>
		</div>
		
		<div class="row">
			<div class="col-12 col-sm-6 offset-sm-3">
			<form action="${root}/festival/register"  method="post" name="register" enctype="Multipart/form-data" >
                 
            <div class="form-group">
               <label for="ename">축제이름 </label>
               <input class="form-control" type="text" name="ename" id="ename" required>
               
            <!--   <select name="ename"
							class="custom-select my-1 mr-sm-2 bd-highlight"
							id="input1">
							<option>북한산</option>
							<option>도봉산</option>
							<option>수락산</option>
							<option>인왕산</option>
							<option>아차산</option>
							<option>관악산</option>
						</select> -->
<%--
<div class="dropdown">
  <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    Dropdown button
  </button>
  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
  	<select name="ename">
	  	<c:forEach items="${list}" var="MnameVO">
	  		<option class="dropdown-item" value="${MnameVO.ename }">${MnameVO.ename }</option>
	    </c:forEach>
  	</select>
  </div>
</div>
 --%>		


						
			 
        
                 </div>
                 
                 <div class="form-group">
						<label for="input2">설명</label><textarea class="form-control" name="description" id="input2"
						rows="6" required placeholder="설명을 작성하세요"></textarea>
					</div>
                 
                   
                      <div class="form-group">
						<label for="input3">파일</label> <input name="file" type="file"
						   accept="image/*"
							class="form-control" id="input3">
					</div>
                 
                 
                 <div class="form-group">
               <label for=input4>축제가 있는 달</label>
               <select name="month" class="custom-select my-1 mr-sm-2 bd-highlight" id="input4">
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
                    <!-- 산 번호를 어찌 읽어 오지?.... 
        <div class="form-group">
               <label for="input4">산 번호 </label>
        <!--       <select name=" mountain_no"
							class="custom-select my-1 mr-sm-2 bd-highlight"
							id="input4">
							<option> 291</option>
							<option> 41</option>
							<option> 44</option>
							<option> 294</option>
							<option> 297 </option>
							<option> 61</option>
						</select> -->
						 <label for="input2">산 번호 </label>
						<select name="mountain_no" class="custom-select my-1 mr-sm-2 bd-highlight" id="register-select2">
  	<c:forEach items="${list}" var="MnameVO">
  		<option class="dropdown-item" value="${MnameVO.no}">${MnameVO.mname}</option>
    </c:forEach>
</select>	

		<%-- 		<c:forEach items="${list}" var="MnameVO">
         	 <tr>
          		<td>${MnameVO.no }</td> 
            </tr>
        </c:forEach>
         --%>
        
                   <p>
                 <a href="/mountain/festival/list">게시물 목록</a> <br/>
                 <!-- <a href="/mountain/festival/register">게시물 작성</a> -->
                 </p>
                 
                 
                 	<button type="submit" class="btn btn-primary">Submit</button>
                 	  </form>
                 	   </div> 
                 </div>
		</div>
	
 

</body>
</html>	
                 	
                 	
                 	
                 	
                    
				
				
			
			