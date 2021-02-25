<%@ tag language="java" pageEncoding="UTF-8"%>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="${root }/admin/index">관리자페이지</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarNavDropdown">
    <ul class="navbar-nav">
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
         게시글 등록
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
          <a class="nav-link dropdown-item" data-href="${root }/notice/register">공지/이벤트</a>
          <a class="nav-link dropdown-item" data-href="${root }/register">산정보</a>
          <a class="nav-link dropdown-item" data-href="${root }/festival/register">축제</a>
          <a class="nav-link dropdown-item" data-href="${root }/place/register">명소</a>
          <a class="nav-link dropdown-item" data-href="${root }/restaurant/register">맛집</a>
        </div>
      </li>
       <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
         게시글 리스트
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
          <a class="nav-link dropdown-item" data-href="${root }/notice/list">공지/이벤트</a>
          <a class="nav-link dropdown-item" data-href="${root }/list">산정보</a>
          <a class="nav-link dropdown-item" data-href="${root }/festival/list">축제</a>
          <a class="nav-link dropdown-item" data-href="${root }/place/list">명소</a>
          <a class="nav-link dropdown-item" data-href="${root }/restaurant/list">맛집</a>
        </div>
      </li>
      <li class="nav-item">
        <a class="nav-link" data-href="${root }/admin/memberlist" role="button">회원 정보</a>
      </li>
            <li class="nav-item">
        <a class="nav-link" data-href="${root }/admin/adminlist" role="button">관리자 정보</a>
      </li>
    </ul>
    <div class="ml-auto mt-auto">
    	<span style="font-size: small;">총 방문자 : ${total }&nbsp;&nbsp;오늘 방문자 : ${today }&nbsp;&nbsp;총 회원수 : ${memberCnt }</span>
  </div>
  </div>
</nav>

