package emaillist.dao.test;

import java.util.List;

import emaillist.dao.EmaillistDao;
import emaillist.vo.EmaillistVo;

public class EmaillistDaoTest {

	public static void main(String[] args) {
		EmaillistVo vo = new EmaillistVo();
		vo.setFirstName("안");
		vo.setLastName("대혁");
		vo.setEmail("kickscar@gmail.com");
		
		testInsert(vo);
		testDelete("kickscar@gmail.com");
		testFindAll();
	}

	private static void testDelete(String email) {
		new EmaillistDao().deleteByEmail(email);
		
	}

	private static void testInsert(EmaillistVo vo) {
		new EmaillistDao().insert(vo);
	}

	private static void testFindAll() {
		List<EmaillistVo> list = new EmaillistDao().findAll();
		for(EmaillistVo vo : list) {
			System.out.println(vo);
		}
	}

}
