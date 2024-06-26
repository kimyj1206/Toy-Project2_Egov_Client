<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo:wght@700&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/css/user/join.css">
<script src="<c:url value='/js/user/join.js'/>"></script>
<title>회원가입</title>
</head>
<body>	
	<div class="wrap">
    	<div class="join">
			<h2>회원가입</h2>
            <div class="join_id">
                <h4 class="requiredEle">ID</h4>
                <div class="id_container">
                	<input type="text" name="id" id="id" class="inp" placeholder="아이디를 입력해주세요." required />
                	<button class="btn btn-warning checkIdbtn" onclick="duplicatedID()" data-value="false">중복 체크</button>
            	</div>
            </div>
            
            <div class="join_pw">
                <h4 class="requiredEle">Password</h4>
                <input type="password" name="password" id="password" class="inp" placeholder="비밀번호를 입력해주세요." required />
            </div>
            
            <div class="join_name">
                <h4 class="requiredEle">Name</h4>
                <input type="text" name="name" id="name" class="inp" placeholder="이름을 입력해주세요." required />
            </div>
            
            <div class="join_phone">
                <h4 class="requiredEle">Phone</h4>
                <input type="tel" name="phone" id="phone" class="inp" placeholder="010-0000-0000" required />
            </div>
            
            <div class="join_email">
                <h4 class="requiredEle">Email</h4>
	            <input type="email" name="email" id="email" class="inp" placeholder="example@example.com" required />
			</div>
            
           	<div class="join_gender" id="gender">
	            <label><input type="radio" class="gender" name="gender" value="M">남자</label>
                <label><input type="radio" class="gender" name="gender" value="F">여자</label>
                <label><input type="radio" class="gender" name="gender" value="N" checked>선택안함</label>
			</div>      
            <div class="submit">
               <button type="button" onclick="joinSubmit()">회원가입</button>
            </div>
        </div>
    </div>
</body>
</html>