<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<script>
	var root = '${root}';
	var userno = '${authUser.no}';
</script>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- <script src="https://kit.fontawesome.com/a076d05399.js"></script> -->
<script src="https://kit.fontawesome.com/a076d05399.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript"
	src="${root }/resources/js/restaurant/LikeDislike.js"></script>
	<link rel="stylesheet" type="text/css" href="${root }/resources/css/font.css">

<script>
	$(document).ready(
			function() {

				var message = '${message}';
				var message2 = '${message2}';
				checkModal(message2);
				checkModal2(message);

				history.replaceState({}, null, null);
				
				function checkModal2(message) {
					if (message && history.state == null) {
						swal(message, "","success");
					}
				}
				function checkModal(message2) {
					if (message2 && history.state == null) {
						swal(message2, "","warning");
					}
				}
				var actionForm = $("#actionForm");
				$(".pagination a").click(
						function(e) {
							e.preventDefault();

							actionForm.find("[name='pageNo']").val(
									$(this).attr('href'));

							actionForm.submit();
						});
				
				var removeForm = $("#removeForm");

				$("#removeBtn").on('click', function(e) {
				    e.preventDefault();
					var resno = $(this).attr("data-resNo");
					console.log(resno);
					swal({
						  title: "삭제 하시겠습니까?",
						  icon: "warning",
						  buttons: {
							  confirm : {
								  text : '확인',
								  value : true,
								  className : 'btn btn-danger'
							  },
							  cancle : {
								  text : '취소',
								  value : false,
								  className : 'btn btn-secondary'
							  }
						  }
						}).then((result) => {
							console.log(result);
							if(result) {
								swal({
									  title: resno + "번 게시물이 삭제되었습니다",
									  icon: "success",
									  buttons: {
										  confirm : {
											  text : '확인',
											  value : true,
											  className : 'btn btn-info'
										  }
									  }
								
								}).then((result) => {
									console.log(result);
									if(result) {
										removeForm.submit();
									}
								});

							} else {
								swal.close();
							}
							
						});
				});
				
			});
</script>
<style type="text/css">
.cardimg {
	display: block;
	margin: 0px auto;
}
.card mb-3 div {
	max-width: auto;
	max-height: 250px;
}

.col-md-4 {
	float: right;
}

.col-md-8 {
	float: left;
}
.swal-footer {
	text-align: center;
}
.swal {
    position : top-start;
}

</style>
<title>산산산</title>
</head>
<body>
		<u:topNav/>
	<div class="container-sm">

		<div class="row">
			<div class="col-12 col-sm-6 offset-sm-3">
				<form action="${root }/restaurant/list" id="searchForm"
					class="form-inline my-2 my-lg-0 d-flex bd-highlight mb-3">
					<div class="mr-auto p-2 bd-highlight">
						<a href="${root }/restaurant/list"><button
								class="btn btn-outline-info my-2 my-sm-0" type="button">목록</button></a>
								<c:if test="${authUser.manager == 1 }">
						<a href="${root }/restaurant/register"><button
								class="btn btn-outline-info my-2 my-sm-0" type="button">등록</button></a>
								</c:if></div>
								<div class="d-flex p-1 bd-highlight align-items-center">
						<input class="form-control" type="search"
						name="keyword" value="${page.cri.keyword }" 
						aria-label="Search" required="required"> <input
						type="hidden" name="pageNo" value="1" /> <input type="hidden"
						name="amount" value="${page.cri.amount }" />
						<input type="hidden" name="type" value="MNLFD" />
</div>
					<button class="btn btn-outline-info"
						type="submit">검색</button>
				</form>
				<c:if test="${empty list}">
				<div class="text-center">
				<span style="font-size: 2em; color: darkgray; text-align: center">
				<i class="fas fa-exclamation-triangle"></i>검색한 결과가 없습니다.
				</span></div></c:if>
				<c:forEach items="${list }" var="res" varStatus="status">
<c:if test="${status.count%2 == 1 }"><div class="row"></c:if>
				<div class="col-sm-6">
					<div class="card mb-3">
								<img src="${staticPath }/${res.filename}" class="card-img-top img-fluid cardimg mt-2"
									style="width: 250px;">
								<div class="card-body">
									<h5 class="card-title" style="font-weight: bold;">${res.rname }</h5>
									<p class="card-text">
										<input type="hidden" name="resno" value="${res.no }"
											id="resno" /><c:out value="${res.mname }"/> <br> <c:out value="${res.rloc }"/><br>
									</p>
									<p class="card-text">
									대표메뉴 : <c:out value="${res.menu }"/><br>
										<small class="text-muted"><u:pre value="${res.description }"/><br>전화 : <c:out value="${res.contact }"/></small><br>
									</p>
									<div class="d-flex justify-content-end align-items-center mb-1 likeDislike">
										<!-- 								 $(this).attr("data-resNo"); -->

										<img data-resNo="${res.no }" id="like-img${status.count }"
											src="${root }/resources/img/like/like_empty2.png" width="25px"
											height="25px"><span>&nbsp; ${res.likecnt }
											&nbsp;</span> <img data-resNo="${res.no }"
											id="dislike-img${status.count }"
											src="${root }/resources/img/like/dislike_empty.png" width="25px"
											height="25px"><span>&nbsp;${res.dislikecnt }</span>

									</div>
									<c:if test="${authUser.manager == 1}">
										<!--  ${authUser.manager == 1} -->
										<div class="d-flex justify-content-end">
											<c:url value="/restaurant/modify" var="modifyLink">
												<c:param name="no" value="${res.no }"></c:param>
												<c:param name="pageNo" value="${cri.pageNo }"></c:param>
												<c:param name="amount" value="${cri.amount }"></c:param>
												<c:param name="type" value="${cri.type }"></c:param>
												<c:param name="keyword" value="${cri.keyword }"></c:param>
											</c:url>
											<a href="${modifyLink }">
												<button class="btn btn-outline-info m-1 my-sm-0"
													type="submit">수정</button>
											</a>
											<form action="${root }/restaurant/remove" method="post" id="removeForm">
												<input type="hidden" name="no" value="${res.no}">
												<button class="btn btn-outline-info m-1 my-sm-0"
													id="removeBtn" type="submit" data-resNo="${res.no }">삭제</button>
											</form>
										</div>
									</c:if>
								</div>
					</div>
					</div>
					<c:if test="${status.count%2 == 0 }"></div></c:if>
					
				</c:forEach>
			</div>
			<div class="container-sm mt-3">
				<div class="row justify-content-center">
					<nav aria-label="Page navigation example">
						<ul class="pagination">

							<c:if test="${page.prev }">
								<li class="page-item">
									<a class="page-link" href="${page.startPage -1 }">Previous</a>
								</li>
							</c:if>

							<c:forEach var="num" begin="${page.startPage }"
								end="${page.endPage }">

								<li class="page-item ${page.cri.pageNo eq num ? 'active' : '' }">
									<a class="page-link" href="${num }">${num }</a>
								</li>
							</c:forEach>

							<c:if test="${page.next }">

								<li class="page-item">
									<a class="page-link" href="${page.endPage +1 }">Next</a>
								</li>
							</c:if>
						</ul>
					</nav>
				</div>
			</div>
		</div>
	</div>

	<div class="d-none">
		<form id="actionForm" action="${root }/restaurant/list">
			<input name="pageNo" value="${page.cri.pageNo }" /> <input
				name="amount" value="${page.cri.amount }" /> <input name="type"
				value="${page.cri.type }" /> <input name="keyword"
				value="${page.cri.keyword }" /> <input type="submit" />
		</form>
		</div>

</body>
</html>