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
import javax.servlet.http.HttpSession;

import jspbook2.addrbook2.MemberBean;
import util.db.DBUtil;
import util.db.StringUtil;

@WebServlet("/login1")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		response.setContentType("text/html;charset=utf-8");
		String user_id = StringUtil.nvl(request.getParameter("user_id"));
		String user_pass = StringUtil.nvl(request.getParameter("user_pass"));
		String sql = "select * from member where user_id = ? and user_pass = ? ";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		MemberBean mb = new MemberBean();
		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			pstmt.setString(2, user_pass);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				mb.setUser_id(rs.getString("user_id"));
				mb.setUser_pass(rs.getString("user_pass"));
				mb.setUser_name(rs.getString("user_name"));
			
				session.setAttribute("user", mb);
				response.sendRedirect("/jspbook2/addrbook2/index.jsp");
			} else {
				PrintWriter out = response.getWriter();
				out.print("<script>");
				out.print("alert('아이디 또는 암호가 틀렸습니다.');");
				out.print("location.href='/jspbook2/addrbook2/login.jsp';");
				out.print("</script>");
				out.flush();
			}
		} catch (Exception e) {
			
			response.sendRedirect("/jspbook2/addrbook2/login.jsp");
		} finally {
			DBUtil.close(conn, pstmt, rs);
		}
		
	}
}
