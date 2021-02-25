<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
 <%@ taglib prefix="u" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/a076d05399.js"></script>
<script type="text/javascript" src="${root }/resources/js/restaurant/maxlength.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link rel="stylesheet" type="text/css" href="${root }/resources/css/font.css">
<script type="text/javascript">
$(document).ready(function() {
	console.log(history.state);
	if (history.state != null) {
		document.getElementById("restaurantRegisterForm").reset();
	}
	
	history.replaceState({}, null, null);
	
    $("#submitBtn").click(function byteMaxLengthCheck(){
        if(!maxLengthCheck("input2", "상호", "45")){
            return false;
        }
        if(!maxLengthCheck("input4", "연락처", "45")){
            return false;
        }
        if(!maxLengthCheck("input5", "메뉴", "500")){
            return false;
        }
        if(!maxLengthCheck("input6", "설명", "1000")){
            return false;
        }
        if(!maxLengthCheck("file-img", "파일명", "175")){
            return false;
        }
    });
	
});
</script>
<style type="text/css">
.swal-title {
  font-size: 20px;
}
.address-form #sample3_address {
	width: 370px;
}

.address-form #sample3_detailAddress {
	width: none;
}

#wrap {
	width: 350px;
	height: 450px;
}
</style>
<title>산산산</title>
</head>
<body>
			<u:topNav/>
	<div class="container-sm">

		<div class="row">
			<div class="col-12 col-sm-6 offset-sm-3">
				<form action="${root }/restaurant/register" method="post" name="register" enctype="multipart/form-data" id="restaurantRegisterForm">
					<div class="form-group">
						<label for="input1">산</label> <select name="mname"
							class="custom-select my-1 mr-sm-2 bd-highlight"
							id="input1">
							<option>북한산</option>
							<option>도봉산</option>
							<option>수락산</option>
							<option>인왕산</option>
							<option>아차산</option>
							<option>관악산</option>
						</select>
					</div>
					<div class="form-group">
						<label for="input2">상호</label> <input type="text"
							class="form-control" id="input2" name="rname" required placeholder="상호를 작성하세요">
					</div>
					<div class="form-group address-form">
						<label for="sample3_address">주소</label>
						<p>
							<input type="hidden" id="sample3_postcode" placeholder="우편번호">
							<input type="text" name="address1" id="sample3_address"
								required placeholder="주소를 작성하세요" style="width: 100%;"> <input type="text" name="address2"
								id="sample3_detailAddress" placeholder="상세주소"> <input
								type="hidden" name="address3" id="sample3_extraAddress"
								placeholder="참고항목"> <input type="button"
								onclick="sample3_execDaumPostcode()" value="주소찾기" id="input3"><br>
						</p>
						<div id="wrap"
							style="display: none; border: 1px solid; width: 500px; height: 300px; margin: 5px 0; position: relative">
							<img src="//t1.daumcdn.net/postcode/resource/images/close.png"
								id="btnFoldWrap"
								style="cursor: pointer; position: absolute; right: 0px; top: -1px; z-index: 1"
								onclick="foldDaumPostcode()" alt="접기 버튼">
						</div>
						<script
							src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
						<script type="text/javascript"
							src="${root }/resources/js/restaurant/addressAPI.js"></script>
					</div>
					<div class="form-group">
						<label for="input4">연락처</label> <input type="text"
							class="form-control" id="input4" name="contact" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{3,4}" required placeholder="ex) 000-0000-0000로 작성하세요">
					</div>
					<div class="form-group">
						<label for="input5">메뉴</label> <input type="text"
							class="form-control" id="input5" name="menu" required placeholder="메뉴를 작성하세요">
					</div>
					<div class="form-group">
						<label for="input6">설명</label><textarea class="form-control" name="description" id="input6"
						rows="6" required placeholder="설명을 작성하세요"></textarea>
					</div>
					<div>
 <label for="file-img">이미지</label> 
 <input type="file" id="file-img" name="file" accept="png, jpeg, jpg"/>
 <div class="select_img my-2"><img src="" /></div> 
 <script> 
   $("#file-img").change(function(){
    if(this.files && this.files[0]) {
     var reader = new FileReader;
     reader.onload = function(data) {
      $(".select_img img").attr("src", data.target.result).width(200);    
     }
    reader.readAsDataURL(this.files[0]);
    }
  });
  </script> 
</div>
<div class="d-flex justify-content-end">
					<button type="submit" class="btn btn-outline-success" id="submitBtn">등록</button>
					<a href="${root }/restaurant/list"><button type="button" class="btn btn-outline-secondary">취소</button></a>
					</div>
				</form>
					</div>
	</div>
	</div>

</body>
</html>