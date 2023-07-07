package test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionTest {

	public static void main(String[] args) {
		Connection conn = null;
		try {
			// 1. JDBC Driver Class 로딩
			// 오타 없게 하자.
			Class.forName("org.mariadb.jdbc.Driver");
			
			// 2. 연결하기
			// 연결 정보를 getConnection에 줘야 함
			// 오타 없게 하자.
			// jdbc:mariadb://(서버 IP 주소):(mysql 포트 번호, 기본 3306)/(db이름)?옵션
			String url = "jdbc:mariadb://192.168.0.162:3306/webdb?charset=utf8";
			// 필요한 연결 정보: url, username, password
			conn = DriverManager.getConnection(url, "webdb", "webdb");
			
			System.out.println("연결 성공");
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실패:"+e);
		} catch (SQLException e) {
			System.out.println("Error:"+e);
		} finally {
			try {
				if(conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	}

}
