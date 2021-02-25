<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<script>
	var appRoot = '${root}';
	var board_no = '${freeboard.no}';
	var anick = '${authUser.nickname}';
	var fnick = '${vo.replyer}';
</script>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css"
	href="${root }/resources/css/font.css">

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

<script src="${root }/resources/js/freeboard/freply.js"></script>
<script>
	/* 	console.log("~~~~~~~~~~");
	 console.log("js test");

	 var boardnoValue = '<c:out value="${freeboard.no}"/>'; */
	/* 
	//test
	FReplyService.register({
		reply : "js test",
		replyer : "tester",
		board_no : boardnoValue
	}, function(result) {
		alert("RESULT: " + result);
	});

	//목록 얻어오기 test
	FReplyService.getList({
		board_no : boardnoValue,
		page : 1
	}, function(list) {//파라미터는 js에 전달됨 
		for (var i = 0, len = list.length || 0; i < len; i++) {
			console.log(list[i]);
		}
	});

	//댓글 삭제
	FReplyService.remove(152, function(count) {
		console.log(count);
		if (count === "success") {
			alert("삭제되었습니다.");
		}
	}, function(err) {
		alert('error.');
	});
	//댓글 수정
	FReplyService.update({
		no : 156,
		board_no : boardnoValue,
		reply : "ㅋㅋㅋ수정되라!~!js test!!!!!!!!!!"

	}, function(result) {
		alert("RESULT: " + result);
	});
	//댓글 조회
	FReplyService.get(12010243, function(data) {
		console.log(data);
	}); */
</script>

<script>
	$(document)
			.ready(
					function() {
						// 날짜 형식
						function dateString(date) {
							var d = new Date(date);
							return d.toISOString().split("T")[0];
						}

						// 댓글 목록 가져오기 함수
						function showList() {
							FReplyService
									.getList(
											{
												board_no : board_no
											},
											function(list) {
												// console.log(list);

												var replyUL = $("#freply-ul");
												replyUL.empty();
												for (var i = 0; i < list.length; i++) {
													var replyLI = '<li class="media" data-no="' 
									+ list[i].no + '" ><div class="media-body"><h5 data-reply="'+list[i].replyer+'" style="float:right;">'
															+ list[i].replyer
															+ '&nbsp&nbsp&nbsp'
															+ '<small class="float-right">'
															+ dateString(list[i].regdate)
															+ "</small></h5>"
															+ "<span class='reply-li-body'>" + list[i].reply + "</span>"
															+ "<hr></div> </li>";
													var replyLI1 = $('<li ></li>');
													var modInputButton = $('<input type="button" class="fre-modify-button btn btn-xs" style="color:green" value="수정/삭제" />').click(function() {
														$("#modify-freply-modal").modal('show');
														console.log($(this).closest("li").next().find(".reply-li-body").text());
														$("#modify-no-reply").text($(this).closest("li").next().find(".reply-li-body").text());
														$("#modify-no").text($(this).closest("li").next().attr("data-no"));
													});
													if (anick == list[i].replyer) { //유저닉네임이 글쓴이와 같으면~
														replyUL.append(replyLI1.append(modInputButton));
													}
													replyUL.append(replyLI);
													
												}
											});
						}

						// 댓글쓰기 버튼 click이벤트 처리
						$("#new-freply-button").click(function() { //댓글 쓰기 id가져옴
							console.log("댓글쓰기버튼 동작????????");
							$("#new-freply-modal").modal("show");
							// 모달창 내의 textarea 요소들 value를 초기화
							$("#new-freply-modal textarea").val("");

						});

						
						
						
						
						//모달창_새로운 댓글_등록버튼 처리
						$("#freply-submit-button")
								.click(
										function() {

											// textarea에서 value 가져와서 변수에 저장
											var reply = $("#freply-textarea")
													.val();
											var replyer = $("#replyer-textarea")
													.text();
											console.log("reply:::::::::::::"
													+ reply);
											console.log("replyer:::::::::::::"
													+ replyer);
											// ajax 요청을 위한 데이터 만들기
											var data = {
												board_no : board_no,
												reply : reply,
												replyer : replyer
											};

											FReplyService
													.register(
															data,
															function() {
																showList();
																alert("${authUser.nickname}"
																		+ "님의 댓글 등록에 성공하였습니다.");
															},
															function() {
																alert("${authUser.nickname}"
																		+ "님의댓글 등록에 실패하였습니다. 재시도 해주세요.")
															});

											// 모달창 닫기
											$("#new-freply-modal")
													.modal("hide");
											// 모달창 내의 textarea 요소들 value를 초기화
											$("#new-freply-modal textarea")
													.val("");

										});

						// freply-ul 클릭 이벤트 처리>  showList()에서 for문에서 li생성했던거!

						$("#freply-ul").on(
								"click",
								"li",
								function() {
									//alert(anick);
									var reply_writer = $(this).find("h5").attr(
											"data-reply"); // 댓글 작성자 닉네임
									//alert("댓글의 작성자 닉네임은:"+reply_writer);

									if (anick == reply_writer) {
										console.log("freply ul 선택.");

										// 한개의 댓글  //수정 form의 modal-body의 data
										var no = $(this).attr("data-no"); // 댓글 작성번호
										FReplyService.get(no, function(data) {
											$("#modify-no").val(no);
											$("#modify-no-reply").val(
													data.reply);
											$("#modify-no-replyer").val(
													data.replyer);
											$("#modify-freply-modal").modal(
													'show');
										});
									}
								});

						/* // 한개의 댓글  //수정 form의 modal-body의 data
						var no = $(this).attr("data-no");
						FReplyService.get(no, function(data) {
							$("#modify-no").val(no);
							$("#modify-no-reply").val(data.reply);
							$("#modify-no-replyer").val(data.replyer);
							$("#modify-freply-modal").modal('show');
						});*/
					
						
						
						// 수정 버튼 이벤트 처리
						$("#freply-modify-button").click(function() {
							var no = $("#modify-no").val();
							var reply = $("#modify-no-reply").val();
							var data = {
								no : no,
								reply : reply
							};

							FReplyService.update(data, function() {
								alert("댓글을 수정하였습니다.");
								$("#modify-freply-modal").modal('hide');
								showList();
							});
						});

						// 삭제 버튼 이벤트 처리
						$("#freply-delete-button").click(function() {
							var no = $("#modify-no").val();
							FReplyService.remove(no, function() {
								alert("댓글을 삭제하였습니다.");
								$("#modify-freply-modal").modal('hide');
								showList();
							});
						});

						// 댓글 목록 가져오기 실행
						showList();

					});
</script>

<title>산산산</title>

<style>/* css */
h4 {
	text-align: center;
	text-size: 60pt;
}
</style>
</head>
<body>
	<m:topNav />
	<div class="container mt-5 ">
		<h4>글 보기</h4>
	</div>
	<div class="container-sm">

		<div class="row">
			<div class="col-12 col-sm-6 offset-sm-3">

				<form method="post"<%-- action="${pageContext.request.contextPath }/freeboard/register" --%>>


					<div class="form-group">
						<label>번호</label> <input name="no" type="text"
							class="form-control" value='<c:out value="${freeboard.no }"/>'
							readonly="readonly">
					</div>
					<div class="form-group">
						<label for="input1">제목</label> <input name="title" type="text"
							class="form-control" value='<c:out value="${freeboard.title }"/>'
							readonly="readonly">
					</div>

					<div class="form-group">
						<label for="textarea1">내용</label>
						<textarea name="content" class="form-control" rows="3"
							readonly="readonly"><c:out
								value="${freeboard.content }" /></textarea>
					</div>

					<div class="form-group">
						<label for="writer">작성자</label> <input type="text"
							class="form-control" name="writer" id="writer"
							value='<c:out value="${freeboard.user_nickname}" />'
							readonly="readonly">
					</div>


					<c:url value="/freeboard/modify" var="modifyLink">
						<c:param name="no" value="${freeboard.no }"></c:param>
						<c:param name="pageNum" value="${cri.pageNum }"></c:param>
						<c:param name="amount" value="${cri.amount }"></c:param>
						<!-- 조회페이지에서의 검색처리  -->
						<c:param name="type" value="${cri.type }"></c:param>
						<c:param name="keyword" value="${cri.keyword }"></c:param>
					</c:url>

					<c:if test="${authUser.nickname eq freeboard.user_nickname }">
						<a href="${modifyLink }" class="btn btn-outline-success"> 수정 </a>
					</c:if>

					<c:url value="/freeboard/list" var="listLink">
						<c:param name="no" value="${freeboard.no }"></c:param>
						<c:param name="pageNum" value="${cri.pageNum  }"></c:param>
						<c:param name="amount" value="${cri.amount  }"></c:param>
					</c:url>
					<a href='${listLink }' class="btn btn-outline-success"> 목록보기 </a>

				</form>

			</div>
		</div>

	</div>
	<!-- 댓글목록~~ -->

	<div class="container-sm mt-3">
		<div class="row">
			<div class="col-12 col-lg-6 offset-lg-3">
				<div class="card">
					<div class="card-header">
						<%-- 				<div>
					${authUser.nickname }
					</div>
					<div>
					${authUser }
					</div>
					<div>
					${freeboard }
					</div>
					<div>
					${freeboard.user_nickname } 
					</div>--%>
						<c:if test="${authUser.nickname != null}">
							<button id="new-freply-button" class="btn btn-outline-success "
								style="float: right;" data-toggle="modal"
								data-target="#new-freply-modal">댓글쓰기</button>
						</c:if>
						<!-- Button trigger modal 적용-->
						<div>댓글을 수정하려면 로그인하여 해당댓글을 선택하세요.</div>

					</div>
					<div class="card-body">
						<ul class="list-unstyled" id="freply-ul">
							<!-- 내부에<li></li> list로 생성됨 -->

						</ul>

					</div>
				</div>

			</div>
		</div>
	</div>



	<!-- 새로운 댓글_modal -->
	<div class="modal fade" id="new-freply-modal" data-backdrop="static"
		data-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="staticBackdropLabel">
						${authUser.nickname}님의 댓글 작성창</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label for="freply-textarea" class="col-form-label"> 댓글 </label>
						<textarea id="freply-textarea" name="content" class="form-control"
							rows="10" required></textarea>


						<div class="form-group">
							<label for="replyer-textarea" hidden="hidden">댓글 작성자</label>
							<textarea id="replyer-textarea" class="form-control"
								name="replyer-textarea" hidden="hidden">${authUser.nickname}</textarea>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">닫기</button>

					<button id="freply-submit-button" type="button"
						class="btn btn-outline-success">등록</button>

				</div>
			</div>
		</div>
	</div>



	<!-- 수정 댓글_modal -->
	<div class="modal fade" id="modify-freply-modal" data-backdrop="static"
		data-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="staticBackdropLabel">
						${authUser.nickname}님의 댓글 수정 /삭제</h5>

					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<textarea id="modify-no" hidden="hidden"></textarea>
						<label for="modify-no-reply" class="col-form-label"> 댓글 </label>
						<textarea id="modify-no-reply" name="content" class="form-control"
							rows="10"></textarea>


						<div class="form-group">
							<label for="modify-no-replyer" hidden="hidden">댓글 작성자</label>
							<textarea id="modify-no-replyer" class="form-control"
								name="replyer-textarea" hidden="hidden">${authUser.nickname}</textarea>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">취소</button>
					<button id="freply-delete-button" type="button"
						class="btn btn-outline-danger">삭제</button>
					<button id="freply-modify-button" type="button"
						class="btn btn-outline-success">완료</button>

				</div>
			</div>
		</div>
	</div>

</body>
</html>




