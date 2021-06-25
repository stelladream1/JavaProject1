
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<style> {
  box-sizing: border-box;
  font-family: 'Noto Sans KR', sans-serif;
  border-radius: 5px;
}
 
body {
  margin: 0;
  background-color:#e8caa2;
}
 
.login-form {
    width: 300px;
    background-color: #EEEFF1;
    margin-right: auto;
    margin-left: auto;
    margin-top: 50px;
    padding: 20px;
    text-align: center;
    border: none;
    
}

.text-field {
      font-size: 14px;
      padding: 10px;
      border: none;
      width: 260px;
      margin-bottom: 10px;
 
}
 
.submit-btn {
  font-size: 14px;
  border: none;
  padding: 10px;
  width: 260px;
  background-color: #3e6fa3;
  margin-bottom: 30px;
  color: white;
}
 
.links {
    text-align: center;
}
 
.links a {
  font-size: 12px;
  color: #9B9B9B;
</style>
   <script type="text/javascript">

	function delcheck() {
		result = confirm("정말로 탈퇴하시겠습니까 ?");
	
		if(result == true){
			document.form1.action.value="addrbook_control.jsp?action=memberdelete";
			document.form1.submit();
			
		  }
		else
			return;
		}
</script>
<head>
  <title>회원 탈퇴</title>
  <meta charset="utf-8">
  <link rel="stylesheet" href="css/styles.css">
  <link href="https://fonts.googleapis.com/earlyaccess/notosanskr.css" rel="stylesheet">
</head>
<body>
  <div class="login-form">
      <form name="deleteform" method="post" action="addrbook_control.jsp?action=memberdelete">
      <input type="text" name="user_id" class="text-field" placeholder="아이디">
      <input type="password" name="user_pass" class="text-field" placeholder="비밀번호">
      <input type="submit" value="탈퇴" class="submit-btn" onclick="delcheck()" >    
       <input type="button" value="취소" class="submit-btn" onclick="location.href='login.jsp';">   
    </form>

  </div>
</body>
</html>