package org.zerock.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.zerock.domain.freeboard.FCriteria;
import org.zerock.domain.freply.FReplyVO;
import org.zerock.domain.member.MemberVO;
import org.zerock.service.freply.FReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/replies")
@Log4j
@AllArgsConstructor
@SessionAttributes
public class FReplyController {

	private FReplyService service;

	@PostMapping(value = "/new", consumes = MediaType.APPLICATION_JSON_VALUE, // 브라우저에서는 JOSN,서버에서는 문자열로 결과를 알려주도록
			produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> register(@RequestBody FReplyVO vo, Model model, HttpSession session) { // @RequestBodty이용하여 FReplyVO타입으로 반환하도록 지정
		/*
		 * MemberVO User =(MemberVO) session.getAttribute("authUser"); //get.jsp에서 사용할
		 * 정보 vo.setReplyer(User.getNickname());
		 */
		log.info("댓글셋팅닉넴???????????"+vo.getReplyer());
	
		log.info("vo: " + vo);

		int createCount = service.register(vo);

		log.info("count: " + createCount);

		if (createCount == 1) {
			return new ResponseEntity<>("success!!", HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		

	}
	
	@GetMapping(value = "/pages/{board_no}/{page}", produces = { MediaType.APPLICATION_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE })
	
	public ResponseEntity<List<FReplyVO>> getList(@PathVariable("page") int page, // page값은 FCriteria를 생성 해서 직접 처리
			@PathVariable("board_no") Long board_no, Model model, HttpSession session) {
	
		
		
		List<FReplyVO> list = service.getList(board_no);
		model.addAttribute("freplylist", list);
		log.info(list);
	

		return new ResponseEntity<List<FReplyVO>>(list, HttpStatus.OK);
	}

	@GetMapping(value = "/{no}",
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<FReplyVO> get(@PathVariable("no") Long no, Model model) {
		FReplyVO vo = service.read(no);
		model.addAttribute("vo", vo);
		log.info("ssssssssssssssssssssssss"+vo);
		
		return new ResponseEntity<FReplyVO>(vo, HttpStatus.OK);
	}
	
	@DeleteMapping(value = "/{no}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> remove(
			@PathVariable("no") Long no) { //replyno로 삭제 
		
		int cnt = service.remove(no);
		
		log.info(cnt);
		
		if (cnt == 1) { 
			return new ResponseEntity<>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@RequestMapping(value="/{no}", //Reply의 no로 가져와서 수정
			method = {RequestMethod.PUT, RequestMethod.PATCH}, //put 또는 patch방식 
			consumes = MediaType.APPLICATION_JSON_VALUE,
			produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> modify(
			@RequestBody FReplyVO vo, //실제 수정되는 데이터는 json 포맷 이므로 @RequestBody사용 
			@PathVariable Long no) {
		
		vo.setNo(no); //vo객체에 no 가져와서 다시 셋팅 
		
		int cnt = service.modify(vo);
		
		log.info(cnt);
		
		if (cnt == 1) {
			return new ResponseEntity<String>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
	}
}
