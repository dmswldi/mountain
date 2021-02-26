<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags"%>

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
		<script type="text/javascript" src="${root }/resources/js/place/maxlength.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://kit.fontawesome.com/a076d05399.js"></script>
<link rel="stylesheet" type="text/css" href="${root }/resources/css/font.css">
<script>
$(document).ready(function() {
	console.log(history.state);
	if (history.state != null) {
		document.getElementById("placeModifyForm").reset();
	}
	
	history.replaceState({}, null, null);
	
    $("#submitBtn").click(function byteMaxLengthCheck(){
        if(!maxLengthCheck("input2", "명소", "45")){
            return false;
        }
        if(!maxLengthCheck("input3", "주소", "200")){
            return false;
        }
        if(!maxLengthCheck("input4", "설명", "1000")){
            return false;
        }
        if(!maxLengthCheck("file-img", "파일명", "175")){
            return false;
        }
    });
});
</script>
<style type="text/css">
.address-form #sample3_address {
	width: 60%;
}

.address-form #sample3_detailAddress {
	width: 25%;
}

.address-form #address_btn {
	width: 100px;
}

#wrap {
	width: 350px;
	height: 450px;
}
.select_img img {
	width: 200px;
}
h3 {
 margin-top: 20px;
 text-align: center;
 margin-bottom: 35px;
}
</style>
<title>Insert title here</title>
</head>
<body>
	<u:topNav/>
	<div class="container-sm">
		<h3>명소게시판 수정</h3>
		<div class="row">
			<div class="col-12 col-sm-6 offset-sm-3">

				<form action="${root }/place/modify" method="post" id ="placeModifyForm" enctype="Multipart/form-data">
					<input type="hidden" name="no" value="${param.no }"> <input
						type="hidden" name="mountain_no"
						value="${place.mountain_no }">
					<div class="form-group">
						<label for="input1">산</label> <select name="mname"
							class="custom-select my-1 mr-sm-2 bd-highlight" id="input1">
							<option ${place.mname eq '북한산' ? 'selected' : ''}>북한산</option>
							<option ${place.mname eq '도봉산' ? 'selected' : ''}>도봉산</option>
							<option ${place.mname eq '수락산' ? 'selected' : ''}>수락산</option>
							<option ${place.mname eq '인왕산' ? 'selected' : ''}>인왕산</option>
							<option ${place.mname eq '아차산' ? 'selected' : ''}>아차산</option>
							<option ${place.mname eq '관악산' ? 'selected' : ''}>관악산</option>
						</select>
					</div>
					<div class="form-group">
						<label for="input2">명소</label> <input type="text"
							class="form-control" id="input2" name="pname"
							value="${place.pname }" required>
					</div>
					<div class="form-group address-form">
						<label for="input3">주소</label>
						<input type="text"
							class="form-control" id="input3" name="ploc" required value="${place.ploc }">
						</div>
					<div class="form-group">
						<label for="input4">설명</label> 
						<textarea class="form-control" name="description" id="input4"
							rows="6" required>${place.description }</textarea>

					</div>
					<div>
					<label for="file-img">이미지</label> <input type="file" id="file-img"
						name="file" />
					<div class="select_img my-2">
						<img src="${staticPath }/${place.filename}" />
						  <input type="hidden" name="file" value="" />

					</div>
					<script>
						$("#file-img").change(
								function() {
									if (this.files && this.files[0]) {
										var reader = new FileReader;
										reader.onload = function(data) {
											$(".select_img img").attr("src",
													data.target.result).width(
													200);
										}
										reader.readAsDataURL(this.files[0]);
									}
								});
					</script></div>
					<div class="d-flex justify-content-end">
									<input type="hidden" name="pageNo" value="${cri.pageNo}" />
						<input type="hidden" name="amount" value="${cri.amount }" />
							<input type="hidden" name="type" value="${cri.type }" />
								<input type="hidden" name="keyword" value="${cri.keyword }" />
			<button type="submit" class="btn btn-outline-success m-1">확인</button>
			<c:url value="/place/list" var="listLink">
				<c:param name="pageNo" value="${cri.pageNo}" />
				<c:param name="amount" value="${cri.amount }" />
				<c:param name="type" value="${cri.type }" />
				<c:param name="keyword" value="${cri.keyword }" />
			</c:url>
			<a href="${listLink }"><button type="button"
					class="btn btn-outline-secondary m-1">취소</button></a></div>
			</form>

		</div>
	</div>
	</div>

</body>
</html>