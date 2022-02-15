package DBPKG;

import java.sql.*;

public class DAO {

	public static Connection getConnection() {
		Connection conn = null;
		
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String id = "system";
		String pw = "1234";
		
		try {
                        // 데이터베이스 관련 정보(JDBC) 정보를 가져옴
			Class.forName("oracle.jdbc.OracleDriver");

                        // DriverManager를 이용하여 Connection 객체생성
			conn = DriverManager.getConnection(url, id, pw);
			
			System.out.println("DB 접속");
		} catch(Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
}