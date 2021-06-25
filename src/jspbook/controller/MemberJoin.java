package jspbook.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import util.db.DBUtil;
import util.db.StringUtil;

@WebServlet("/join1")
public class MemberJoin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		PrintWriter out = null;

		String user_id = StringUtil.nvl(request.getParameter("user_id"));
		String user_pass = StringUtil.nvl(request.getParameter("user_pass"));
		String user_name = StringUtil.nvl(request.getParameter("user_name"));
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		StringBuffer sql = null;

		try {
			conn = DBUtil.getConnection();

			out = response.getWriter();

			sql = new StringBuffer();
			sql.append("\n insert into jspdb.member(user_id, user_pass,user_name)    ");
			sql.append("\n                   values(?, ?, ?)                  ");		
			pstmt = conn.prepareStatement(sql.toString());
			int idx = 1;
			pstmt.setString(idx++, user_id);
			pstmt.setString(idx++, user_pass);
			pstmt.setString(idx++, user_name);
			int result = pstmt.executeUpdate();
			out.print("<script>");
			if (result > 0) {
				out.print("alert('회원가입이 정상적으로 완료되었습니다.');");
				out.print("location.href = '/jspbook2/addrbook2/login.jsp';");
			} else {
				out.print("alert('회원가입에 실패했습니다.');");
				out.print("location.href = '/jspbook2/addrbook2/index.jsp';");
			}
			out.print("</script>");
		} catch (Exception e) {
			response.sendRedirect("/jspbook2/addrbook2/login.jsp");
		} finally {
			DBUtil.close(conn, pstmt, rs);
		}
		
	}
}
