package jspbook2.addrbook2;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import jspbook.bean.BoardBean;


public class AddrBean { 
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	String jdbc_driver = "com.mysql.cj.jdbc.Driver";
	
	String jdbc_url = "jdbc:mysql://localhost:3306/jspdb?serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false&useSSL=false&autoReconnect=true";
	// DB�뿰寃� 硫붿꽌�뱶
	void connect() {
		try {
			Class.forName(jdbc_driver);

			conn = DriverManager.getConnection(jdbc_url,"jspbook","ysso2805");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	void disconnect() {
		if(rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} 
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} 
		if(conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	

	public boolean updateDB(BoardBean bb) {
		connect();
			
		String sql ="update board set title=?,content=?, reg_date = now() where board_id =?";		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bb.getTitle());
			pstmt.setString(2, bb.getContent());
			pstmt.setInt(3, bb.getBoardId());
			pstmt.executeUpdate();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean deleteDB(int BOARD_ID) {
		connect();
		
		String sql ="delete from board where BOARD_ID=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, BOARD_ID);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
	
	// �떊洹� 二쇱냼濡� 硫붿떆吏� 異붽� 硫붿꽌�뱶


	public boolean insertBoard(BoardBean bb) {
		connect();

		String sql ="insert into board(title, content, reg_id, password,reg_date) values(?,?,?,?, now())";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bb.getTitle());
			pstmt.setString(2, bb.getContent());
			pstmt.setString(3, bb.getRegId());
			pstmt.setString(4, bb.getPassword());
			pstmt.executeUpdate();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		
	}

	public ArrayList<BoardBean> getList(int startNo, int pageSize, String category, String searchWord) {
		connect();
		
		StringBuffer sql = null;
		BoardBean bb = null;
		ArrayList<BoardBean> list = new ArrayList<>();
		
		try {
			sql = new StringBuffer();
			sql.append("\n SELECT A.BOARD_ID                                               ");
			sql.append("\n      , A.TITLE                                                  ");
			sql.append("\n      , A.CONTENT                                                ");
			sql.append("\n      , A.REG_ID                                                 ");
			sql.append("\n      , B.USER_NAME                                              ");
			sql.append("\n      , DATE_FORMAT(A.REG_DATE, '%Y-%m-%d %H-%i-%s') AS REG_DATE ");
			sql.append("\n   FROM BOARD AS A                                               ");
			sql.append("\n      , MEMBER AS B                                              ");
			sql.append("\n  WHERE A.REG_ID = B.USER_ID                                     ");
			if (category.equals("TITLE")) {
				sql.append("\n    AND A.TITLE LIKE CONCAT('%', ?, '%')                     ");
			
			} else if (category.equals("CONTENT")) {
				sql.append("\n    AND A.CONTENT LIKE CONCAT('%', ?, '%')                 ");
				
			} else if (category.equals("USER_NAME")) {
				sql.append("\n    AND B.USER_NAME LIKE CONCAT('%', ?, '%')                 ");
				
			} else {
				sql.append("\n    AND (A.TITLE LIKE CONCAT('%', ?, '%')                    ");
				sql.append("\n         OR B.USER_NAME LIKE CONCAT('%', ?, '%')            ");
				sql.append("\n         OR A.CONTENT LIKE CONCAT('%', ?, '%'))            ");
			}
			sql.append("\n LIMIT ?, ?                                                      ");
			String output = sql.toString();
			if (category.equals("")) {
				output = output.replaceFirst("[?]", String.format("'%s'", searchWord));
				output = output.replaceFirst("[?]", String.format("'%s'", searchWord));
				output = output.replaceFirst("[?]", String.format("'%s'", searchWord));
			} else {
				output = output.replaceFirst("[?]", String.format("'%s'", searchWord));
			}
			output = output.replaceFirst("[?]", String.format("%d", startNo));
			output = output.replaceFirst("[?]", String.format("%d", pageSize));
			pstmt = conn.prepareStatement(sql.toString());
			int idx = 1;
			if (category.equals("")) {
				pstmt.setString(idx++, searchWord);
				pstmt.setString(idx++, searchWord);
				pstmt.setString(idx++, searchWord);
			} else {
				pstmt.setString(idx++, searchWord);
			}
			pstmt.setInt(idx++, startNo); //
			pstmt.setInt(idx++, pageSize);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				bb = new BoardBean();
				bb.setBoardId(rs.getInt("BOARD_ID"));
				bb.setTitle(rs.getString("TITLE"));
				bb.setContent(rs.getString("CONTENT"));
				bb.setRegId(rs.getString("REG_ID"));
				bb.setUserName(rs.getString("USER_NAME"));
				bb.setRegDate(rs.getString("REG_DATE"));
				list.add(bb);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	
		return list;
	}
	
	public int getCount(String category, String searchWord){
		int count = 0;
		StringBuffer sql = null;
		try {
			connect();
			sql = new StringBuffer();
			sql.append("\n SELECT COUNT(*) ");
			sql.append("\n   FROM BOARD AS A");
			sql.append("\n      , MEMBER B ");
			sql.append("\n  WHERE A.REG_ID = B.USER_ID ");
			if (category.equals("TITLE")) {
				sql.append("\n    AND A.TITLE LIKE CONCAT('%', ?, '%')                     ");
			} 
			 else if (category.equals("CONTENT")) {
						sql.append("\n    AND A.CONTENT LIKE CONCAT('%', ?, '%')                 ");
			}  else if (category.equals("USER_NAME")) {
				sql.append("\n    AND B.USER_NAME LIKE CONCAT('%', ?, '%')                 ");
				
			}			
			else {
				sql.append("\n    AND (A.TITLE LIKE CONCAT('%', ?, '%')                    ");
				sql.append("\n         OR B.USER_NAME LIKE CONCAT('%', ?, '%')	          ");
				sql.append("\n         OR A.CONTENT LIKE CONCAT('%', ?, '%'))            ");
			}
			String output = sql.toString();
			if (category.equals("")) {
				output = output.replaceFirst("[?]", String.format("'%s'", searchWord));
				output = output.replaceFirst("[?]", String.format("'%s'", searchWord));
				output = output.replaceFirst("[?]", String.format("'%s'", searchWord));
			} else {
				output = output.replaceFirst("[?]", String.format("'%s'", searchWord));
			}

			pstmt = conn.prepareStatement(sql.toString());
			int idx = 1;
			if (category.equals("")) {
				pstmt.setString(idx++, searchWord);
				pstmt.setString(idx++, searchWord);
				pstmt.setString(idx++, searchWord);
			} else {
				pstmt.setString(idx++, searchWord);
			}
			rs = pstmt.executeQuery();
			if(rs.next()){
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return count; // 총 레코드 수 리턴
	}
	public BoardBean getBoard(int boardId) {
		connect();
		
		String sql = "SELECT A.BOARD_ID, A.TITLE, A.CONTENT, A.REG_ID, B.USER_NAME\n" + 
				"     , DATE_FORMAT(A.REG_DATE, '%Y-%m-%d %H-%i-%s') AS REG_DATE\n" + 
				"  FROM BOARD AS A\n" + 
				"     , MEMBER AS B\n" + 
				" WHERE A.REG_ID = B.USER_ID" +
				"   AND A.BOARD_ID = ?";
		BoardBean bb = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardId);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bb = new BoardBean();
				bb.setBoardId(rs.getInt("BOARD_ID"));
				bb.setTitle(rs.getString("TITLE"));
				bb.setContent(rs.getString("CONTENT"));
				bb.setRegId(rs.getString("REG_ID"));
				bb.setUserName(rs.getString("USER_NAME"));
				bb.setRegDate(rs.getString("REG_DATE"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return bb;
	}
	
	public boolean deleteUser(String user_id,String user_pass) {
		connect();
		String sql = "DELETE FROM MEMBER WHERE USER_ID=? AND USER_PASS = ?" ;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			pstmt.setString(2, user_pass);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
	} return true;

  } 
}