package org.zerock.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.conquest.ConquestVO;
import org.zerock.domain.member.MEmailDTO;
import org.zerock.domain.member.MLocDTO;
import org.zerock.domain.member.MemberVO;
import org.zerock.domain.mountain.ConqStickerVO;
import org.zerock.domain.mountain.MnameVO;
import org.zerock.service.conquest.ConquestService;
import org.zerock.service.member.MemberService;
import org.zerock.service.mountain.MountainService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@AllArgsConstructor
@RequestMapping("/member/*")
@Log4j
public class MemberController {

	private MemberService service;
	
	private MountainService mountainService;

	private ConquestService conqService;

	// ##회원가입 - GET
	@GetMapping("/join")
	public void register() {
		// get형식으로는 모르겠당!
	}

	// ##회원가입 - POST
	@PostMapping("/join")
	public String register(MemberVO member, HttpServletRequest req) {

		log.info(member);
		Map<String, Boolean> errors = new HashMap<String, Boolean>();
		req.setAttribute("errors", errors);
		validate(errors, member);
		// HttpServletRequest req
		// errors가 한번이라도 남아있으면 제거를 해줘야함..

		if (errors.isEmpty()) {
			service.register(member);
			// 서비스에 일을 시키고
			log.info(member);
			return "redirect:joinSuccess";

		} else {
			return "/member/join";
		}
	}

	// ##회원가입 - 아이디 중복 체크
	@GetMapping("/idDupCheck")
	@ResponseBody
	public String idDupCheck(String inputId) {

		// 아이디 값이 있으면
		log.info(inputId);

		// 패턴 검사
		String pattern = "[a-z0-9]{4,20}"; // 영문 소문자, 숫자 4~20글자 가능
		boolean idRegex = Pattern.matches(pattern, inputId);

		if (inputId.equals("")) {
			return "-2"; // null 값 입력 -2 리턴
		} else if (idRegex) {
			// null값 아니고, 정규식이 맞을 때
			MemberVO member = service.getMemberId(inputId);

			if (member == null) {
				return "0"; // 회원이 없으면 0 리턴
			} else {
				return "-1"; // 회원있으면 -1 리턴
			}
		} else {
			// 정규식에 맞지 않을때
			return "-3";
		}
	}

	// ##회원가입 - 닉네임 중복 체크
	@GetMapping("/nicknameDupCheck")
	@ResponseBody
	public String nicknameDupCheck(String inputNickname) {

		// 닉네임 값이 있으면

		if (inputNickname.equals("")) {
			return "-2";
		} else {
			MemberVO member = service.getMemberNn(inputNickname);

			if (member == null) {
				return "0"; // 회원이 없으면 0 리턴
			} else {
				return "-1"; // 회원있으면 -1 리턴
			}
		}
	}

	// ##로그인 성공 메시지
	@GetMapping("/joinSuccess")
	public void joinSuccess() {
	}

	// ##로그인 - GET
	@GetMapping("/login")
	public String login(HttpSession session) {
		if (session.getAttribute("authUser") != null) {
			// 로그인 된 상태
//			rttr.addFlashAttribute("login", true);
			return "redirect:/index.jsp";
		} else {
			// 로그인 안된 상태
			return "member/login";
		}
	}

	// ##로그인 - POST
	@PostMapping("/login")
	@ResponseBody
	public ResponseEntity<String> login(String inputId, String inputPw, HttpSession session) {

		log.info(inputId);
		log.info(inputPw);

		MemberVO user = service.getMemberId(inputId);

		// 사용자의 아이디를 가진 회원이 있다면
		if (user != null && inputPw != null) {
			// member.getPassword(); 사용자가 적은 비밀번호
			// loginMember.getPassword(); 아이디로 검색해서 꺼낸 회원의 비밀번호

			boolean checkMemberPw = service.checkMember(inputPw, user.getPassword());

			if (checkMemberPw) {
				session.setAttribute("authUser", user);
				// 세션에 정보 담기

				// 이메일 정보 쪼개기 - 세션에 담기
				MEmailDTO emailDTO = new MEmailDTO();

				emailDTO.emailSplit(user.getEmail());
				session.setAttribute("emailDTO", emailDTO);
				
				// 주소 정보 쪼개기 - 세션에 담기
				MLocDTO locDiv = new MLocDTO();
				
				locDiv.locSplit(user.getLoc());
				session.setAttribute("locDiv", locDiv);
				
				
				/* 로그인 후 스티커판 insert */
				List<MnameVO> list = conqService.getMnameList();
				for(MnameVO m : list) {// db에 있는 산 리스트 돌려서
					long member_no = user.getNo();
					long mountain_no = m.getNo();
					log.info(m);
					if(conqService.checkCnt(member_no, mountain_no) == 0) {// Conquest table에 레코드 없으면
						ConquestVO cvo = new ConquestVO();
						cvo.setMember_no(member_no);
						cvo.setMountain_no(mountain_no);
						cvo.setConquestcnt(0);
						conqService.addConquest(cvo);// conquestcnt 0으로 세팅해서 add(insert)
					}
				}
				
				
				return new ResponseEntity<>("success", HttpStatus.OK);
			}
		}
		return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	// ##로그아웃
	@GetMapping("/logout")
	public String logout(MemberVO member, HttpSession session) {

		if (session != null) {
			session.invalidate();
		}

		return "redirect:/index.jsp";
	}

	// ##Errors
	public void validate(Map<String, Boolean> errors, MemberVO member) {
		checkEmpty(errors, member.getId(), "memberId");
		checkEmpty(errors, member.getPassword(), "memberPw");
		checkEmpty(errors, member.getPwConfirm(), "memberPwConfirm");
		checkEmpty(errors, member.getEmail(), "memberEmail");
		checkEmpty(errors, member.getName(), "memberName");
		checkEmpty(errors, member.getNickname(), "memberNickname");
		checkEmpty(errors, member.getLoc(), "memberLoc");
		// checkEmpty 메소드로 데이터가 비어있는 지 확인. 단, manager 데이터는 제외

		boolean checkMemberPw = service.checkMember(member.getPassword(), member.getPwConfirm());
		// 비밀번호가 동일한 지 확인

		if (member.getPwConfirm() != null && !checkMemberPw) {
			errors.put("pwNotMatch", true);
		}

		// 비밀번호 패턴 일치 확인
		String pattern = "([a-zA-Z]+\\d{1}\\w*)|(\\d+[a-zA-Z]{1}\\w*)\""; // 영문, 숫자 조합 2글자 이상 가능
		boolean pwRegex = Pattern.matches(pattern, member.getPassword());

		if (!pwRegex) {
			errors.put("pwPatternError", true);
		}
		
		// 주소값 @@@ 확인
		if(member.getLoc().equals("@@@")) {
			errors.put("memberLoc2", true);
		}
	}

	public void checkEmpty(Map<String, Boolean> errors, String value, String fieldName) {

		if (value == null || value.isEmpty()) {
			errors.put(fieldName, true);
		}
	}

	// ##내 정보 보기
	@GetMapping("/myHome")
	public String myHome(HttpSession session, RedirectAttributes rttr, Model model) {
		MemberVO vo = (MemberVO) session.getAttribute("authUser");
		List<ConqStickerVO> list = null;
		
		if (vo == null) {
			rttr.addFlashAttribute("notFoundUser", true);
			// 세션에 로그인 정보가 없으면
			return "redirect:/member/login";
		} else {
			list = mountainService.getConqListbyMem(vo.getNo());
			model.addAttribute("list", list);
		}
		
		return "/member/myHome";

		// return "redirect:member/myHome";
		// return "redirect:myHome";
		// redirect는 왜 안되지?
		// 왜 무한로프가 도는 거지?

		// => redirect 는 string으로 리턴, string으로 리턴되면 앞엔 폴더, 뒤엔 jsp가 붙아서 리턴됨.(servlet
		// context에서 확인 가능)
	}

	// ##내 정보 수정 - GET, void(경로로 바로 이동)
	@GetMapping("/myModify")
	public String myModifyPage(HttpSession session, RedirectAttributes rttr) {
		if (session.getAttribute("authUser") == null) {
			rttr.addFlashAttribute("notFoundUser", true);
			// 세션에 로그인 정보가 없으면
			return "redirect:/member/login";
		}
		return "/member/myModify";
	}

	// ##내 정보 수정 - POST - test
		@PostMapping("/myModify")
		public String myModify(MemberVO member, HttpSession session, HttpServletRequest req, RedirectAttributes rttr) {

			if (session.getAttribute("authUser") != null) {
				// 세션에 정보가 있을때만
				 
				MemberVO user = (MemberVO) session.getAttribute("authUser");
				log.info("user:" + user);
				log.info("member:" + member);
				log.info("memberLoc:" + member.getLoc());
				MemberVO findMember = service.getMemberId(user.getId());

				boolean checkMember = service.checkMember(findMember.getId(), member.getId());
				// 같은 아이디인지 확인

				if (checkMember) {
					
					Map<String, Boolean> errors = new HashMap<String, Boolean>();
					req.setAttribute("errors", errors);
					validate(errors, member);
					
						if(errors.isEmpty()) {
							service.modify(member);
							
							log.info("수정 서비스 실행)");
							log.info(member);
	
							session.setAttribute("authUser", member);
							// 수정된 멤버 정보를 세션에 저장
	
							MEmailDTO emailDTO = new MEmailDTO();
							emailDTO.emailSplit(member.getEmail());
							session.setAttribute("emailDTO", emailDTO);
							// 수정된 이메일 정보를 세션에 저장
							
							MLocDTO locDiv = new MLocDTO();
							locDiv.locSplit(member.getLoc());
							session.setAttribute("locDiv", locDiv);
							// 수정된 주소 정보 정보를 세션에 저장
	
							return "/member/myHome";
					} else {
						log.info("수정 실패 errors");
						log.info("errors" + errors);
						return "/member/myModify";
						
					}
				} return "redirect:/member/logout";
			} else {
				rttr.addFlashAttribute("notFoundUser", true);
				// 세션에 로그인 정보가 없으면
				return "redirect:/member/login";
				
			}
		} 
		
				
				

	
		/*
		 * // ##내 정보 수정 - POST
		 * 
		 * @PostMapping("/myModify") public String myModify(MemberVO member, HttpSession
		 * session, HttpServletRequest req, RedirectAttributes rttr) {
		 * 
		 * if (session.getAttribute("authUser") != null) { // 세션에 정보가 있을때만
		 * 
		 * MemberVO user = (MemberVO) session.getAttribute("authUser"); log.info("user:"
		 * + user); log.info("member:" + member); log.info("memberLoc:" +
		 * member.getLoc()); MemberVO findMember = service.getMemberId(user.getId());
		 * 
		 * boolean checkMember = service.checkMember(findMember.getId(),
		 * member.getId()); // 같은 아이디인지 확인
		 * 
		 * if (checkMember) { // 새롭게 set errors // 에러가 없으면 수정 진행 //같은 아이디이면,
		 * service.modify(member); log.info("수정 서비스 실행)"); log.info(member);
		 * 
		 * Map<String, Boolean> errors = new HashMap<String, Boolean>();
		 * req.setAttribute("errors", errors); validate(errors, member);
		 * 
		 * if (errors.isEmpty()) { log.info("errors:" + errors);
		 * session.setAttribute("authUser", member); // 수정된 멤버 정보를 세션에 저장
		 * 
		 * MEmailDTO emailDTO = new MEmailDTO(); emailDTO.emailSplit(member.getEmail());
		 * session.setAttribute("emailDTO", emailDTO); // 수정된 이메일 정보를 세션에 저장
		 * 
		 * MLocDTO locDiv = new MLocDTO(); locDiv.locSplit(member.getLoc());
		 * session.setAttribute("locDiv", locDiv); // 수정된 주소 정보 정보를 세션에 저장
		 * 
		 * return "/member/myHome";
		 * 
		 * } else { log.info("수정 실패 errors"); return "redirect:/member/myModify"; //혹시나
		 * 수정 실패시 수정창으로 이동 } } } else {
		 * 
		 * rttr.addFlashAttribute("notFoundUser", true); // 세션에 로그인 정보가 없으면 return
		 * "redirect:/member/login"; } log.info("수정 실패"); return
		 * "redirect:/member/myModify"; //혹시나 수정 실패시 수정창으로 이동 }
		 */
		
		
	// ##회원 삭제
	@DeleteMapping("/delete")
	@ResponseBody
	public ResponseEntity<String> delete(String userId, String pwConfirm, HttpSession session, RedirectAttributes rttr) {
		
		log.info(userId);
		log.info(pwConfirm);
		log.info("회원탈퇴 모달");

		MemberVO userMember = service.getMemberId(userId);

		if (userMember.getPassword().equals(pwConfirm)) {
			service.remove(userId);
			log.info("회원탈퇴 성공!");

			if (session != null) {
				session.invalidate();
			}
			return new ResponseEntity<>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		} 
	
}