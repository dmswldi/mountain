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
	
	/* .nav_body에 #nav_~ 넣기 */
	
	$('.nav #link1').click(function(){
		$('.nav_body').hide();
		$('#modifyBtn').show();
		$('#removeBtn').show();
		$('#nav_mountain').show();
	});
	
	$('.nav #link2').click(function(){
		$('.nav_body').hide();
		$('#listBtn').siblings('.btn').hide();
		$('#nav_restaurant').show();
		
		/* ajax:restaurant */
		$.ajax(root + '/restaurant/list2', {
			dataType: 'json',
			data: {type: "M", keyword: curMname} /* 알아서 쿼리스트링 붙음 */
		}).done(function(data){
			//console.log(data);
			$('#nav_restaurant').empty();
			
			$(data).each(function(index, element) {// index 0 ~
				//$('#nav_restaurant').append('index: '+ index + ', element: ' + element.rname + '<br>');
				
				// 좋아요 안 눌림
		

				$('#nav_restaurant').append(
					'<div class="col-sm-6">'
					+	'<div class="card mb-3">'
					+		'<img src="' + staticPath + '/' + element.filename + '" class="card-img-top img-fluid">'
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
					+				'<img data-resNo="' + element.no + '" id="like-img' + index+1 + '" src="' + root + '/resources/img/like/like_empty2.png" width="25px" height="25px">'
					+				'<span>&nbsp;' +  element.likecnt + '&nbsp;</span>'
					+				'<img data-resNo="' + element.no + '" id="dislike-img' + index+1 + '" src="' + root + '/resources/img/like/dislike_empty.png" width="25px" height="25px">'
					+				'<span>&nbsp;' + element.dislikecnt + '</span>'
					+			'</div>'
					+		'</div>'
					+	'</div>'
					+'</div>'
				);
				
			});
			
			if(data.length == 0) {
				$('#nav_restaurant').append("등록된 맛집이 없습니다.");
				$('#nav_restaurant').wrapInner('<div class="row mt-3 ml-5" />');
			} else {
				// 닫는 태그 자동 추가 방지
				$('#nav_restaurant').wrapInner('<div class="row mt-5" />');
			}
			
		});
	});
	
	$('.nav #link3').click(function(){
		$('.nav_body').hide();
		$('#listBtn').siblings('.btn').hide();
		$('#nav_festival').show();
		
		/* ajax:festival */
	});
	
	$('.nav #link4').click(function(){
		$('.nav_body').hide();
		$('#listBtn').siblings('.btn').hide();
		$('#nav_place').show();
		
		/* ajax:place */
		$.ajax(root + '/place/list2', {
			dataType: 'json',
			data: {type: "M", keyword: curMname}
		}).done(function(data){
			//console.log(data);
			$('#nav_place').empty();
			
			$.each(function(index, element){
				$('#nav_place').append(
					'<div class="col-sm-6">'
					+	'<div class="card mb-3">'
					+		'<img src="' + staticPath + '/' + element.filename + '" class="card-img-top img-fluid">'
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
				$('#nav_place').append("등록된 명소가 없습니다.");
				$('#nav_place').wrapInner('<div class="row mt-3 ml-5" />');
			} else {
				// 닫는 태그 자동 추가 방지
				$('#nav_place').wrapInner('<div class="row mt-5" />');
			}
		
		});
	});
	
	$('.nav #link5').click(function(){
		$('.nav_body').hide();
		$('#listBtn').siblings('.btn').hide();
		$('#nav_map').show();
		
		/* ajax:map api */
	});
	
	
});