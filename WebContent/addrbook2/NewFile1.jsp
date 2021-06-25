<%@page import="util.db.StringUtil"%>
<%@page import="jspbook.bean.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8" %>
<%@ page import="java.util.*,jspbook2.addrbook2.*"%>
<%
	AddrBean ab = new AddrBean();
	String category = StringUtil.nvl(request.getParameter("category"), ""); 
	String searchWord = StringUtil.nvl(request.getParameter("searchWord"), "");
	// 페이지 넘버를 받아오는데 만약 없으면 1로 대체해준다.
	int pageNo = Integer.parseInt(StringUtil.nvl(request.getParameter("pageNo"), "0"));
	// 이건 한 페이지에 글이 몇개 나올거냐는거
	int pageSize = 10;
	// 페이지의 개수를 구한다.
	int count = ab.getCount(category, searchWord);
	int pageCount = (int) (Math.ceil((double)count /  pageSize));
	MemberBean user = (MemberBean)session.getAttribute("user");
	String user_id = "";
	String user_name = "";
	if (user != null){
		user_id = user.getUser_id();
		user_name = user.getUser_name();
	}
	
	

	String pageNum = request.getParameter("pageNum");
	if (pageNum == null){ 
		pageNum = "1";
	}

	int currentPage = Integer.parseInt(pageNum);


	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
%>


<!DOCTYPE HTML><html>   <style>
   body {
  margin: 0;
  background-color:#b9c4c1;
}
    .atag{
      text-align: center;
      }
      .atag a{
      color: #796aeb;
      }
      .write
      { text-align: right;
      	font-size: 20px;
      }
       .write a{
      color: #4249cf;
      }
      .h2 {
      text-align: center;
      }
      .body {
 	 margin: 0;
 		 background-color:#b9c4c1;
}	
      
 </style>
<head>

<script type="text/javascript">
	function content(id) {
		document.location.href="addrbook_detail.jsp?boardId="+id + "&pageNo=<%=currentPage%>";


	}
	
	function fn_goPage(pageNo) {
		document.getElementById("pageNo").value = pageNo;
		document.form.submit();
	}
	
	function fn_search() {
		document.getElementById("pageNo").value = 0;
		document.form.submit();
	}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<script src="js/bootstrap.min.js"></script>
<link href="css/bootstrap.min.css" rel="stylesheet">
<title>게시판:목록화면</title></head>
<jsp:useBean id="datas" scope="request" class="java.util.ArrayList" />
<body><div align="center"> 
<H2>게시판:목록화면</H2>
<HR>
<form name="form"  method="post" action="addrbook_control.jsp">
	<input type="hidden" name="action" value="list2" />
	<input type="hidden" id="pageNo" name="pageNo" value="<%=pageNo %>" />
	<input type="hidden" name="pageSize" value="<%=pageSize %>" />
<%	if (user == null) { %>
	<a href="login.jsp">로그인</a><P>
<%	} else { %>
	<a href="logout.jsp">로그 아웃</a><P>
<%	} %>

<%=user_id %>님 환영합니다!!
<br>
[<a href=addrbook_control.jsp?action=list>게시판 목록으로</a>]  
<div style="text-align:right; margin-right:10px;">
	<select id="category">
		<option value="">전체</option>
		<option value="TITLE" <%=category.equals("TITLE")?"selected":"" %>>제목</option>
		<option value="CONTENT" <%=category.equals("CONTENT")?"selected":"" %>>내용</option>
		<option value="USER_NAME" <%=category.equals("USER_NAME")?"selected":"" %>>작성자</option>
	</select>
	: <input type="text" id="searchWord" name="searchWord" style="width:160px; height:25px;" value="<%=searchWord %>" />
	<input type="button" value="검색" onclick="fn_search()" />
</div>
<table class ="table table-striped table-sm table-light">
  <thead class="thead-light">
    <tr>
	  <th>번 호</th>
	  <th>제 목&nbsp;&nbsp;</th>
	  <th>작성자</th>
	  <th>날짜</th>
	    </tr>
	  </thead>
	  <tbody>

	<%
		for (BoardBean bb : (ArrayList<BoardBean>) datas) {
			if (user_id.equals(bb.getRegId())){
	%>
  			<tr>
  				<td><%=bb.getBoardId() %></td>
  				<td>
  					<a href="javascript:content(<%=bb.getBoardId() %>)"><%=bb.getTitle() %></a>
  				</td>
				<td><%=bb.getRegId() %></td>
				<td><%=bb.getRegDate() %></td>
			  </tr>
			 <%
				}
		}
			 %>
		</tbody>
</table>
</form>

		<div class="write">
			<a href="addrbook_form.jsp">글쓰기</a><p>
		</div>
	</div>
<%	for (int i = 0; i < pageCount; i++) {
		if (i == pageNo) {
%>
			<strong>[<%=i + 1 %>]</strong>
<%		} else {	%>
			<a href="javascript:fn_goPage(<%=i %>);">[<%=i + 1 %>]</a>
<%		}
	}	 %>
</body>
</html>