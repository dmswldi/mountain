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
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- <script src="https://kit.fontawesome.com/a076d05399.js"></script> -->
<script src="https://kit.fontawesome.com/a076d05399.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript"
	src="${root }/resources/js/restaurant/LikeDislike.js"></script>
<link rel="stylesheet" type="text/css"
	href="${root }/resources/css/font.css">
<link rel="stylesheet" type="text/css"
	href="${root }/resources/css/place/list.css">

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

<title>산산산</title>
</head>
<body>
	<u:topNav />
	<div class="container-fluid my-5">
		<h3>맛 집</h3>
		<div class="row">
			<div class="col-12 col-md-8 offset-md-2 table-responsive">

				<form action="${root }/restaurant/list" id="searchForm"
					class="form-inline my-2 my-lg-0 d-flex bd-highlight mb-3">
					<div class="mr-auto p-2 bd-highlight">
						<a href="${root }/restaurant/list"><button
								class="btn btn-outline-success my-2 my-sm-0" type="button">목록</button></a>
						<c:if test="${authUser.manager == 1 }">
							<a href="${root }/restaurant/register"><button
									class="btn btn-outline-success my-2 my-sm-0" type="button">등록</button></a>
						</c:if>
					</div>
					<div class="d-flex p-1 bd-highlight align-items-center">
						<input class="form-control" type="search" name="keyword"
							value="${page.cri.keyword }" aria-label="Search"
							required="required"> <input type="hidden" name="pageNo"
							value="1" /> <input type="hidden" name="amount"
							value="${page.cri.amount }" /> <input type="hidden" name="type"
							value="MNLFD" />
					</div>
					<button class="btn btn-outline-success" type="submit">검색</button>
				</form>
				<c:if test="${empty list}">
					<div class="text-center">
						<span style="font-size: 2em; color: darkgray; text-align: center">
							<i class="fas fa-exclamation-triangle"></i>검색한 결과가 없습니다.
						</span>
					</div>
				</c:if>
				<div class="row">
					<c:forEach items="${list }" var="res" varStatus="status">
						<div class="col-sm-6 p-1">

							<div class="card h-100">
								<img
									<c:if test="${empty res.filename}">
								src="${root }/resources/img/restaurant/restaurantdefault.png"
								</c:if>
									<c:if test="${not empty res.filename}">
								src="${staticPath }/${res.filename}" 
								</c:if>
									class="card-img-top img-fluid cardimg">
								<div class="card-body">
									<div class="pb-3" style="height: 90%;">
									<h5 class="card-title" style="font-weight: bold;">${res.rname }</h5>
									<p class="card-text">
										<input type="hidden" name="resno" value="${res.no }"
											id="resno" />
										<c:out value="${res.mname }" />
										<br>
										<c:out value="${res.rloc }" />
										<br>
									</p>
									<p class="card-text">
										대표메뉴 :
										<c:out value="${res.menu }" />
										<br>
										<u:pre value="${res.description }" />
										<br>전화 :
										<c:out value="${res.contact }" />
										<br>
									</p>
									</div>
									<div
										class="d-flex justify-content-between align-items-center mb-1 likeDislike btnBox"
										style="height: 10%;">
										<div class="d-flex align-items-center">
											<c:if test="${authUser.manager == 1}">
												<!--  ${authUser.manager == 1} -->
												<c:url value="/restaurant/modify" var="modifyLink">
													<c:param name="no" value="${res.no }"></c:param>
													<c:param name="pageNo" value="${cri.pageNo }"></c:param>
													<c:param name="amount" value="${cri.amount }"></c:param>
													<c:param name="type" value="${cri.type }"></c:param>
													<c:param name="keyword" value="${cri.keyword }"></c:param>
												</c:url>
												<a href="${modifyLink }">
													<button class="btn btn-outline-success" type="submit">수정</button>
												</a>
												<form action="${root }/restaurant/remove" method="post"
													id="removeForm">
													<input type="hidden" name="no" value="${res.no}">
													<button class="btn btn-outline-success" id="removeBtn"
														type="submit" data-resNo="${res.no }">삭제</button>
												</form>
											</c:if>

										</div>
										<!-- 								 $(this).attr("data-resNo"); -->
										<div class="d-flex align-items-center">
											<img class="float-right" data-resNo="${res.no }"
												id="like-img${status.count }"
												<c:if test="${res.likeClick eq 1 }" >
											src="${root }/resources/img/like/like_full.png"
											</c:if>
												<c:if test="${res.likeClick eq 0 }" >
											src="${root }/resources/img/like/like_empty2.png" 
											</c:if>
												width="25px" height="25px"><span>&nbsp;
												${res.likecnt } &nbsp;</span> <img class="float-right"
												data-resNo="${res.no }" id="dislike-img${status.count }"
												<c:if test="${res.dislikeClick eq 1 }" >
											src="${root }/resources/img/like/dislike_full.png" 
											</c:if>
												<c:if test="${res.dislikeClick eq 0 }" >
											src="${root }/resources/img/like/dislike_empty.png" 
											</c:if>
												width="25px" height="25px"><span>&nbsp;${res.dislikecnt }</span>

										</div>

									</div>

								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
			<div class="container-sm mt-3">
				<div class="row justify-content-center">
					<nav aria-label="Page navigation example">
						<ul class="pagination my">

							<c:if test="${page.prev }">
								<li class="page-item"><a class="page-link"
									href="${page.startPage -1 }"><<</a></li>
							</c:if>

							<c:forEach var="num" begin="${page.startPage }"
								end="${page.endPage }">

								<li class="page-item ${page.cri.pageNo eq num ? 'active' : '' }">
									<a class="page-link" href="${num }">${num }</a>
								</li>
							</c:forEach>

							<c:if test="${page.next }">

								<li class="page-item"><a class="page-link"
									href="${page.endPage +1 }">>></a></li>
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