<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="modal" tagdir="/WEB-INF/tags/modal"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet"
  href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
  src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
  src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
  src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/a076d05399.js"></script>

<script type="text/javascript" src="${root }/resources/js/member/myHome.js"></script>
<link rel="stylesheet" type="text/css" href="${root }/resources/css/member/myHome.css" />
<link rel="stylesheet" type="text/css" href="${root }/resources/css/font.css">
<script>
var root = '${root}';
</script>

<title>산산산</title>
</head>
<body>
<m:topNav />

<div class="container-sm">
   <div class="row">
      <div class="col-12 col-sm-6 offset-sm-3">
			<!--내 정보 보기 -->
			<form>
				<div class="container">
					<div class="row">
						<div class="col border mr-3">
							<div class="my-2 mx-3">
								<h4 class="py-3">프로필</h4>
								<div class="px-4">
									<dl>
										<dt class="d-inline">
											아이디
										</dt>
										<dd class="d-inline"> ${sessionScope.authUser.id }
										</dd>
									</dl>
									<dl>
										<dt class="d-inline">
											이름
										</dt>
										<dd class="d-inline"> ${sessionScope.authUser.name } 
										</dd>
									</dl>
									<dl>
										<dt class="d-inline">
											별명
										</dt>
										<dd class="d-inline"> ${sessionScope.authUser.nickname }
										</dd>
									</dl>
									<dl>
										<dt class="d-inline">
											비밀번호
										</dt>
										<dd class="d-inline"> ****  
										</dd>
									</dl>
									<dl>
										<dt class="d-inline">
											이메일
										</dt>
										<dd class="d-inline"> ${sessionScope.authUser.email } 
										</dd>
									</dl>
									<dl>
										<dt class="d-inline">
											주소
										</dt>
										<dd class="d-inline"> ${locDiv.postcode } ${locDiv.address } ${locDiv.detailAddress } ${locDiv.extraAddress }
										</dd>
									</dl>
								</div>
								<a href="/mountain/member/myModify">
									<input type="button" class="btn btn-success mb-4" value="수정">
								</a>
								<input type="button" class="btn btn-success mb-4 float-center" data-toggle="modal" data-target="#memberDeleteModal" value="탈퇴">
								<modal:memberDeleteModal />
							</div>
						</div>
						<div class="w-100"></div>
					 	<!--<div class="col border">
							conquest 등 정보 들어올 예정!
						</div>
						<div class="col">col</div>
						<div class="col">col</div> -->
						</div>
					</div>
				</form>
			</div>
		</div>
		
		
			<!-- 정복 산 리스트 -->
		<div class="row">
      		<div class="col-12 col-sm-6 offset-sm-3">

			<!-- row 방향으로 가로 배열할 때, 중앙 정렬  -->
			<div id="imgs" class="row-vh d-flex flex-column justify-content-center" ><!-- row방향으로 가운데 정렬 -->
				<c:forEach items="${list }" var="conq">
	     
				  <figure>
				
					<img id="imgs" src='<c:out value="${root }/resources/img/conquest/${conq.mname}.png"/>' onerror='this.src="${root }/resources/img/conquest/error/error이미지.png"'
						class="img-responsive img-rounded" /><!-- items에 서버단에서 DB연동결과물 request.setAttribute("키값명",저장객체) 와야함 -->
						           
					<h4>${conq.mname } 도장깨기</h4>
					<div class="overlay">
						<div class="description">
						
							<form action='<c:url value="Conquest/updateConquest" />'
									method="post" class="updateConquest">
									 
								<div class="container">
									<table>
 										<tr>
											<td hidden="hidden">정복최대횟수</td>
											<td class="maxconquest" hidden="hidden">100000000000</td>
											<td>
												<div class="sticker d-flex flex-wrap " > <!-- 컨테이너 벗어나지 않게 -->
												 <%--  test용 이미지 
												 	<div><img src='<c:out value="${root }/resources/img/conquest/mountain_black.png"/>' width="20"/> </div> 
												 	<div><img src='<c:out value="${root }/resources/img/conquest/mountain_black.png"/>' width="20"/> </div> 
												 	<div><img src='<c:out value="${root }/resources/img/conquest/mountain_black.png"/>' width="20"/> </div> 
												 	<div><img src='<c:out value="${root }/resources/img/conquest/mountain_black.png"/>' width="20"/> </div>  
												 	<div><img src='<c:out value="${root }/resources/img/conquest/mountain_black.png"/>' width="20"/> </div>  
												 	<div><img src='<c:out value="${root }/resources/img/conquest/mountain_black.png"/>' width="20"/> </div>  
												 	<div><img src='<c:out value="${root }/resources/img/conquest/mountain_black.png"/>' width="20"/> </div>  
												 	<div><img src='<c:out value="${root }/resources/img/conquest/mountain_black.png"/>' width="20"/> </div>   
												 --%>
												</div>
											</td>									
										</tr>	
										
										<tr>
											<td>
												<div class=" mb-auto align-self-end" >
													<input hidden="hidden" name="member_no" value="${authUser.no }"></input>
													<input hidden="hidden" name="mountain_no" value="${conq.mountain_no }"></input> 
													<button name="plus" type="button" class="up-btn btn btn-success"
													onclick="Count('p',this);" type="submit">정복+1 !!!!</button>
													<input type="text" name="conquestcnt" value="${conq.conquestcnt }" readonly="readonly" style="text-align: center;" />
													<button name="minus" type="button" onclick="Count('m', this);" 
													class="down-btn btn btn-outline-success">잘못눌렀네,,</button>													
												 </div>
											</td>
										</tr>
									</table>	
								</div>
							</form>
						
						</div>
					</div>
					
			  </figure>
			</c:forEach>
		</div>
		<!-- 정복 산 리스트 끝 -->
			
      </div>
   </div>
</div>
</body>
</html>