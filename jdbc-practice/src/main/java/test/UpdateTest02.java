package test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class UpdateTest02 {

	public static void main(String[] args) {
		update(3L, "솔루션개발");

	}

	public static boolean update(Long deptNo, String deptName) {
		boolean result = false;

		Connection conn = null;
		PreparedStatement pstmt = null;
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

			// 3. Statement 준비
			// JDBC에서는 콜론을 붙이지 않는다!
			String sql = "update dept set name=? where no=?";
			pstmt = conn.prepareStatement(sql);

			// 4. Binding
			pstmt.setString(1, deptName);
			pstmt.setLong(2, deptNo);

			// 5. SQL 실행
			int count = pstmt.executeUpdate();

			// 6. 결과 처리
			result = count == 1;
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실패:" + e);
		} catch (SQLException e) {
			System.out.println("Error:" + e);
		} finally {
			try {
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return result;
	}
}
