<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags/admin"%>

<!DOCTYPE html>
<html>
<head>
<script>
	var root = '${root}';
</script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet"href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://use.fontawesome.com/releases/v5.15.2/js/all.js" data-auto-replace-svg="nest"></script>
<script src="${root }/resources/js/admin/checkBox.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link rel="stylesheet" type="text/css" href="${root }/resources/css/font.css">
<script>
$(document).ready(function() {
		resize = function(){
		$("input[name=keyword]").width($(".searchBox").width()-$("#searchBtn").width()-1);
		};
		
		$(function(){
		$(".searchBox").resize(resize);
		resize();
		});		
		$("#managerChange").click(function() {
				var nicknameArr = new Array();
			var nickname = $("input[class='checkBox']:checked").each(function() {
				nicknameArr.push($(this).attr("data-nickname"));
			});
				console.log(nicknameArr);
			 swal({  
					  title: nicknameArr + "님을 관리자로 변경하시겠습니까?",
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
				if(result === false) {
					$(".checkBox").prop("checked", false);
		    	} else {
				var checkArr = new Array();
				$("input[class='checkBox']:checked").each(function() {
					checkArr.push($(this).attr("data-userno"));
				});
				console.log(checkArr);
				$.ajax({
					url : root + '/admin/adminchange',
					type : 'post',	
					data : {'chbox' : checkArr},
					success :  
							swal(nicknameArr+ "님을 관리자로 변경했습니다", "","success").then((result) => {
								if(result) {
									 location.href = root + '/admin/adminlist';
								}
							})
				});
			}
			});
		});
});

			
</script>
<style>
tr th {
	color: white;
}
input {
	width: 100%;
}
</style>

<title>산산산</title>
</head>
<body>
	<div class="container-fluid my-5">
		<div class="row">
			<div class="col-12 col-md-8 offset-md-2 table-responsive">
      <h3 style="text-align: center">회원 정보</h3>
      				<form action="${root }/admin/memberlist" id="searchForm" class="form-inline my-2 my-lg-0 mb-3 mt-3 justify-content-end">
 					<input type="hidden" name="type" value="ICN"/>
 					<div class="d-flex searchBox mt-2 align-items-center">
					<input class="form-control mr-sm-2 p-2 d-flex" type="search"
						name="keyword" value="${page.cri.keyword }" placeholder="id, 별명, 이름으로 검색 가능"
						aria-label="Search" required="required" size=resize> <input
						type="hidden" name="pageNo" value="1" /> <input type="hidden"
						name="amount" value="${page.cri.amount }" />

					<button class="btn btn-outline-info my-2 my-sm-0" id="searchBtn"
						type="submit">검색</button></div>
      				</form>
      	<table class="table table-sm mt-2">
  <thead>
    <tr>
      <th scope="col" width="10%" class="text-center bg-secondary">userno</th>
      <th scope="col" width="15%" class="text-center bg-secondary">id</th>
      <th scope="col" width="20%" class="text-center bg-secondary">password</th>
        <th scope="col" width="55%" class="text-center bg-secondary">email</th>

      </tr>
      <tr>
      <th scope="col" width="10%" class="text-center bg-secondary"><abbr title="모두선택"><input type="checkbox" name="allCheck" id="allCheck"/></abbr>
      <script>
		$("#allCheck").click(function() {
			var chk = $("#allCheck").prop("checked");
			console.log(chk);
			if(chk) {
				$(".checkBox").prop("checked", true);
			} else {
				$(".checkBox").prop("checked", false);
			}
		});
      </script></th>
       <th scope="col" width="15%" class="text-center bg-secondary">name</th>
      <th scope="col" width="20%" class="text-center bg-secondary">nicname</th>
      <th scope="col" width="55%" class="text-center bg-secondary">loc</th>
    </tr>
  </thead>
  <tbody>
  <c:forEach items="${memberList }" var="memberList">

    <tr>
      <td rowspan="2" class="text-center" style="vertical-align: middle">${memberList.no }
      <br/>
      <c:if test="${memberList.manager == 0 }">
      <input type="checkbox" class="checkBox" data-userno="${memberList.no }" data-nickname="${memberList.nickname }"/>
     </c:if>
      <script>
		$(".checkBox").click(function() {
			$("#allCheck").attr("checked", false);
		});

      </script>
      </td>
      <td>${memberList.id }</td>
      <td>${memberList.password }</td>
       <td>${memberList.email }</td>

      </tr>
      <tr>
      <td>${memberList.name }</td>
      <td>${memberList.nickname }</td>
      <td colspan="2">${memberList.loc }</td>
    </tr>
   </c:forEach>
  </tbody>
</table>
		<div class="d-flex justify-content-end">
		<abbr title="관리자로 변경하는 버튼"><button type="button" class="btn btn-outline-success" id="managerChange">to관리자</button></abbr>
		</div>
			<div class="container-sm mt-3">
				<div class="row justify-content-center">
					<nav aria-label="Page navigation example">
						<ul class="pagination">

							<c:if test="${page.prev }">
								<c:url value="/admin/memberlist" var="prevLink">
									<c:param value="${page.startPage -1 }" name="pageNo" />
									<c:param value="${page.cri.amount }" name="amount" />
									<c:param name="type" value="${page.cri.type }" />
									<c:param name="keyword" value="${page.cri.keyword }" />
								</c:url>
								<li class="page-item">
									<a class="page-link" href="${prevLink }">Previous</a>
								</li>
							</c:if>

							<c:forEach var="num" begin="${page.startPage }"
								end="${page.endPage }">
								<c:url value="/admin/memberlist" var="pageLink">
									<c:param name="pageNo" value="${num }" />
									<c:param name="amount" value="${page.cri.amount }" />
									<c:param name="type" value="${page.cri.type }" />
									<c:param name="keyword" value="${page.cri.keyword }" />
								</c:url>
								<li class="page-item ${page.cri.pageNo eq num ? 'active' : '' }">
										<a class="page-link" href="${pageLink }">${num }</a>
								</li>
							</c:forEach>

							<c:if test="${page.next }">
								<c:url value="/admin/memberlist" var="nextLink">
									<c:param name="pageNo" value="${page.endPage +1 }" />
									<c:param name="amount" value="${page.cri.amount }" />
									<c:param name="type" value="${page.cri.type }" />
									<c:param name="keyword" value="${page.cri.keyword }" />
								</c:url>
								<li class="page-item">
										<a class="page-link" href="${nextLink }">Next</a>
								</li>
							</c:if>
						</ul>
					</nav>
				</div>
			</div>
		</div>
	</div>
	</div>

</body>
</html>