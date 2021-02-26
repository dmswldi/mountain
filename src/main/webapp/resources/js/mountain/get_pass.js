$(function(){

	var curMname = $('#mname').val();// 변경 전 이름
	
	if (result == 'modSuccess') {
		swal({
			title: "Modified",
			text: "산이 수정되었습니다.",
			icon: "success",
			button: "close"
		});
	}
	
	/* 수정 */
	$('#submitBtn').click(function(){
		/* 산 이름 pattern 체크 */
		var mname = $('#mname').val();
		var reg = /^[가-힣]+산$/;
		
		if (!mname.match(reg)){
			swal({
				title: "Not available",
				text: "산 이름을 정확히 작성해주세요.",
				icon: "warning",
				button: "close"
			});
			return ;
		}
		
/*		var status = 0;
		const st = $('[name="status"]');
		if( st[1].checked ) {
			status = 1;
		}
*/
		
		/* 산 이름 UNIQUE 체크 */
		if(curMname != mname){// mname 변경하는 경우
			$.ajax(root + '/check', {
				type: 'POST',
				contentType: 'application/json',
				data: mname
			}).fail(function(){
				swal({
					title: "Not available",
					text: "이미 존재하는 산 이름입니다.",
					icon: "warning",
					button: "close"
				});
			});
		}
		
		var no = Number($('#no').val());
		$.ajax(root + '/modify', {
			type: 'POST',
			data: new FormData($('#modifyForm')[0]),
			enctype: 'multipart/form-data',
			contentType : false,
	        processData : false,
			cache: false
		}).done(function(){
			location.replace(root + '/get?no=' + no + '&curPage=' + curPage + '&amount=' + amount + '&keyword=' + keyword);		  
		}).fail(function(){
			swal({
			  	title: "Not Allowed",
			  	text: "관리자만 이용 가능합니다.",
			  	icon: "warning",
			  	button: "close"
			}).then((isConfirm) => {
	 			if (isConfirm) {
					location.replace(root + '/get?no=' + no + '&curPage=' + curPage + '&amount=' + amount + '&keyword=' + keyword);
				}
			});
		});
	});


	/* 삭제 */
	$('#removeBtn').click(function(){
		swal({
		  title: "Are you sure?",
		  text: "게시글을 삭제하시겠습니까?",
		  icon: "warning",
		  buttons: true,
		  dangerMode: true,
		})
		.then((isConfirm) => {
		  if (isConfirm) {
			var no = $('#no').val();
		
			$.ajax(root + '/remove?no=' + no + '&curPage=' + curPage + '&amount=' + amount + '&keyword=' + keyword, 
			{
				type: 'DELETE'
			}).done(function(cri){
			  //console.log(cri);
			  //console.log(JSON.stringify(cri));
			  //console.log($.parseXML(cri));
			  //console.log($($.parseXML(cri)));
			  //console.log('curPage: ' + $($.parseXML(cri)).find('curPage'));
			  location.replace(root + '/list?curPage=' + curPage + '&amount=' + amount + '&keyword=' + keyword);
		  	}).fail(function(){
				swal({
				  	title: "Not Allowed",
				  	text: "관리자만 이용 가능합니다.",
				  	icon: "warning",
				  	button: "close"
				}).then((isConfirm) => {
		 			if (isConfirm) {
						location.replace(root + '/get?no=' + no + '&curPage=' + curPage + '&amount=' + amount + '&keyword=' + keyword);
					}
				});
		  	});
		  }
	   });
	});	


	/* 버튼 숨기기 */
	$('#cancelBtn').hide();
	$('#submitBtn').hide();
	$('#statusForm').hide();

	$('#upload').hide();
	$('.address-form').hide();
	$('#mlocation').show();
	

	/* 수정 버튼 클릭 */
	$('#modifyBtn').click(function(){// 입산여부도 수정하자!
		$(this).hide();
		$('#removeBtn').hide();
		
		$('#cancelBtn').show();
		$('#submitBtn').show();
		
		$('#modifyForm input').removeAttr('readonly');
		$('#modifyForm textarea').removeAttr('readonly');
		
		$('#statusView').hide();
		$('#statusForm').show();
		
		$('#upload').show();
		$('.address-form').show();
		$('#mlocation').hide();// 왜 안 돼??
		$('#mlocation').children().hide();
		
		$('#mname').css('border', '1px solid #ced4da');
		$('#height').css('border', '1px solid #ced4da');
		$('#description').css('border', '1px solid #ced4da');
		$('#mloc').css('border', '1px solid #ced4da');
	});
	
	/* 취소 버튼 클릭 */
	$('#cancelBtn').click(function(){
		location.reload();// form값 되돌리기
	});

	if(!isManager) {
		$('#modifyBtn').hide();
		$('#removeBtn').hide();
	}
	
	
	
	
	
	
	/* navigation */
	
	$('#mini_nav .nav-link').click(function(){
		$('.nav-link').removeClass('active');
		$(this).addClass('active');
	});
	
	/* .nav_body에 #nav_~ 넣기 */
	
	$('#nav_contents').hide();
	
	$('.nav #link1').click(function(){
		$('#nav_contents').empty();
	
		$('.nav_body').hide();
		$('#modifyBtn').show();
		$('#removeBtn').show();
		$('#nav_mountain').show();
	});
	
	$('.nav #link2').click(function(){
		$('.nav_body').hide();
		$('#listBtn').siblings('.btn').hide();
		$('#nav_contents').show();
		
		/* ajax:restaurant */
		$.ajax(root + '/restaurant/list2', {
			type: 'post',
			dataType: 'json',
			data: {type: "M", keyword: curMname, userno: userno} /* 알아서 쿼리스트링 붙음 */
		}).done(function(data){
			//console.log(data);
			$('#nav_contents').empty();
			
			$(data).each(function(index, element) {// index 0 ~
				//$('#nav_contents').append('index: '+ index + ', element: ' + element.rname + '<br>');
				//console.log(element);
				
				$('#nav_contents').append(
					'<div class="col-sm-6 res">'
					+	'<div class="card mb-3">'
					+		'<input type="hidden" value="' + element.no + '" id="rno">'
					+		'<input type="hidden" value="' + element.likeClick + '" id="likeno">'
					+		'<input type="hidden" value="' + element.dislikeClick + '" id="dislikeno">'
					+		'<img src="' + staticPath + '/' + element.filename + '" class="card-img-top img-fluid" style="height:300px; object-fit:cover; overflow:hidden;">'
					+		'<div class="card-body">'
					+			'<h5 class="card-title"><b>' + element.rname + '</b></h5>'
					+			'<p class="card-text">' + element.mname + '</p>'
					+			'<p class="card-text">' + element.rloc + '</p>'
					+			'<p class="card-text">'
					+				'대표메뉴 : ' + element.menu + '<br>'
					+				'<small class="text-muted">' + element.description
					+				'<br>전화 : ' +  element.contact + '</small><br>'
					+			'</p>'
					+			'<div class="d-flex justify-content-end align-items-center mb-1 likeDislike">'
					+				'<img data-resNo="' + element.no + '" id="like-img" src="' + root + '/resources/img/like/like_empty2.png" role="button" width="25px" height="25px">'
					+				'<span class="like mx-1">' +  element.likecnt + '</span>'
					+				'<img data-resNo="' + element.no + '" id="dislike-img" src="' + root + '/resources/img/like/dislike_empty.png" role="button" width="25px" height="25px">'
					+				'<span class="dislike ml-1">' + element.dislikecnt + '</span>'
					+			'</div>'
					+		'</div>'
					+	'</div>'
					+'</div>'
				);
				
				// 이미지 처리
				var img = $('#nav_contents .res').last().find('.likeDislike img');
				if(element.likeClick == 1) {
					img.first().attr('src', root + '/resources/img/like/like_full.png');
				} else if(element.dislikeClick == 1) {
					img.last().attr('src', root + '/resources/img/like/dislike_full.png');
				}
				
			});
			
			if(data.length == 0) {
				$('#nav_contents').append("등록된 맛집이 없습니다.");
				$('#nav_contents').wrapInner('<div class="row mt-3 ml-5" />');
			} else {
				// 닫는 태그 자동 추가 방지
				$('#nav_contents').wrapInner('<div class="row mt-5" />');
			}
			
		});
	});
	
	/* 동적 태그 이벤트 생성존 */
	$(document).on('click', '#nav_contents .likeDislike img', function() {
        if(userno == '') {
        	swal({
			  	title: "Not Allowed",
			  	text: "로그인 후 이용해주세요.",
			  	icon: "warning",
			  	button: "close"
			});
			return ;	
		}
	   
       if($(this).attr("id").startsWith('like')){// 좋아요 누르면
	       var likeno = 1;
		   var dislikeno = 0;
        
       } else {// 싫어요 누르면
       	   var likeno = 0;
		   var dislikeno = 1;
       }
       
       var resno = $(this).closest('.card').find('input').val();
  /*     var data = {
       		var like = {"likeno": likeno, "dislikeno": dislikeno, "userno": userno, "resno": resno},
       		var mno = mno
       };
        $.ajax(root + '/restaurant/like2', {
			type: 'post',
			dataType: 'json',
			data: {likeno: likeno, dislikeno: dislikeno, userno: userno, resno: resno}
		}).done(function(data){
			$('#nav_contents').empty();
			$('#nav_contents').append();
			
			
		});
    */   
	});
	
	$('.nav #link3').click(function(){
		$('.nav_body').hide();
		$('#listBtn').siblings('.btn').hide();
		$('#nav_contents').show();
		
		/* ajax:festival */
		$.ajax(root + '/festival/list2', {
			type: 'post',
			dataType: 'json',
			data: {type: "M", keyword: curMname}
		}).done(function(data){
			//console.log(data);
			$('#nav_contents').empty();
			
			$(data).each(function(index, element) {
				//$('#nav_contents').append('index: '+ index + ', element: ' + element.pname + '<br>');
			
				$('#nav_contents').append(
					'<div class="col-sm-6">'
					+	'<div class="card mb-3">'
					+		'<div class="card-body">'
					+			'<h5 class="card-title"><b>' + element.ename + '</b></h5>'
					+			'<p class="card-text">' + element.mname + '</p>'
					+			'<p class="card-text">행사시기: ' + element.month + '월</p>'
					+			'<p class="card-text">'
					+				'<small class="text-muted">' + element.description + '</small>'
					+			'</p>'
					+		'</div>'
					+	'</div>'
					+'</div>'
				);
			});
		
			if(data.length == 0) {
				$('#nav_contents').append("등록된 축제가 없습니다.");
				$('#nav_contents').wrapInner('<div class="row mt-3 ml-5" />');
			} else {
				// 닫는 태그 자동 추가 방지
				$('#nav_contents').wrapInner('<div class="row mt-5" />');
			}
		
		});
	});
	
	$('.nav #link4').click(function(){
		$('.nav_body').hide();
		$('#listBtn').siblings('.btn').hide();
		$('#nav_contents').show();
		
		/* ajax:place */
		$.ajax(root + '/place/list2', {
			type: 'post',
			dataType: 'json',
			data: {type: "M", keyword: curMname}
		}).done(function(data){
			//console.log(data);
			$('#nav_contents').empty();
			
			$(data).each(function(index, element) {
				//$('#nav_contents').append('index: '+ index + ', element: ' + element.pname + '<br>');
			
				$('#nav_contents').append(
					'<div class="col-sm-6">'
					+	'<div class="card mb-3">'
					+		'<img src="' + staticPath + '/' + element.filename + '" class="card-img-top img-fluid" style="height:300px; object-fit:cover; overflow:hidden;">'
					+		'<div class="card-body">'
					+			'<h5 class="card-title"><b>' + element.pname + '</b></h5>'
					+			'<p class="card-text">' + element.mname + '</p>'
					+			'<p class="card-text">' + element.ploc + '</p>'
					+			'<p class="card-text">'
					+				'<small class="text-muted">' + element.description + '</small>'
					+			'</p>'
					+		'</div>'
					+	'</div>'
					+'</div>'
				);
			});
		
			if(data.length == 0) {
				$('#nav_contents').append("등록된 명소가 없습니다.");
				$('#nav_contents').wrapInner('<div class="row mt-3 ml-5" />');
			} else {
				// 닫는 태그 자동 추가 방지
				$('#nav_contents').wrapInner('<div class="row mt-5" />');
			}
		
		});
	});
	
	$('.nav #link5').click(function(){
		$('.nav_body').hide();
		$('#listBtn').siblings('.btn').hide();
		$('#nav_contents').show();
		//$('#nav_map').show();
		
		
		/* ajax:map api */
		//var options = { //지도를 생성할 때 필요한 기본 옵션
		//	center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
		//	level: 3 //지도의 레벨(확대, 축소 정도)
		//};
		//var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
		
		
		$('#nav_contents').empty();
		
		$('#nav_contents').append("준비중입니다.");
		$('#nav_contents').wrapInner('<div class="row mt-3 ml-5" />');
		
	});
	
	/*
	$(window).on("mounseover", "img", function(){
		$(this).hover('background-color', 'red');
		$(this).css('background-color', 'red');
	});
	*/
	
});