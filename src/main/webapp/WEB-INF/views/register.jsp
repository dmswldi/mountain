<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="#" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://use.fontawesome.com/releases/v5.15.2/js/all.js" data-auto-replace-svg="nest"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link rel="stylesheet" type="text/css" href="${root }/resources/css/font.css">
<link rel="stylesheet" type="text/css" href="${root }/resources/css/mountain/register.css">
<script>
var result = '${result}';
</script>
<script src="${root }/resources/js/mountain/register.js"></script>
<title>산산산</title>
</head>
<body>
<m:topNav />

<div class="container-sm my-5">
	<div class="row">
		<div class="col-12 col-sm-6 offset-sm-3">
			<h3 class="text-center">산 정보 등록</h3>
			<form id="registerForm" method="post" enctype="multipart/form-data">
				<div class="form-group">
					<label for="mname">이름</label>
					<input type="text" class="form-control" name="mname" id="mname" value="${mountain.mname }" required placeholder="산 이름을 입력하세요.">
					<small class="text-success">공백 없이 한글을 이용하여 ~산으로 끝나게 작성해주세요.</small>
				</div>

				<div class="form-group address-form">
						<label for="sample3_address">위치</label>
						<p class="d-flex">
							<input type="hidden" id="sample3_postcode" placeholder="우편번호">
							<input type="text" class="form-control" name="mloc" id="sample3_address" required placeholder="주소를 작성하세요" style="width: 100%;" required>
							<input type="hidden" id="sample3_detailAddress" placeholder="상세주소">
							<input type="hidden" id="sample3_extraAddress" placeholder="참고항목">
							<input type="button" class="btn" onclick="sample3_execDaumPostcode()" value="주소찾기" id="input3">
						</p>
						<div id="wrap" style="display: none; border: 1px solid; width: 500px; height: 300px; margin: 5px 0; position: relative">
							<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap"
								style="cursor: pointer; position: absolute; right: 0px; top: -1px; z-index: 1"
								onclick="foldDaumPostcode()" alt="접기 버튼">
						</div>
						<script
							src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
						<script type="text/javascript" src="${root }/resources/js/restaurant/addressAPI.js"></script>
				</div>

				<div class="form-group">
					<label for="height">해발고도</label>
					<input type="text" class="form-control" name="height" id="height" value="${mountain.height }" required 
						placeholder="산의 높이를 입력하세요." pattern="[0-9]+">
					<small id="onlyNum" class="text-danger">숫자만 입력 가능합니다.</small>
				</div>
	
				<div class="form-group">
				  	<label for="status0">입산여부</label>
				  	<c:if test="${mountain.status eq 0}">
				  		<c:set var="status0" value="checked" />
				  	</c:if>
				  	<c:if test="${mountain.status eq 1}">
				  		<c:set var="status1" value="checked" />
				  	</c:if>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="status" id="status0" value="0" ${status0 } checked>
					  <label class="form-check-label" for="status0">가능</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="status" id="status1" value="1" ${status1 }>
					  <label class="form-check-label" for="status1">불가능</label>
					</div>
				</div>
	
				<div class="form-group">
					<label for="description">상세설명</label>
				    <textarea class="form-control" name="description" id="description" rows="3" required>${mountain.description }</textarea>					
				</div>
				<%-- 
				<div class="form-group">
					<label for="file">파일</label>
					<input class="form-control" type="file" accept="image/*" name="file" id="file">
				</div>
				--%>
				
				<div id="upload" class="form-group">
					<label for="file">파일</label>
				    <div class="fileDrop p-5">
				        <p class="text-center"><i class="fa fa-paperclip"></i>첨부파일을 드래그해주세요.</p>
				    </div>
					<input class="form-control" type="file" accept="image/*" name="file" id="file">
				</div>
				
				<button id="submitBtn" class="btn btn-success float-right">등록</button>
				<a href="javascript:history.go(-1);" class="btn btn-secondary float-left">취소</a>
			</form>
		</div>
	</div>
</div>
</body>
</html>