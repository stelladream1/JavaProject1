package util.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBUtil {
	public static Connection getConnection() {
		Connection conn = null;
		String jdbc_driver = "com.mysql.cj.jdbc.Driver";
		String jdbc_url = "jdbc:mysql://localhost:3306/jspdb?serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false&useSSL=false";
		
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, "jspbook", "ysso2805");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}

	public static void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException se) {
			}
		}

		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException se) {
			}
		}

		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException se) {
			}
		}
	}

	public static void close(PreparedStatement pstmt, ResultSet rs) {
		close(null, pstmt, rs);
	}
}
