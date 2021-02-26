   $(document).ready(function() {
      
      // ##패스워드 에러, 패스워드 null 숨기기
      function hideSpans() {
         $('#pwError').hide();
         $('#pwNull').hide();   
      }
      
      hideSpans();
      
      // ##탈퇴 모달창에서 '취소(x)' 버튼 클릭했을 때
      $("#memberDeleteCancel1").click(function() {
         $('#pwConfirm').val('');
         $('#pwError').hide();
         $('#pwNull').hide();
      });   
      
      // ##탈퇴 모달창에서 '취소' 버튼 클릭했을 때
      $("#memberDeleteCancel2").click(function() {
         $('#pwConfirm').val('');
         $('#pwError').hide();
         $('#pwNull').hide();
      });   
      
      // ##탈퇴 모달창에서 '탈퇴' 버튼 클릭했을때
      $("#memberDelete").click(function() {
         $('#pwError').hide();
         $('#pwNull').hide();
   
         var userId = $(this).attr("data-userId"); //attribute 값
         var pwConfirm = $('#pwConfirm').val(); //value값
         //변수에 원하는 값을 넣어준다.
      
         $.ajax("/mountain/member/delete?" + $.param({userId: userId, pwConfirm:pwConfirm}), { //경로
            method: "delete" //메소드 방법(controller에서 deleteMapping으로 표시)
            //data:{id: userId, pw:pwConfirm}로 보내줬을때 읽어오질 못함
            //=> delete 방식으로 보냈을때, delete는 body가 없기 때문에 요청이 오류, 거절이 일어날 수 있다.
            //=> 해결 : 파라미터로 값을 붙여서 보내주자!
            
         }).fail(function() {
            console.log("삭제 실패");
            if($('#pwConfirm').val() == '') { 
               $('#pwNull').show();   //비밀번호를 입력해주세요.
            } else {
               $('#pwError').show();   //비밀번호가 일치하지 않습니다.
            }
   
         }).done(function() {
            console.log("삭제 완료");
            $("#memberDeleteModal").modal('hide');
            $("#memberDeleteSuccessModal").modal('show');
            
         });
      });
      
      
      
      /* conquestcnt */
      $(".sticker").each(function(index, item) {
         var stickerNum = $(item).closest("table").find("[name=conquestcnt]").val();
         
         for (var i = 0; i < stickerNum; i++) {
            switch (i % 3) {
            case 0:
               $(item).append('<div><img src="' + root + '/resources/img/conquest/mountain_black.png" /> </div>'  ); 
               break;
            case 1:
               $(item).append('<div><img src="' + root + '/resources/img/conquest/mountain_yellow.png" /> </div>'  ); 
               break;
            case 2:
               $(item).append('<div><img src="' + root + '/resources/img/conquest/mountain_blue.png" /> </div>'  ); 
               break;
            }
            
         }
      });
      
      
      
      
      
      /* 카운트 ajax로 데이터 보내기 */
      $(".up-btn, .down-btn").click(function(e) {
         e.preventDefault();
         updateConquest($(this).closest("form").serialize());//엘리멘트의 가장가까운 level만 변경
      });
      
      
      
      
      
   });
   
   
   
/* update */
function updateConquest(data, callback, error) {
   console.log(JSON.stringify(data));
   console.log(data);
   
   $.ajax({
      type : "post",
      url : root + "/Conquest/updateConquest", // 컨트롤러 매핑
      //contentType: "application/json",// 이 타입으로 data를 보내겠다 컨트롤러에
      data : data, // form data를 json
      success : function(result, stauts, xhr) {
         if (result) {
            alert('정복횟수가 업데이트 되었습니다.' );
      /*    $('sticker' ).append('<div><img src='<c:out value="${root }/resources/img/conquest/mountain_black.png"/>' /> </div>'  );
              */
         }
      },
      error : function(xhr, status, er) {
         if (error) {
            error(er);
         }
      }
   });
}



/* 정복산 count */
function Count(type, ths) {
   var $input = $(ths).parents("td").find("input[name='conquestcnt']");// name을 찾아 $input에 넣음
   var CCCount = Number($input.val()); //Number타입변환
   var MCount = Number($(ths).parents("div").find("td.maxconquest").html());//maxconquest찾음
   if (type == 'p') { //plus약자
      if (CCCount < MCount)
         $input.val(Number(CCCount) + 1);// MAX값보다 작을때 +
   } else {
      if (CCCount > 0)
         $input.val(Number(CCCount) - 1); //입력값이 0이상일경우에 -
   }
   $(ths).closest('table').find('.sticker' ).empty();
   for (var i = 0; i < $input.val(); i++) {
      //$(ths).closest('table').find('.sticker' ).append('<div><img src="<c:out value="' + root + '/resources/img/conquest/mountain_black.png"/>" /> </div>'  ); 
      switch (i % 3) {
      case 0:
         $(ths).closest('table').find('.sticker' ).append('<div><img src="' + root + '/resources/img/conquest/mountain_black.png" /> </div>'  );
         break;
      case 1:
         $(ths).closest('table').find('.sticker' ).append('<div><img src="' + root + '/resources/img/conquest/mountain_yellow.png" /> </div>'  ); 
         break;
      case 2:
         $(ths).closest('table').find('.sticker' ).append('<div><img src="' + root + '/resources/img/conquest/mountain_blue.png" /> </div>'  );
         break;
      }
   }
}