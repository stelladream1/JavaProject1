<%@page import="util.db.StringUtil"%>
<%@page import="jspbook.bean.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8" import="jspbook2.addrbook2.*,java.util.*"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="bb" class="jspbook2.addrbook2.AddrBean"/> 
<jsp:useBean id="boardBean" class="jspbook.bean.BoardBean" />
<jsp:setProperty name="boardBean" property="*" />
<jsp:useBean id="mb" class="jspbook2.addrbook2.MemberBean"/> 

<% // 컨트롤러 요청 파라미터

int start = 1;
if(request.getParameter("start") != null){
	start = Integer.parseInt(request.getParameter("start"));
}
int end = 5;
if(request.getParameter("end") != null){
	end = Integer.parseInt(request.getParameter("end"));
}
	String action = request.getParameter("action");	// 파라미터에 따른 요청 처리
	// 주소록 목록 요청인 경우
	if(action.equals("list")) {
		int pageNo = Integer.parseInt(StringUtil.nvl(request.getParameter("pageNo"), "0"));
		int pageSize = Integer.parseInt(StringUtil.nvl(request.getParameter("pageSize"), "10"));
		int startNo = pageNo * 10;
		String category = StringUtil.nvl(request.getParameter("category"), "");
		String searchWord = StringUtil.nvl(request.getParameter("searchWord"), "");
		ArrayList<BoardBean> datas = bb.getList(startNo, pageSize, category, searchWord);
		String paramas = String.format("pageNo=%d&pageSize=%d&category=%s&searchWord=%s", pageNo, pageSize, category, searchWord);
		request.setAttribute("datas", datas);
		pageContext.forward("addrbook_list.jsp?" + paramas);
	}
	
	if(action.equals("list2")) {
		int pageNo = Integer.parseInt(StringUtil.nvl(request.getParameter("pageNo"), "0"));
		int pageSize = Integer.parseInt(StringUtil.nvl(request.getParameter("pageSize"), "10"));
		int startNo = pageNo * 10;
		String category = StringUtil.nvl(request.getParameter("category"), "");
		String searchWord = StringUtil.nvl(request.getParameter("searchWord"), "");
		ArrayList<BoardBean> datas = bb.getList(startNo, pageSize, category, searchWord);
		String paramas = String.format("pageNo=%d&pageSize=%d&category=%s&searchWord=%s", pageNo, pageSize, category, searchWord);
		request.setAttribute("datas", datas);
		pageContext.forward("NewFile1.jsp?" + paramas);
	}// 주소록 등록 요청인 경우
	else if(action.equals("insert")) {		
		if(bb.insertBoard(boardBean)) {
			response.sendRedirect("addrbook_control.jsp?action=list");
		}
		else
			throw new Exception("DB 입력오류");
	}	
	else if(action.equals("delete")) {		
		
	if(bb.deleteDB(boardBean.getBoardId())) {
		response.sendRedirect("addrbook_control.jsp?action=list");
		}
		else
			throw new Exception("DB 삭제 오류");
	}
	else if(action.equals("update")) {
		if(bb.updateDB(boardBean)) {
			response.sendRedirect("index.jsp");
		}
		else
			throw new Exception("DB 갱신오류");
}	

	else if(action.equals("memberdelete")) {		
	
		String user_id = request.getParameter("user_id");
		String user_pass = request.getParameter("user_pass");
		
				if(bb.deleteUser(user_id,user_pass)) {
					pageContext.forward("login.jsp");
			}else
			{
				throw new Exception("DB 갱신오류");
			}
		}
	else {
		out.println("<script>alert('action 파라미터를 확인해 주세요!!!')</script>");
	}
		
%>