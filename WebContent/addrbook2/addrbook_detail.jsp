<%@page import="util.db.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="jspbook.bean.*"%>
<%@ page import="java.util.*,jspbook2.addrbook2.*"%>
<%
	MemberBean user = (MemberBean)session.getAttribute("user");
	int boardId = Integer.parseInt(StringUtil.nvl(request.getParameter("boardId"), "0"));
	AddrBean ab = new AddrBean();
	BoardBean bb = ab.getBoard(boardId);
	
	String user_id = "";
	String user_name = "";
	
	if (user != null){
		user_id = user.getUser_id();
		user_name = user.getUser_name();
	}

%>
<!DOCTYPE HTML>
<html>
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
    background-color: #d3d8ed;
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
<script type="text/javascript">
	function delcheck() {
		result = confirm("정말로 삭제하시겠습니까 ?");
	
		if(result == true){
			document.form1.action.value="delete";
			document.form1.submit();
			
		  }
		else
			return;
		}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<script src="js/bootstrap.min.js"></script>
<link href="css/bootstrap.min.css" rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판:게시글 화면</title>
</head>
<body>
<div align="center" class="form">
<H2>게시판: 게시글 화면 </H2>
<HR>
[<a href=addrbook_control.jsp?action=list>게시판 목록으로</a>] <p>
<input type="hidden" name="regId" value="<%=user_id %>" />
<table class ="table table-striped">
  <thead class="thead-white">
  <tr>
    <th>이 름</th>
    <td><input type="text" name="user_name" value="<%=StringUtil.nvl(bb.getUserName(), user_name) %>" readOnly></td>
  </tr>
   <tr>
    <th>제 목</th>
    <td><input type="text" name="title" value="<%=bb.getTitle() %>" readOnly/></td>
  </tr>
    <tr>
    <th>날 짜</th>
    <td><input type="text" name="Date" value="<%=bb.getRegDate() %>"  readOnly /></td>
  </tr>
  <tr>
    <th>내 용</th>
    <td><input type="text" name="Content" value="<%=bb.getContent() %>"  readOnly /></td>
  </tr>
  <tr>
    
    <td colspan="2" align="center">
<%	if (user_id.equals(bb.getRegId())||user_id.equals("admin")) { %>
    <input type="button" value="수정 /삭제" onclick="location.href='addrbook_edit_form.jsp?boardId=<%=boardId%>';" >
<%	} %>
     <input type="button" value="목록" onclick="location.href='index.jsp';"/></td>
</tr>
</table>
</div>
</body>
</html>