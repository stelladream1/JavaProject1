<%@page import="jspbook.bean.BoardBean"%>
<%@page import="jspbook2.addrbook2.AddrBean"%>
<%@page import="util.db.StringUtil"%>
<%@page import="jspbook2.addrbook2.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%-- errorPage="error.jsp"%> --%>
<%
	MemberBean user = (MemberBean) session.getAttribute("user");
	String user_id = "";
	String user_name = "";
	if (user == null) {
%>
	<html>
	<head>
	</head>
	<body>
	<script>
	alert("잘못된 방식으로 접근하셨습니다.");
	location.href = "addrbook_list.jsp";
	</script>
	</body>
	</html>
<%	} else {
		int boardId = Integer.parseInt(StringUtil.nvl(request.getParameter("boardId"), "0"));
		user_name = user.getUser_name();
		user_id = user.getUser_id();
%>
<!DOCTYPE>
<html>
<head></head>
<style>
{
  box-sizing: border-box;
  font-family: 'Noto Sans KR', sans-serif;
  border-radius: 5px;
}
.p{
        text-align: center;
    }

    .atag{
      text-align: center;
      }
      .atag a{
      color: #796aeb;
      }
.form {
    width: 900px;
    background-color: #EEEFF1;
    margin-right: auto;
    margin-left: auto;
    margin-top: auto;
    padding: 10px;
    text-align: left;
    border: none;
    
} 

.submit {
  font-size: 14px;
  border: none;
  padding: 7px;
  width: 290px;
  background-color: #3e6fa3;
  margin-bottom: 30px;
  color: white;
  align : center;
  float : rigjht;
   }
   
.input {
 font-size: 14px;
      padding: 10px;
      border: none;
      width: 260px;
      margin-bottom: 10px;
 

}
 </style>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<script src="js/bootstrap.min.js"></script>
<link href="css/bootstrap.min.css" rel="stylesheet">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>게시판:작성화면</title>
</head>
<body>
<div align="center" class="form">
<H2>게시판:작성화면 </H2>
<HR>
<div align="center" class="form">
[<a class= "atag" href=addrbook_control.jsp?action=list>게시판 목록으로</a>] <P> </div>
<form name=form1 method=post action=addrbook_control.jsp>
<input type=hidden name="action" value="insert">
<input type="hidden" name="regId" value="<%=user_id %>" />
<table class ="table table-striped">
  <thead class="thead-white">
  <tr>
    <th>이 름</th>	
    <td><input type="text" name="userName" value="<%=user_id %>" readOnly /></td>
  </tr>
  <tr>
    <th>제 목</th>	
    <td><input type="text" name="title" placeholder="제목을 입력해주세요" maxlength="15"></td>
  </tr>

  <tr>
    <th>내용</th>
    <td><input type="text" name="content" placeholder="내용을 입력하세요" ></td>
  </tr>
  <tr>
    <th>비밀번호</th>
    <td><input type="text" name="content" placeholder="내용을 입력하세요" ></td>
  </tr>
  <tr>
    <td colspan="2" align="center"><input type="submit" value="저장">
    <input type="button" value="목록" onclick="location.href='index.jsp';"/></td>
</tr>
</table>
</form>
</div>
</body>
</html>
<%	}	%>
